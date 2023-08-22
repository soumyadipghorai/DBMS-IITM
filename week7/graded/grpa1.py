import sys, os
import psycopg2 as ps
import pandas as pd
database = sys.argv[1] #name of the database is obtained from the command line argument
user = os.environ.get('PGUSER') 
password = os.environ.get('PGPASSWORD') 
host = os.environ.get('PGHOST')
port = os.environ.get('PGPORT')

f = open('date.txt')
for i in f:
    d = i
q = '''select r.name, mr.referee from public.matches m
left join public.match_referees mr on m.match_num=mr.match_num
left join public.referees r on r.referee_id=mr.referee where m.match_date = ''' + "'"+d+"'"
conn = ps.connect(database=database,user=user,password=password,host=host,port=port)
cur = conn.cursor()
cur.execute(q)
t = cur.fetchall()
for j in t:
    temp = ''
    p=j[0].split(' ')
    for k in p[:-1]:
        temp=temp+k[0]+'. '
    print(p[-1],temp[:-1])
    
cur.close()
conn.close()
