import sys, os 
import psycopg2 as ps 

database = sys.argv[1]	#//name of the database is obtained from the command line argument
user = os.environ.get('PGUSER') 
password = os.environ.get('PGPASSWORD') 
host = os.environ.get('PGHOST')
port = os.environ.get('PGPORT')

f = open('name.txt')
for r in f : 
    name = r 
    
conn = ps.connect(database = database, user = user, password = password, host = host, port = port)
curr = conn.cursor()
curr.execute(f"""
    SELECT S.student_fname, D.department_name, S.dob FROM students S 
    JOIN departments D 
    ON D.department_code = S.department_code
    WHERE S.student_fname = '{name}'
""")

rows = curr.fetchall()
for row in rows :
    if int(str(row[2]).split('-')[0])%2 == 0 :
        print(f'{row[0]},{row[1]},Even')
    else : 
        print(f'{row[0]},{row[1]},Odd')
        
curr.close()
conn.close()