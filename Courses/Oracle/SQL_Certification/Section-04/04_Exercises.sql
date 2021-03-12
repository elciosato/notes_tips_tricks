SELECT MAX (sal + nvl (comm, 0)) AS max_amount
FROM emp
WHERE job = 'MANAGER';

SELECT COUNT (comm)
     , AVG (comm)
     , SUM (comm) / COUNT (comm)
FROM emp;

SELECT job
     , AVG (sal) AS average
FROM emp
GROUP BY job;

SELECT deptno
     , COUNT (*)
FROM emp
GROUP BY deptno
HAVING COUNT (*) > 3;

SELECT job
     , COUNT (*)
FROM emp
GROUP BY job;

SELECT e.*
FROM emp e
JOIN dept d
on (e.deptno = d.deptno)
WHERE loc = 'CHICAGO';

