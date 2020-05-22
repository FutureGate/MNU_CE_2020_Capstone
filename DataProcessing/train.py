import numpy as np
import pandas as pd
import seaborn as sns
import math

import gc;

gc.collect
import datetime

from subprocess import check_output

from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense,Dropout
from tensorflow.keras.layers import LSTM
from sklearn.preprocessing import MinMaxScaler
from sklearn.metrics import mean_squared_error

class Train:
    data_path = './data/'
    shop_id = 0
    item_id = 0

    df = None

    train = None
    test = None

    def __init__(self):
        self.shop_id = 0
        self.item_id = 0

    def set_shop_id(self, shop_id):
        self.shop_id = shop_id

    def set_item_id(self, item_id):
        self.item_id = item_id

    def prepare_data(self):

        df = pd.read_csv(self.data_path + 'train_2016.csv')
        date_list = np.unique(df["date"])

        df = df[df['store_nbr'] == self.shop_id]
        df = df[df['item_nbr'] == self.item_id]

        df.drop("store_nbr", axis=1, inplace=True)
        df.drop("item_nbr", axis=1, inplace=True)

        train_copy = df.copy()
        train_copy.set_index('date')

        df_date = pd.DataFrame(date_list)
        df_date = df_date.rename(columns={0: 'date'})

        df = pd.merge(df_date, df, how='left', on=['date'])
        df.fillna(0, inplace=True)

        np.random.seed(7)

        df['date'] = pd.to_datetime(df['date'], format='%Y-%m-%d')
        train, test = df[df['date'].dt.month <= 9], df[df['date'].dt.month > 9]

        train = train.set_index('date')
        test = test.set_index('date')
        df = df.set_index('date')

        self.train = train.values
        self.test = test.values
        self.df = df.values

        look_back = 7

        trainX, trainY = self.create_dataset(train, look_back)
        testX, testY = self.create_dataset(test, look_back)
        trainX = np.reshape(trainX, (trainX.shape[0], 1, trainX.shape[1]))
        testX = np.reshape(testX, (testX.shape[0], 1, testX.shape[1]))

    def create_dataset(self, dataset, look_back = 1):
        dataX, dataY = [], []

        for i in range(len(dataset) - look_back - 1):
            a = dataset[i:(i + look_back), 0]
            dataX.append(a)
            dataY.append(dataset[i + look_back, 0])

        return np.array(dataX), np.array(dataY)