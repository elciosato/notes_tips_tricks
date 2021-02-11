SELECT ename
FROM emp
WHERE job != 'MANAGER'
      AND job != 'SALESMAN'
      AND sal >= 2000;

SELECT ename
     , hiredate
FROM emp
JOIN dept
USING (deptno)
WHERE loc IN ('DALLAS', 'CHICAGO');

SELECT *
FROM emp
WHERE (comm = 0
       OR comm IS NULL)
      AND sal > 1100
      AND sal < 5000
      AND sal != 3000;

SELECT *
FROM emp
WHERE job = 'SALESMAN'
      AND (comm = 300
           OR comm > 1000);

SELECT ename || ' makes ' || to_char (sal, 'fmL9999') || ' per month' AS text
FROM emp;

-- Assignment 1 - Practice with single table queries
-- 1.
SELECT *
FROM suppliers
WHERE state IN ('Georgia', 'California');

-- 2.
SELECT *
FROM suppliers
WHERE supplier_name LIKE '%wo%'
      AND (supplier_name LIKE '%i%'
           OR supplier_name LIKE '%I%');
           
-- 3.
SELECT *
FROM suppliers
WHERE total_spent BETWEEN 37000 AND 80000;

-- 4.
SELECT supplier_namne
     , state
FROM suppliers
WHERE state IN ('Georgia', 'Alaska')
      AND (supplier_id = 100
           OR supplier_id > 600)
      AND (total_spent < 100000
           OR total_spent = 220000);
           
-- 5.
FALSE

-- 6.
FALSE


-- 7.
TRUE

-- 8.
TRUE

-- 9.
FALSE

