import psycopg2
try:
    connection = psycopg2.connect(user = "adempiere",
                                  password = "adempiere",
                                  host = "127.0.0.1",
                                  port = "5432",
                                  database = "pw")
    cursor = connection.cursor()
    print( connection.get_dsn_parameters(),"\n")
    cursor.execute("SELECT version();")
    record = cursor.fetchone()
    print("sei connesso a ",record,"\n")
except(Exception,psycopg2.Error) as error:
    print("errore nella connesione a Postgres",error)
finally:
    if(connection):
        cursor.close()
        conection.close()
        print("la connesione a PG è stata chiusa")
