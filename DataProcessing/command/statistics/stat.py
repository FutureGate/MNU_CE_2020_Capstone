#!/usr/bin/env python
# coding: utf-8

# # 라이브러리 import

# In[1]:


import numpy as np
import pandas as pd
import matplotlib.pyplot as plt


# # 데이터 로드

# In[2]:


data_path = './data/'


# In[4]:


sale_2016 = pd.read_csv(data_path + 'train_2016.csv')
sale_2016['date'] = pd.to_datetime(sale_2016['date'], format='%Y-%m-%d')


# In[5]:


sale_2016


# In[6]:


sale_2016= sale_2016[sale_2016["store_nbr"] == 25]
sale_2016= sale_2016[sale_2016["item_nbr"] == 105574]
sale_2016


# # 데이터 전처리

# In[7]:


df = sale_2016.copy()
df['date'] = pd.to_datetime(df['date'], format='%Y-%m-%d')


# In[8]:


df.set_index(df['date'], inplace=True)
df = df.drop('date', axis=1)
df


# # 월별 통계

# ## 합산

# In[8]:


monthly_sum = df.groupby([lambda x: x.year, lambda x: x.month]).sum()


# In[9]:


monthly_sum


# In[10]:


plt.figure(figsize=(15, 7))

plt.ticklabel_format(style='plain', axis='y', scilimits=(0,0))
monthly_sum['unit_sales'].plot(kind='bar')
plt.title('Sum Of Monthly Sales In 2016')

plt.xlabel('Month')
plt.ylabel('Sales')
plt.show()


# ## 평균 & 표준편차

# In[11]:


monthly_mean = df.groupby([lambda x: x.year, lambda x: x.month]).mean()
monthly_stdev = df.groupby([lambda x: x.year, lambda x: x.month])


# In[12]:


monthly_mean


# In[13]:


monthly_stdev


# In[ ]:





# In[14]:


#p = monthly_mean['unit_sales'].plot(figsize=(15,5), legend=True, kind="bar", yerr=monthly_stdev['unit_sales']);
#p.set_title("Monthly Mean And Standard Deviation Of Sales In 2016", fontsize=18);
#p.set_xlabel("Month", fontsize=18);
#p.set_ylabel("Sales", fontsize=18);
#p.set_ylim(0,70);


# In[15]:


plt.figure(figsize=(15, 7))

plt.ticklabel_format(style='plain', axis='y', scilimits=(0,0))
monthly_mean['unit_sales'].plot(kind='bar')
plt.title('Monthly Average Sales In 2016')

plt.xlabel('Month')
plt.ylabel('Sales')
plt.show()


# # 주간 통계

# In[16]:


df = sale_2016.copy()
df['date'] = pd.to_datetime(df['date'], format='%Y-%m-%d')


# In[17]:


weekly_sum = df.groupby([pd.Grouper(key='date', freq='W-MON')])['unit_sales'].sum().reset_index().sort_values('date')


# In[18]:


plt.figure(figsize=(15, 7))

plt.ticklabel_format(style='plain', axis='y', scilimits=(0,0))
weekly_sum['unit_sales'].plot(kind='bar')
plt.title('Sum Of Weekly Sales In 2016')

plt.xlabel('Week')
plt.ylabel('Sales')
plt.show()


# In[19]:


weekly_mean = df.groupby([pd.Grouper(key='date', freq='W-MON')])['unit_sales'].mean().reset_index().sort_values('date')


# In[20]:


plt.figure(figsize=(15, 7))

plt.ticklabel_format(style='plain', axis='y', scilimits=(0,0))
weekly_mean['unit_sales'].plot(kind='bar')
plt.title('Weekly Average Sales In 2016')

plt.xlabel('Week')
plt.ylabel('Sales')
plt.show()


# # 연간 통계

# In[21]:


df = sale_2016.copy()
df['date'] = pd.to_datetime(df['date'], format='%Y-%m-%d')


# In[22]:


annual_sum = df.groupby([pd.Grouper(key='date', freq='Y')])['unit_sales'].sum().reset_index().sort_values('date')


# In[23]:


plt.figure(figsize=(15, 7))

plt.ticklabel_format(style='plain', axis='y', scilimits=(0,0))
annual_sum['unit_sales'].plot(kind='bar')
plt.title('Annual Sales Sum In 2016')

plt.xlabel('Week')
plt.ylabel('Sales')
plt.show()


# # 저장 (임시 => 추후 데이터베이스 연동)

# ## 월간 평균 저장

# In[24]:


df = monthly_mean.copy()
df = df.drop(['store_nbr', 'item_nbr'], axis=1)
df = df.reset_index()
df['date'] = pd.to_datetime(dict(year=df.level_0, month=df.level_1, day=1))
df['date'] = df['date'].dt.to_period('M')
df = df[['date', 'unit_sales']]
df.rename(columns={'unit_sales': 'sales'}, inplace=True)


# In[25]:


df.to_csv('../../Web/WebContent/monthly_mean.csv', index=False)


# ## 월간 합계 저장

# In[26]:


df = monthly_sum.copy()
df = df.drop(['store_nbr', 'item_nbr'], axis=1)
df = df.reset_index()
df['date'] = pd.to_datetime(dict(year=df.level_0, month=df.level_1, day=1))
df['date'] = df['date'].dt.to_period('M')
df = df[['date', 'unit_sales']]
df.rename(columns={'unit_sales': 'sales'}, inplace=True)


# In[27]:


df.to_csv('../../Web/WebContent/monthly_sum.csv', index=False)


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:




