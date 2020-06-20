#!/usr/bin/env python
# coding: utf-8

# # 라이브러리 import

# In[49]:


import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import math

import gc;gc.collect
import datetime

from subprocess import check_output


# # 데이터 로드

# In[50]:


data_path = './data/'


# In[51]:


sample_submission = pd.read_csv(data_path + 'sample_submission.csv')
test = pd.read_csv(data_path + 'test.csv')
train_2016 = pd.read_csv(data_path + 'train_2016.csv')

date_list=np.unique(train_2016["date"])


# # PreProcessing

# ### 메모리 소모 감소 ( 최적화 )

# In[52]:


memo = train_2016.memory_usage(index=True).sum()
print(memo/ 1024**2," MB")


# In[53]:


print(train_2016.dtypes)


# In[54]:


train_2016['store_nbr'] = train_2016['store_nbr'].astype(np.int8)
train_2016['item_nbr'] = train_2016['item_nbr'].astype(np.int32)
train_2016['unit_sales'] = train_2016['unit_sales'].astype(np.int8)


# In[55]:


memo = train_2016.memory_usage(index=True).sum()
print(memo/ 1024**2," MB")


# In[56]:


train_2016


# ### 특정 판매점, 특정 상품 1개씩 선택

# In[57]:


train_2016_25= train_2016[train_2016["store_nbr"] == 25]
train_2016_25_105574= train_2016_25[train_2016_25["item_nbr"] == 105574]
train_2016_25_105574.drop("store_nbr",axis=1,inplace=True)
train_2016_25_105574.drop("item_nbr",axis=1,inplace=True)
train_2016_25_105574


# In[58]:


train_copy = train_2016_25_105574.copy()

train_copy.set_index('date')


# In[59]:


train_copy.plot(figsize=(15, 7))
plt.ticklabel_format(style='plain', axis='x', scilimits=(0,0))
plt.show()


# In[60]:


df_date=pd.DataFrame(date_list)
df_date = df_date.rename(columns={0: 'date'})
df_date.head()


# In[61]:


df = pd.merge(df_date, train_2016_25_105574, how='left', on=['date'])
df.fillna(0,inplace=True)

df.tail()


# In[62]:


df.plot(figsize=(15, 10))

plt.title('Sales Data')
plt.xlabel('Days')
plt.ylabel('Sales')

plt.show()
df.describe()

df['date'] = pd.to_datetime(df['date'], format='%Y-%m-%d')


# # 학습, 테스트 셋 준비

# In[63]:


from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense,Dropout
from tensorflow.keras.layers import LSTM
from sklearn.preprocessing import MinMaxScaler
from sklearn.metrics import mean_squared_error


# In[64]:


# fix random seed for reproducibility
np.random.seed(7)


# In[65]:


df['date'] = pd.to_datetime(df['date'], format='%Y-%m-%d')
train, test =df[df["date"].dt.month <= 9], df[df["date"].dt.month > 9]


# In[66]:


train


# In[67]:


test


# In[68]:


# split into train and test sets
train=train.set_index("date")
test=test.set_index("date")
df=df.set_index("date")
train=train.values
test=test.values
df=df.values


# In[69]:


def create_dataset(dataset, look_back=1):
    dataX, dataY = [], []
    for i in range(len(dataset)-look_back-1):
        a = dataset[i:(i+look_back), 0]
        dataX.append(a)
        dataY.append(dataset[i + look_back, 0])
    return np.array(dataX), np.array(dataY)


# In[70]:


# reshape into X=t and Y=t+1
look_back = 7
trainX, trainY = create_dataset(train, look_back)
testX, testY = create_dataset(test, look_back)


# In[71]:



# reshape input to be [samples, time steps, features]
trainX = np.reshape(trainX, (trainX.shape[0], 1, trainX.shape[1]))
testX = np.reshape(testX, (testX.shape[0], 1, testX.shape[1])) 


# In[72]:


len(trainX), len(testX)


# # LSTM 모델 빌드 및 학습

# In[73]:


# create and fit the LSTM network
model = Sequential()
model.add(LSTM(60, activation='relu', input_shape=(1, look_back)))
model.add(Dropout(0.2))
model.add(Dense(10))
model.add(Dropout(0.2))
model.add(Dense(1))
model.summary()


# In[74]:


model.compile(loss='mean_squared_error', optimizer='adam', metrics=['accuracy'])


# In[75]:


model.fit(trainX, trainY, epochs=500, batch_size=1, verbose=1)


# # 예측 및 평가

# In[76]:


trainPredict = model.predict(trainX)
testPredict = model.predict(testX)


# In[77]:


plt.figure(figsize=(16,8))

trainPredictPlot = np.empty_like(df)
trainPredictPlot[:, :] = np.nan
trainPredictPlot[look_back:len(trainPredict)+look_back, :] = trainPredict

testPredictPlot = np.empty_like(df)
testPredictPlot[:, :] = np.nan
testPredictPlot[len(trainPredict)+(look_back*2)+1:len(df)-1, :] = testPredict

plt.title('Sale Prediction Result')
plt.xlabel('Days')
plt.ylabel('Sale')

plt.plot(df, color='grey', label='OriginalData')
plt.plot(trainPredictPlot, color='red', label='TrainSet Prediction')
plt.plot(testPredictPlot, color='green', label='TestSet Prediction')

plt.legend()
plt.show()


# In[80]:


scores = model.evaluate(testX, testY)
print("%s: %.2f%%" %(model.metrics_names[1], scores[1]*100))


# # 데이터 저장

# In[102]:


org = df
org = pd.DataFrame(org, columns=list("d"))
org = org[:281]
org.index.name = 'days'
org = org.reset_index()
org.rename(columns={'d': 'sales'}, inplace=True)
org


# In[103]:


org.to_csv('../../Web/WebContent/origin_data.csv', index = False)


# In[104]:


pred_df = pd.DataFrame(testPredictPlot, columns=list("d"))
pred_df = pred_df[281:364]
pred_df
pred_df.index.name = 'days'
pred_df = pred_df.reset_index()
pred_df.rename(columns={'d': 'sales'}, inplace=True)
pred_df


# In[105]:


pred_df.to_csv('../../Web/WebContent/pred_data.csv', index = False)

