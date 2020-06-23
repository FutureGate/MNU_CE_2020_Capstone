import numpy as np
import pandas as pd
import datetime

from util.DBConnector import DBConnector


# 요청 상태 종류
# - 처리 중
# - 오류 발생
# - 완료


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


def get_recently_trained_request_date(shop_id, item_id):
    conn = DBConnector()
    db = conn.connect()

    cursor = db.cursor()

    sql = 'select * from request_table where trained = 1 and shop_id = ' + \
          str(shop_id) + 'and item_id = ' + str(item_id) + ' order by request_date desc;'

    cursor.execute(sql)

    result = cursor.fetchall()

    request_date = None

    for data in result:
        request_date = str(data[3])

    db.commit()
    cursor.close()
    db.close()

    return request_date


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
          ', 0' + \
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


def setTrained(request_id, trained):
    conn = DBConnector()
    db = conn.connect()

    cursor = db.cursor()

    sql = 'update request_table set trained = \'' + \
          trained + '\' where request_id = ' + str(request_id) + ';'

    cursor.execute(sql)
    db.commit()
    cursor.close()
    db.close()
