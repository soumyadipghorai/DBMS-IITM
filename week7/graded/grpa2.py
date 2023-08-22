
f = open('parameter.txt')
for i in f:
    p = i

import sys, os
import psycopg2 as ps
import math
database = sys.argv[1] #name of the database is obtained from the command line argument
user = os.environ.get('PGUSER') 
password = os.environ.get('PGPASSWORD') 
host = os.environ.get('PGHOST')
port = os.environ.get('PGPORT')

q = '''select sum(m.host_team_score) as Total_Score from matches m
left join match_referees mr on m.match_num=mr.match_num
left join teams t on t.team_id=m.host_team_id
where m.host_team_score>m.guest_team_score and t.name like ''' + "'" + p +"%'"
conn = ps.connect(database=database,user=user,password=password,host=host,port=port)
cur = conn.cursor()
cur.execute(q)
t = cur.fetchall()
for j in t:
    n = j[0]
    print(round(math.cos(n*10*(math.pi/180)),2))
cur.close()
conn.close()