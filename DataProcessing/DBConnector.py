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
        self.loadConfig()

    def loadConfig(self):
        file = open("dbConfig.conf", "r")

        lines = file.readlines()

        for line in lines:
            line = line.split(sep='\n')[0]
            val = line.split(sep=':')

            title = val[0]
            value = val[1]

            if title == 'host':
                self.host = value
            elif title == 'port':
                self.port = value
            elif title == 'id':
                self.id = value
            elif title == 'password':
                self.password = value
            elif title == 'db_name':
                self.db_name = value

        file.close()

    def connect(self):
        db = pymysql.connect(
            host=self.host,
            port=self.port,
            user=self.id,
            passwd=self.password,
            db=self.db_name,
            charset=self.charset
        )


dbconn = DBConnector()
dbconn.connect()

