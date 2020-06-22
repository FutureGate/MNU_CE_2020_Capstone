import numpy as np
import pandas as pd
import datetime

from util.DBConnector import DBConnector

def get_current_request_id():
    conn = DBConnector()
    db = conn.connect()

    cursor = db.cursor()

    sql = 'select * from request_table order by request_date desc;'

    cursor.execute(sql)

    result = cursor.fetchall()

    request_id = None

    for data in result:
         request_id = int(data[0])

    db.commit()
    cursor.close()
    db.close()

    return request_id


def add(shop_id, item_id):
    conn = DBConnector()
    db = conn.connect()

    cursor = db.cursor()

    now = datetime.datetime.now()
    request_date = now.strftime('%Y-%m-%d')

    print(type(request_date))

    sql = 'insert into request_table values (' + \
        str(0) + ',' + \
        str(shop_id) + ',' + \
        str(item_id) + ',' + \
        '\'' + request_date + '\',' + \
        '\'처리 중\'' + \
        ');'

    print(sql)

    cursor.execute(sql)
    db.commit()
    cursor.close()
    db.close()

    return get_current_request_id()


def setState(request_id, state):
    conn = DBConnector()
    db = conn.connect()

    cursor = db.cursor()

    sql = 'update request_table set state = \'' + \
        state + '\' where request_id = ' + str(request_id) + ';'

    cursor.execute(sql)
    db.commit()
    cursor.close()
    db.close()


setState(4, '테스트')