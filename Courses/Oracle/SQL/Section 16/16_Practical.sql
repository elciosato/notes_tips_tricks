-- 168. The INSERT Statement
desc employees

select max(employee_id) from employees;

insert into employees
values (210
, 'Name 1'
, 'Last 1'
, 'email1@gmail.com'
, '1234567890'
, trunc(sysdate - 10)
, 'IT_PROG'
, 100
, .10
, 100
,10
);

insert into employees
values (212
, 'Name 2'
, 'Last 2'
, 'email2@gmail.com'
, '1234567890'
, trunc(sysdate - 10)
, 'IT_PROG'
, 100
, .10
, 100
,10
);

savepoint a;

insert into employees (
employee_id
, last_name
, email
, hire_date
, job_id)
values (213
, 'Last 3'
, 'email3@gmail.com'
, trunc(sysdate - 10)
, 'IT_PROG');

insert into employees (
employee_id
, last_name
, email
, hire_date
, job_id)
values (214
, 'Last 4'
, 'email4@gmail.com'
, trunc(sysdate - 10)
, 'IT_PROG');

savepoint b;

insert into departments ( department_id, department_name)
values ((select max(department_id)+1 from departments), 'NEW DEPARTMENT');

insert into employees (
employee_id
, last_name
, email
, hire_date
, job_id)
select employee_id+10000
, last_name
, email||to_char(employee_id+10000)
, hire_date
, job_id from employees where department_id = 30;

rollback to savepoint b;

rollback;

-- 170. The UPDATE Statement
select * from departments where manager_id is null;

update departments
set department_name = department_name|| ' NO MGR'
where manager_id is null;

select department_id, max(salary) from employees group by department_id order by 1;

update employees e
set salary = (select max(salary) from employees where department_id = e.department_id)
;

select employee_id, last_name, salary, department_id
from employees 
order by department_id, salary desc;

rollback;

-- 172. The DELETE Statement
select employee_id
, first_name
, last_name
, salary
from employees
where salary > 5000
and (first_name like '%s%s%' or last_name like '%s%s%');

delete from employees
where salary > 5000
and (first_name like '%s%s%' or last_name like '%s%s%');

delete from job_history
where employee_id in 
(select employee_id 
from job_history
group by employee_id
having count(*) > 1);

rollback;

-- 173. The MERGE Statement
SELECT * FROM users_correction;

merge into users u
using users_correction uc
on (u.user_id = uc.user_id)
when not matched then
    insert (user_id, employee_id, active, creation_date)
    values (uc.user_id, uc.employee_id, uc.active, uc.creation_date)
    where uc.creation_date >= date '2005-01-01'
when matched then
    update set active = uc.active, creation_date = uc.creation_date
    where creation_date >= date '2010-01-01';
    