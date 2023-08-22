import sys, os 
import psycopg2 as ps 
database = sys.argv[1]	
user = os.environ.get('PGUSER') 
password = os.environ.get('PGPASSWORD') 
host = os.environ.get('PGHOST')
port = os.environ.get('PGPORT')

conn = ps.connect(database = database, user = user, password = password, host = host, port = port)
curr = conn.cursor()

f = open('player.txt')
for name in f : 
    pname = name 
    
curr.execute(f"""
    SELECT jersey_no FROM players WHERE name = '{pname}'
""")
    
rows = curr.fetchall()
for row in rows : 
    print(row[0])
curr.close()
conn.close()