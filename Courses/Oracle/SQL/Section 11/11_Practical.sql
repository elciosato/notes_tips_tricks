-- 108. The Partition Clause
SELECT id
, name
, department_id
, email
, length(email)
, count(*) over (partition by department_id, length(email)) as count_same_email_length
FROM employee e
order by department_id, length(email);

-- 111. The Windowing Clause
with emp as (
select id
, name
, department_id
, hire_date
, to_number(to_char(hire_date,'YYYY')) as hired_year
-- , extract(year from hire_date) as hired_year
from employee)
select id
,name
,department_id
,hire_date
,hired_year as hired_year
, count(*) over (order by hired_year
                 range 1 PRECEDING) as count_same_year
from emp
order by hire_date;

-- 114. Common Analytic Functions
SELECT id
, name
, monthly_budget
, sum(monthly_budget) over (order by monthly_budget) as accumulated
FROM department
order by monthly_budget;

-- 116. Ranking Functions
SELECT name
, department_id
, hire_date
, row_number() over (partition by department_id order by hire_date) as hire_order
FROM employee
order by department_id;

select * from department;

with pri as (
select name
, birthdate
, department_id
, row_number() over (order by department_id) as rn
from employee
where extract(year from birthdate) = 1995
)
select *
from pri
where rn = 1;

WITH prioritized AS (
SELECT name,birthdate,department_id,
  ROW_NUMBER() OVER (ORDER BY
                      CASE
                        WHEN department_id = 1 THEN 'A'
                        ELSE 'B'
                      END) AS rn
FROM employee
WHERE to_char(birthdate,'YYYY') = '1995'
)
SELECT name,birthdate,department_id
FROM prioritized
WHERE rn = 1;

-- 118. The LISTAGG Function
select salary
--, name
, listagg(name, ', ') within group (order by name)
from employee
group by salary
order by salary desc;

-- 120. The LAG and LEAD Functions
SELECT name
, birthdate
, department_id
, lead(name) over (partition by department_id order by birthdate desc) as next_by_age
FROM employee
WHERE department_id in (1,4)
order by department_id, birthdate desc;

with h_sal as (
    select id
    , name
    , salary
    , department_id
    , row_number() over (partition by department_id order by salary desc) as rn
    , lead(id) over (partition by department_id order by salary desc) as next_id
    from employee
)
select *
from h_sal
where rn = 1;

-- 122. The FIRST and LAST Functions
select department_id
, max(name) keep (dense_rank first order by hire_date) as name_first_hire_date
, min(hire_date) as first_hire_date    
from employee
group by department_id
order by department_id;

with first_emp as(
select department_id,name,hire_date
, row_number() over (partition by department_id order by hire_date) as rn
from employee
)
select *
from first_emp
where rn = 1
order by department_id;

-- 124. The FIRST_VALUE and LAST_VALUE Functions
select id
, name
, department_id
--, hire_date
--, salary
, bonus
, first_value(name) over (partition by department_id order by hire_date 
    rows between UNBOUNDED PRECEDING and UNBOUNDED FOLLOWING) as fv_name
, first_value(salary) over (partition by department_id order by hire_date 
    rows between UNBOUNDED PRECEDING and UNBOUNDED FOLLOWING) as fv_salary
, first_value(nvl(bonus,0)) over (partition by extract(year from hire_date) order by salary desc 
    rows between UNBOUNDED PRECEDING and UNBOUNDED FOLLOWING) fv_bonus   
from employee
order by department_id, hire_date;