import psycopg2 as psql

c = psql.connect(
    host="localhost",
    database="week4_lab_123",
    user="postgres",
    password="chandra69chandra"
)
cur = c.cursor()
cur.execute("ROLLBACK")
c.commit()

fnames=["chandra","john","kristen"]
lnames=["rao","smith","stewart"]
ssns=["abcdefP123","abcdefP124","abcdefP127"]
bdates=["1970-01-01","1965-01-01","1947-01-01"]
addrs=["bang","mum","hyd"]
salaries=[100,200,300]
dno=[1,2,3]
num_emp=3

dnames=["cs","ece","mec"]

for i in range(num_emp):
    cmd_di = f"insert into department_123 (dname,dnumber) values ('{dnames[i]}',{i+1})"
    cur.execute(cmd_di)
    c.commit()


for i in range(num_emp):
    cmd_i = f"insert into employee_123 (fname,lname,ssn,bdate,address,salary,dno) values ('{fnames[i]}','{lnames[i]}','{ssns[i]}','{bdates[i]}','{addrs[i]}',{salaries[i]},{dno[i]})"
    cur.execute(cmd_i)
    c.commit()

c.close()