import pandas as pd
import numpy as np
from DBConnector import DBConnector

# 2016 데이터 로드
data_path = './data/'

df = pd.read_csv(data_path + 'train_2016.csv')
df['date'] = pd.to_datetime(df['date'], format='%Y-%m-%d')

store_id = 25
item_id = 105574

df = df[df['store_nbr'] == store_id]
df = df[df['item_nbr'] == item_id]

conn = DBConnector()
db = conn.connect()

cursor = db.cursor()

for index, row in df.iterrows():
    date = row['date']
    shop_id = row['store_nbr']
    item_id = row['item_nbr']
    sale_count = row['unit_sales']

    sql = f"insert into `SALE_TABLE` values (0,'{date}',{int(shop_id)},{int(item_id)},{int(sale_count)});"

    cursor.execute(sql)

db.commit()
