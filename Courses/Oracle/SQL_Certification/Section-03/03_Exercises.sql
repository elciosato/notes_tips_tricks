SELECT concat (concat (lower (ename), upper (' is the name')), concat (' and their job is: ',
job)) AS "Function Call"
FROM emp
WHERE deptno = 20;

SELECT to_char (10, '990.99')
FROM dual;

SELECT to_char (sysdate, 'ddth "of" month, yyyy')
FROM dual;

SELECT to_char (sal, 'fmL99G999D00')
FROM emp;

SELECT next_day (sysdate, 4)                        AS nextday
     , to_char (next_day (sysdate, 4), 'DY')        AS nextday_week
FROM dual;

SELECT empno
     , ename
     , nvl (to_char (comm), 'No data found')
FROM emp;

SELECT empno
     , ename
     , CASE
             WHEN comm IS NULL THEN
                 'No data found'
             ELSE
                 to_char (comm)
         END AS commision
FROM emp;

SELECT ename
     , length (ename)
     , nvl2 (nullif (length (ename), 5), to_char (length (ename)), 'length is 5')
FROM emp;

-- Assignment 2 - Practice with Single Row Functions
-- 1.
SELECT concat (concat (name, ' has the population of '), to_char (population, '999,999,999'))
FROM city
WHERE countrycode = 'cbd';

-- 2.
SELECT concat(concat(upper (substr (district, 1, 3)), '-'), upper (substr (district, - 3)))
FROM city;

select months_between(last_day(date'12-01-15')+1,date'12-01-01') as month from dual;

-2

-- 4.
False

-- 5.
C

-- 6. 
C

-- 7.
A

-- 8.
True

-- 9.
True