"""
create connection 
create cursor 
execute query 
commit/rollback 
close the cursor 
close the connection
"""

import psycopg2 as ps 
def conectDb(dbname, username, pwd, address, portnum) :
    conn = None 
    try : 
        conn = ps.connect(
                database = dbname, user = username, password = pwd, 
                host = address, port = portnum
            )
        print('database connected successfully')

    except (Exception, ps.DatabaseError) as error: 
        print(error)

    finally : 
        conn.close()

def createTable(dbname, username, pwd, address, portnum) : 
    conn = None 
    try : 
        conn = ps.connect(
                database = dbname, user = username, password = pwd, 
                host = address, port = portnum
            )
        cur = conn.cursor()
        cur.execute("""
            CREATE TABLE EMPLOYEE(
                emp_num INT PRIMARY KEY NOT NULL, 
                emp_name VARCHAR(40) NOT NULL, 
                departmnet VARCHAR(40) NOT NULL
            ) 
        """)
        cur.commit()
        print('table created')
        cur.close()

    except (Exception, ps.DatabaseError) as error: 
        print(error)

    finally : 
        if conn is not None : 
            conn.close()

def insertRecord(dbname, username, pwd, address, portnum, num, name, dept) : 
    conn = None 
    try : 
        conn = ps.connect(
                database = dbname, user = username, password = pwd, 
                host = address, port = portnum
            )
        cur = conn.cursor()
        cur.execute(f"""
            INSERT INTO EMPLOYEE(emp_num, emp_name, departmnet) 
            VALUES({num}, {name}, {dept})
        """)
        cur.commit()
        print('inserted')
        cur.close()

    except (Exception, ps.DatabaseError) as error: 
        print(error)

    finally : 
        if conn is not None : 
            conn.close()

def deleteRecord(dbname, username, pwd, address, portnum, num) : 
    conn = None 
    try : 
        conn = ps.connect(
                database = dbname, user = username, password = pwd, 
                host = address, port = portnum
            )
        cur = conn.cursor()
        cur.execute(f"""
            DELETE FROM EMPLOYEE WHERE emp_num = {num}
        """)
        cur.commit()
        print('deleted', cur.rowcount)
        cur.close()

    except (Exception, ps.DatabaseError) as error: 
        print(error)

    finally : 
        if conn is not None : 
            conn.close()


def selectAll(dbname, username, pwd, address, portnum) : 
    conn = None 
    try : 
        conn = ps.connect(
                database = dbname, user = username, password = pwd, 
                host = address, port = portnum
            )
        cur = conn.cursor()
        cur.execute("""
            SELECT * FROM EMPLOYEE
        """)
        rows = cur.fetchall()
        for row in rows : 
            print('emp_id', row[0], 'name', row[1], 'dept', row[2])

        cur.close()

    except (Exception, ps.DatabaseError) as error: 
        print(error)

    finally : 
        if conn is not None : 
            conn.close()

