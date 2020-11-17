import numpy as np
import pandas as pd
from datetime import datetime, timedelta, date

from util.DBConnector import DBConnector
from model.sale import saleDAO


def insert(anuual_df, base_date, shop_id, item_id):
    conn = DBConnector()
    db = conn.connect()

    cursor = db.cursor()

    # base date 변환
    temp = datetime.strptime(base_date, "%Y-%m-%d")
    temp = date(temp.year, 1, 1)
    sale_date = temp.strftime("%Y-%m-%d")

    for pred in anuual_df:

        sale_date = datetime.strptime(sale_date, "%Y-%m-%d")
        sale_date = sale_date + timedelta(days=1)

        sale_date = sale_date.strftime("%Y-%m-%d")

        season = get_season(sale_date)

        sql = 'insert into monthly_forecast_table values (' + \
              str(0) + ',' + \
              '\'' + str(base_date) + '\',' + \
              '\'' + str(sale_date) + '\',' + \
              '\'' + str(season) + '\',' + \
              str(shop_id) + ',' + \
              str(item_id) + ',' + \
              str(pred[0]) + \
              ');'

        cursor.execute(sql)

    db.commit()
    cursor.close()
    db.close()


def check_base_date(shop_id, item_id):
    df = saleDAO.get_sale_array(shop_id, item_id)

    if df is None or len(df) < 14:
        return 0

    base_date = datetime.strftime(df.iloc[-1:]['saleDate'].values[0], "%Y-%m-%d")
    base_date = str(base_date)

    conn = DBConnector()
    db = conn.connect()

    cursor = db.cursor()

    sql = 'select * from forecast_table where base_date >= \'' + base_date + '\' and shop_id = ' + \
          str(shop_id) + ' and item_id = ' + str(item_id) + ' order by base_date desc;'

    cursor.execute(sql)

    result = cursor.fetchall()

    for data in result:
        return -1

    db.commit()
    cursor.close()
    db.close()

    return 1


def get_season(target_date):
    month = int(datetime.strptime(target_date, "%Y-%m-%d").month)

    if month == 1 or month == 2 or month == 12:
        return 'winter'
    elif month == 3 or month == 4 or month == 5:
        return 'spring'
    if month == 6 or month == 7 or month == 8:
        return 'summer'
    if month == 9 or month == 10 or month == 11:
        return 'fall'
