import pymysql


class DBConnector:
    db = None
    host = None
    port = None
    id = None
    password = None
    db_name = None
    charset = 'utf8'

    def __init__(self):
        self.load_config()

    def __new__(cls):
        if not hasattr(cls, 'instance'):
            cls.instance = super(DBConnector, cls).__new__(cls)
        return cls.instance

    def load_config(self):
        file = open("dbConfig.conf", "r")

        lines = file.readlines()

        print('connection information >>> ')

        for line in lines:
            line = line.split(sep='\n')[0]
            val = line.split(sep=':')

            title = val[0]
            value = val[1]

            print(title, ':', value)

            if title == 'host':
                self.host = value
            elif title == 'port':
                self.port = int(value)
            elif title == 'id':
                self.id = value
            elif title == 'password':
                self.password = value
            elif title == 'db_name':
                self.db_name = value

        file.close()

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