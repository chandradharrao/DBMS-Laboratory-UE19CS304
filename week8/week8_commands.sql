-- group by srn
-- use having to count number of dependents
-- print if more than 2
SELECT e.fname 
FROM employee e
INNER JOIN 
(SELECT d.essn 
FROM dependent d
GROUP BY d.essn
HAVING COUNT(*)>=2) as T
ON e.ssn=T.essn

SELECT e.fname
from employee e
inner join dependent d
on e.ssn=d.essn
WHERE e.fname=d.dependent_name and e.gender=d.gender;

select e.fname
from employee
where 
e.salary>(select SUM(e1.salary)
from employee e1
where e1.dno=5);

select e.fname
from employee
where 
e.salary>(select MAX(e1.salary)
from employee e1
where e1.dno=5);

select e.fname
from employee e
WHERE not EXISTS (
    SELECT d.dependent_name
    from dependent d
    where d.essn=e.ssn
);

select e.fname
from employee e
inner join department dep
on e.ssn=dep.mgr_ssn
WHERE dep.mgr_ssn IN (select d.essn
from dependent d
GROUP BY d.essn
HAVING COUNT(*)>=1);


select e.fname,e.address
from employee e
natural join department d
where d.dname='Research';
