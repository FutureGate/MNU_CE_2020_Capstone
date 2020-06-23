import numpy as np
import pandas as pd

from datetime import datetime

from model.sale import saleDAO
from model.statistics import statDAO
from model.request import requestDAO

def start_stat(shop_id, item_id, request_id):

    df = saleDAO.get_sale_array(shop_id, item_id)

    if df is None:
        requestDAO.setState(request_id, '오류 발생')
        return

    base_date = datetime.strftime(df.iloc[-1:]['saleDate'].values[0], "%Y-%m-%d")

    # 전처리
    df['saleDate'] = pd.to_datetime(df['saleDate'], format='%Y-%m-%d')
    df['saleCount'] = pd.to_numeric(df['saleCount'], downcast='signed')
    df.set_index(df['saleDate'], inplace=True)

    df = df.drop('saleDate', axis=1)

    # 합계, 평균 계산
    sum_df = sum_sale(df)
    avg_df = avg_sale(df)

    statDAO.insert(sum_df, avg_df, base_date, shop_id, item_id)


def sum_sale(df):
    df = df.groupby([lambda x: x.year, lambda x: x.month]).sum()

    df = df.reset_index()

    df['saleDate'] = pd.to_datetime(dict(year=df.level_0, month=df.level_1, day=1))
    df['saleDate'] = df['saleDate'].dt.to_period('M')
    df = df[['saleDate', 'saleCount']]

    return df


def avg_sale(df):
    df = df.groupby([lambda x: x.year, lambda x: x.month]).mean()

    df = df.reset_index()

    df['saleDate'] = pd.to_datetime(dict(year=df.level_0, month=df.level_1, day=1))
    df['saleDate'] = df['saleDate'].dt.to_period('M')
    df = df[['saleDate', 'saleCount']]

    return df
