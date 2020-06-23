import numpy as np
import pandas as pd
from datetime import datetime, timedelta

from util.DBConnector import DBConnector


def insert(sum_df, avg_df, base_date, shop_id, item_id):
    conn = DBConnector()
    db = conn.connect()

    cursor = db.cursor()

    for i, row in sum_df.iterrows():

        stat_date = row['saleDate']
        stat_date = str(stat_date) + '-01'

        saleSum = row['saleCount']
        saleAvg = avg_df.iloc[i]['saleCount']
        saleAvg = round(saleAvg, 3)

        sql = 'insert into stat_table values (' + \
            str(0) + ',' + \
            '\'' + str(base_date) + '\',' + \
            '\'' + str(stat_date) + '\',' + \
            str(shop_id) + ',' + \
            str(item_id) + ',' + \
            str(saleSum) + ',' + \
            str(saleAvg) + \
            ');'

        cursor.execute(sql)

    db.commit()
    cursor.close()
    db.close()
