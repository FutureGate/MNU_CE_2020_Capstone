import numpy as np
import pandas as pd
import seaborn as sns
import math

import gc;gc.collect

from datetime import date, datetime

import os

from model.sale import saleDAO

from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Dropout
from tensorflow.keras.layers import LSTM
from sklearn.preprocessing import MinMaxScaler
from sklearn.metrics import mean_squared_error

from tensorflow.keras.callbacks import ModelCheckpoint
from tensorflow.keras.models import model_from_json

from model.forecast import forecastDAO
from model.request import requestDAO

weight_path = 'C:/weights/'


def create_date_list(start_date, end_date):
    date_range = pd.date_range(start_date, end_date)

    date_list = []

    for date in date_range:
        date_list.append(date.strftime("%Y-%m-%d"))

    date_list = np.asarray(date_list)
    df_date = pd.DataFrame(date_list, columns=['saleDate'])

    return df_date


def str_to_int_date(date):
    year = int(date.split('-')[0])
    month = int(date.split('-')[1])
    day = int(date.split('-')[2])

    return year, month, day


def start_train(shop_id, item_id):
    filename = ''
    model_filename = ''
    weight_filename = ''

    # 데이터 로드
    df = saleDAO.get_sale_array(shop_id, item_id)
    df.drop("shopID", axis=1, inplace=True)
    df.drop("itemID", axis=1, inplace=True)

    print(df)

    # 판매량이 없는 날짜 0으로 채우기

    start_date_df = df[:1]
    end_date_df = df[-1:]

    start_date = str(start_date_df.iloc[0]['saleDate'])
    end_date = str(end_date_df.iloc[0]['saleDate'])
    start_year, start_month, start_day = str_to_int_date(start_date)
    end_year, end_month, end_day = str_to_int_date(end_date)

    start_date = date(start_year, start_month, start_day)
    end_date = date(end_year, end_month, end_day)

    df_date = create_date_list(start_date, end_date)

    pd.set_option('display.max_rows', df_date.shape[0] + 1)

    df['saleDate'] = pd.to_datetime(df['saleDate'], format='%Y-%m-%d')
    df_date['saleDate'] = pd.to_datetime(df_date['saleDate'], format='%Y-%m-%d')

    df = pd.merge(df_date, df, how='left', on=['saleDate'])
    df.fillna(0, inplace=True)
    df['saleDate'] = pd.to_datetime(df['saleDate'], format='%Y-%m-%d')

    pd.set_option('display.max_rows', df.shape[0] + 1)

    # train, test 셋 나누기
    total_idx = len(df) - 1
    train_idx = int(total_idx * 0.7)
    test_idx = total_idx - train_idx

    # print(total_idx, '@', train_idx, '@', test_idx)
    np.random.seed(7)

    df['saleDate'] = pd.to_datetime(df['saleDate'], format='%Y-%m-%d')
    train, test = df[:train_idx], df[train_idx:total_idx]

    train = train.set_index("saleDate")
    test = test.set_index("saleDate")
    df = df.set_index("saleDate")
    train = train.values
    test = test.values
    df = df.values

    # 데이터 셋 생성
    look_back = 7
    trainX, trainY = create_dataset(train, look_back)
    testX, testY = create_dataset(test, look_back)

    trainX = np.reshape(trainX, (trainX.shape[0], 1, trainX.shape[1]))
    testX = np.reshape(testX, (testX.shape[0], 1, testX.shape[1]))

    # model 생성
    model = Sequential()
    model.add(LSTM(60, activation='relu', input_shape=(1, look_back)))
    model.add(Dropout(0.2))
    model.add(Dense(10))
    model.add(Dropout(0.2))
    model.add(Dense(1))
    model.summary()

    # model 컴파일
    model.compile(loss='mean_squared_error', optimizer='adam', metrics=['accuracy'])

    # 학습
    model.fit(trainX, trainY, epochs=10, batch_size=1, verbose=1)

    model_filename = weight_path + str(shop_id) + '_' + str(item_id) + '.json'
    weight_filename = weight_path + str(shop_id) + '_' + str(item_id) + '.h5'

    model_json = model.to_json()

    with open(model_filename, 'w') as json_file:
        json_file.write(model_json)

    model.save_weights(weight_filename)


def start_predict(shop_id, item_id):
    filename = ''
    model_filename = ''
    weight_filename = ''

    model_filename = weight_path + str(shop_id) + '_' + str(item_id) + '.json'
    weight_filename = weight_path + str(shop_id) + '_' + str(item_id) + '.h5'

    if not (os.path.isfile(model_filename) or os.path.isfile(weight_filename)):
        start_train(shop_id, item_id)

    if check_trained(shop_id, item_id) is False:
        start_train(shop_id, item_id)

    json_file = open(model_filename, 'r')

    model_json = json_file.read()
    json_file.close()

    model = model_from_json(model_json)

    model.load_weights(weight_filename)

    model.compile(loss='mean_squared_error', optimizer='adam', metrics=['accuracy'])

    # 데이터 로드
    df = saleDAO.get_sale_array(shop_id, item_id)

    # 판매량이 없는 날짜 0으로 채우기
    date_list = np.unique(df['saleDate'])
    df_date = pd.DataFrame(date_list)

    # 날짜 형식으로 맞추기
    df_date = df_date.rename(columns={0: 'saleDate'})

    df = pd.merge(df_date, df, how='left', on=['saleDate'])
    df.fillna(0, inplace=True)
    df['saleDate'] = pd.to_datetime(df['saleDate'], format='%Y-%m-%d')

    df = df.set_index("saleDate")
    df = df.values

    # 데이터 셋 생성
    look_back = 7

    idx = look_back * -1;

    test_data = []
    a = df[idx:, 0]
    test_data.append(a)

    result = []

    for i in range(0, 10):
        data = test_data

        data = np.reshape(data, (data.shape[0], 1, data.shape[1]))
        prediction = model.predict(data)
        result.append(prediction)

        test_data.pop(0)
        test_data.append(prediction)

    print(result)


def create_dataset(dataset, look_back=1):
    dataX, dataY = [], []
    for i in range(len(dataset)-look_back-1):
        a = dataset[i:(i+look_back), 0]
        dataX.append(a)
        dataY.append(dataset[i + look_back, 0])
    return np.array(dataX), np.array(dataY)

def check_trained(shop_id, item_id):
    current_time = datetime.now()
    target_time = requestDAO.get_recently_trained_request_date(shop_id, item_id)

    if (current_time - target_time).days >= 7:
        return False

    return True


start_predict(1, 3)