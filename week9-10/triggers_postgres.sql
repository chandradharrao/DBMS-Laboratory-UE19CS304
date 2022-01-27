drop table if exists department;
drop table if exists employee;
drop function if exists change_emp_count;
drop function if exists inc_emp_count;
drop function if exists dec_emp_count;

CREATE TABLE employee(
    id serial not null,
    name text not null,
    ssn char(3) not null,

    dept_id integer not null
);

CREATE TABLE department(
    id serial not null,
    name text not null,
    num_emps INTEGER not NULL
);

--Trigger function
CREATE FUNCTION inc_emp_count()
    RETURNS TRIGGER
    LANGUAGE  PLPGSQL
AS $$
BEGIN
    update department set num_emps = num_emps+1
    where id = new.dept_id; --new refers to the record isnerted
    return NULL;
END;
$$;

create function dec_emp_count()
    returns trigger
    language plpgsql
as $$
BEGIN
    update department set num_emps = num_emps -1
    where id=old.dept_id; --old : refers to the value deleted
    return old; --return NOT NULL
END;
$$;

--creating the trigger itself
create trigger tr_tblEmployee_ForInsert
After insert
on employee
for each row
execute procedure inc_emp_count();

create trigger tr_tblEmployee_ForDelete
after delete
on employee
for each row
execute procedure dec_emp_count();

--insert statements
insert into department (name,num_emps) values ('IT',0),('ME',0),('PSY',0),('EEE',0);
insert into employee (name,ssn,dept_id) values ('emma','123',1),('mia','124',1),('dwayne','125',1),('ethan','126',3),('rahane','127',3),('virat','128',4),('zazai','129',2),('mujeeb','130',4);

--display updated tables
select * from department;
select * from employee;

--delete commands
delete from employee where id=3;
delete from employee where id=4;
delete from employee where id=2;

--display the tables
select * from department;
select * from employee;

