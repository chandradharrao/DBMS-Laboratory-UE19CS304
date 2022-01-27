\c company

    (SELECT DISTINCT w.pno
    FROM works_on w INNER JOIN employee e ON w.essn=e.ssn
    WHERE e.lname='Smith')
UNION
    (SELECT DISTINCT pnumber
    FROM project p
    INNER JOIN department d ON d.dnumber=p.dnum
    INNER JOIN employee e ON e.ssn=d.mgr_ssn
    WHERE e.lname='Smith');


(SELECT e.ssn
FROM employee e )
except
(select d.essn
FROM dependent d);

SELECT e1.lname,e1.fname
FROM employee e1
INNER JOIN (
    SELECT e.ssn
    FROM employee e 
    except
    SELECT d.essn
    FROM dependent d
) as s on e1.ssn=s.ssn;

(SELECT e.ssn
FROM employee e
WHERE e.dno=5)
UNION
(SELECT  e.super_ssn
FROM employee e
WHERE e.dno=5)

(SELECT p.pnumber
FROM project p
WHERE p.dnum=5)
INTERSECT
(SELECT w.pno
FROM works_on w
WHERE w.essn='123456789');

SELECT pj.pname
FROM project pj
INNER JOIN (SELECT p.pnumber
FROM project p
WHERE p.dnum=5
INTERSECT
SELECT w.pno
FROM works_on w
WHERE w.essn='123456789') as R on R.pnumber=pj.pnumber;

(SELECT e.ssn
from employee e
where e.dno=5)
except
(SELECT e1.ssn
from employee e1
where e1.address LIKE '%Bellaire%');

SELECT e.fname
from employee e
intersect
select d.dependent_name 
from dependent d
;
