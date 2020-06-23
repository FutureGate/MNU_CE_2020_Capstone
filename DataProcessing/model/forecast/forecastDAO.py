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
