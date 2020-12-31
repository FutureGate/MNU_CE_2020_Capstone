import numpy as np
import pandas as pd
from datetime import datetime, timedelta

from util.DBConnector import DBConnector
from model.sale import saleDAO


def insert(result, base_date, shop_id, item_id):
    conn = DBConnector()
    db = conn.connect()

    cursor = db.cursor()

    sale_date = base_date

    for pred in result:

        sale_date = datetime.strptime(sale_date, "%Y-%m-%d")
        sale_date = sale_date + timedelta(days=1)

        sale_date = sale_date.strftime("%Y-%m-%d")

        sql = 'insert into forecast_table values (' + \
              str(0) + ',' + \
              '\'' + str(base_date) + '\',' + \
              '\'' + str(sale_date) + '\',' + \
              str(shop_id) + ',' + \
              str(item_id) + ',' + \
              str(pred[0]) + \
              ');'

        cursor.execute(sql)

    db.commit()
    cursor.close()
    db.close()


def check_base_date(shop_id, item_id):
    df = saleDAO.get_sale_array_asc(shop_id, item_id)

    max_sale_date_str = datetime.strftime(df.iloc[-1:]['saleDate'].values[0], "%Y-%m-%d")
    max_sale_date_str = str(max_sale_date_str)

    if df is None or len(df) < 14:
        # 데이터가 14개 이하일 경우
        return 0

    # ============================================================================

    conn = DBConnector()
    db = conn.connect()

    cursor = db.cursor()

    sql = 'select * from forecast_table where shop_id = ' + \
          str(shop_id) + ' and item_id = ' + str(item_id) + ' order by base_date desc;'

    cursor.execute(sql)

    result = cursor.fetchall()

    if len(result) != 0:
        recent_base_date = result[0][1]
        recent_base_date = datetime.strftime(recent_base_date, "%Y-%m-%d")

        db.commit()
        cursor.close()
        db.close()

        max_sale_date = datetime.strptime(max_sale_date_str, "%Y-%m-%d")
        recent_base_date = datetime.strptime(recent_base_date, "%Y-%m-%d")

        diff_date = max_sale_date - recent_base_date

        if diff_date < timedelta(days=1):
            return -2

    # ============================================================================

    conn = DBConnector()
    db = conn.connect()

    cursor = db.cursor()

    sql = 'select * from forecast_table where base_date >= \'' + max_sale_date_str + '\' and shop_id = ' + \
          str(shop_id) + ' and item_id = ' + str(item_id) + ' order by base_date desc;'

    cursor.execute(sql)

    result = cursor.fetchall()

    for data in result:
        return -1

    db.commit()
    cursor.close()
    db.close()

    return 1
