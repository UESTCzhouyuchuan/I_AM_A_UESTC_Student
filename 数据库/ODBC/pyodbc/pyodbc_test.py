"""
https://github.com/mkleehammer/pyodbc/wiki/Connecting-to-PostgreSQL
官方文档，学习pyodbc在postgreSQL的配置以及用法
"""
# 载入pyodbc模块
import pyodbc


def initConnec(DSN, PWD):
    try:
        connec = pyodbc.connect("DSN={0};PWD={1}".format(DSN, PWD))
        # connec.setdecoding(pyodbc.SQL_WCHAR, encoding='utf-8')
        # connec.setencoding(encoding='utf-8')
    except:
        print("Connect fail")
    else:
        print("Connect success")
        return connec


def enQuery(cursor, tableName):
    rows=cursor.execute("select * from {}".format(tableName))
    print("table cursor: ", type(rows), cursor)
    print("**************************************************************\ntable cursor.descroption:")
    for item in cursor.description:
        print(item)
    print("**************************************************************")
    for column in cursor.description:
        print(column[0], end='\t')
    print()
    for row in cursor:
        print(row)


# connect postgreSQL using DSN and password
connec = initConnec("PostgreSQL35W", "081849")
print("Connection: ", connec)
# create cursor for database
cursor = connec.cursor()
print("Cursor: ", cursor)
# query with cursor and tableName
enQuery(cursor, "project")
