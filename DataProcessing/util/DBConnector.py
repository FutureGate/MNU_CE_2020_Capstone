import pymysql


class DBConnector:
    db = None
    host = "127.0.0.1"
    port = 11081
    id = "capstone"
    password = "zoqtmxhs"
    db_name = "demand_prediction"
    charset = 'utf8'

    def __init__(self):
        pass

    def __new__(cls):
        if not hasattr(cls, 'instance'):
            cls.instance = super(DBConnector, cls).__new__(cls)
        return cls.instance

    def connect(self):

        self.db = pymysql.connect(
            host=self.host,
            port=self.port,
            user=self.id,
            passwd=self.password,
            db=self.db_name,
            charset=self.charset
        )

        return self.db