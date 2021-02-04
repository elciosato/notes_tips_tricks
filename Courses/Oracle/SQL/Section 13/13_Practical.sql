-- 139. Introduction to SQL Joins
select d.name
, count(*) as count_emp
, sum(e.salary) sum_sal
from employee e
join department d on (e.department_id = d.id)
group by d.name
order by sum_sal desc;

-- 142. Querying a more Complex Test Schema
select e.employee_id
, e.first_name
, e.salary
, d.department_name
, j.job_title
from employees e
join departments d on (e.department_id = d.department_id)
join jobs j on (e.job_id = j.job_id)
where d.department_name = 'Finance';

-- 144. Inner Joins
select e.employee_id
, e.first_name
, e.salary
, j.job_title
, d.department_name
from employees e
join jobs j on (e.job_id = j.job_id)
join departments d on (e.department_id = d.department_id)
where d.department_name <> 'IT';

select e.employee_id
, e.first_name
, e.salary
, j.job_title
, d.department_name
from employees e, jobs j, departments d
where d.department_name <> 'IT'
and e.job_id = j.job_id
and e.department_id = d.department_id;

-- 146. Other Types of Joins
select e.employee_id
, e.first_name
, e.salary
, m.first_name as manager
from employees e
join employees m on e.manager_id = m.employee_id;