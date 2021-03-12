SELECT ename
     , job
     , sal
     , loc
FROM emp e
JOIN dept d
USING (deptno)
WHERE loc = 'DALLAS';

SELECT e.ename
     , e.job
     , e.sal
     , deptno
     , d.dname
FROM dept  d
LEFT JOIN emp   e
USING (deptno);

SELECT *
FROM (SELECT *
      FROM emp
      WHERE job = 'SALESMAN'
)  e
RIGHT JOIN (SELECT *
            FROM dept
)  d
USING (deptno);

SELECT e.*
     , d.*
FROM (SELECT *
      FROM dept
)  d
LEFT JOIN (SELECT *
           FROM emp
           WHERE job = 'SALESMAN'
)  e
ON (e.deptno = d.deptno);

SELECT *
FROM dept
WHERE EXISTS (SELECT NULL
              FROM dual
);

SELECT e.empno
     , e.ename
     , e.job
     , e.mgr
     , m.ename AS manager
FROM emp e
JOIN emp m
ON (e.mgr = m.empno);