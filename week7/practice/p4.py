import sys, os 
import psycopg2 as ps 

f = open('name.txt')
for name in f : 
    fname = name 

database = sys.argv[1]	#//name of the database is obtained from the command line argument
user = os.environ.get('PGUSER') 
password = os.environ.get('PGPASSWORD') 
host = os.environ.get('PGHOST')
port = os.environ.get('PGPORT')
conn = ps.connect(database = database, user = user, password = password, host = host, port = port)
curr = conn.cursor()
curr.execute(f"""
    SELECT roll_no FROM students WHERE student_fname = '{fname}'
""")

rows = curr.fetchall()
for row in rows : 
    print(row[0])