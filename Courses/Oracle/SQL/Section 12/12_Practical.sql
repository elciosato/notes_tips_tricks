-- 129. The UNION and UNION ALL Operators
select id
, name
, birthdate
, hire_date
from employee
where to_char(birthdate,'MM') in ('05','06')
union all
select id
, name
, birthdate
, hire_date
from employee
where to_char(hire_date,'MM') in ('05','06')
order by id;

-- 131. The INTERSECT Operator
select id
, name
, birthdate
, hire_date
from employee
where to_char(birthdate,'MM') in ('05','06')
intersect
select id
, name
, birthdate
, hire_date
from employee
where to_char(hire_date,'MM') in ('05','06')
order by id;

-- 133. The MINUS Operator
select id
, name
, birthdate
, hire_date
from employee
where to_char(birthdate,'MM') in ('05','06')
minus
select id
, name
, birthdate
, hire_date
from employee
where to_char(hire_date,'MM') in ('05','06')
order by id;

-- 135. Combining Set Operators in the Same Query
select *
from employee
where salary >= 3000
intersect
select *
from employee
where extract(year from hire_date) = 2015
minus
select *
from employee
where department_id = 3;

select * from department;