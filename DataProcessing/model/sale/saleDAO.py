import numpy as np
import pandas as pd

from util.DBConnector import DBConnector


def get_sale_array(shop_id, item_id):
    conn = DBConnector()
    db = conn.connect()

    cursor = db.cursor()

    sql = "select * from sale_table where sale_date < now() and shop_id=" + str(shop_id) + " and item_id=" + str(item_id) + ";"

    cursor.execute(sql)

    result = cursor.fetchall()

    sale_list =[]

    for data in result:
        sale_list.append(data)

    if len(sale_list) is 0:
        return None

    sale_array = np.asarray(sale_list)

    df = pd.DataFrame(sale_array,
                      columns=['saleID', 'saleDate', 'shopID', 'itemID', 'saleCount'])

    df = df.drop('saleID', axis=1)

    db.commit()
    cursor.close()
    db.close()

    return df


def get_sale_array_asc(shop_id, item_id):
    conn = DBConnector()
    db = conn.connect()

    cursor = db.cursor()

    sql = "select * from sale_table where sale_date < now() and shop_id=" + str(shop_id) + " and item_id=" + str(item_id) + " order by sale_date asc;"

    cursor.execute(sql)

    result = cursor.fetchall()

    sale_list = []

    for data in result:
        sale_list.append(data)

    if len(sale_list) is 0:
        return None

    sale_array = np.asarray(sale_list)

    df = pd.DataFrame(sale_array,
                      columns=['saleID', 'saleDate', 'shopID', 'itemID', 'saleCount'])

    df = df.drop('saleID', axis=1)

    db.commit()
    cursor.close()
    db.close()

    return df
