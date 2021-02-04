-- 164. SELECT statement extended practice
-- 1.
select employee_id as "Employee ID" 
, first_name as "First Name" 
, last_name as "Last Name"
from employees
where salary < 3000
and (first_name like 'G%' or last_name like 'G%');

-- 2.
select manager_id as employee_id
, count(*) as employees
from employees
group by manager_id
having count(*) > 6
order by manager_id desc;

-- 3.
with top_5 as(
select employee_id
, first_name
, last_name
, hire_date
, commission_pct
, row_number() over(order by hire_date) as rn
from employees
where commission_pct < 0.3
order by hire_date
)
select employee_id
, first_name
, last_name
, hire_date
, commission_pct
from top_5
where rn < 6;

-- 4.
select employee_id
, first_name
, last_name
, department_name
, email
, upper(substr(first_name,1,1) || last_name) as expected_email
from employees
join departments using (department_id)
where department_name in ('Marketing', 'Purchasing', 'Executive')
and upper(substr(first_name,1,1) || last_name) != email;

select * from departments
where department_name in ('Marketing', 'Purchasing', 'Executive');

-- 5.
select employee_id
, first_name
, last_name
, phone_number
, substr(phone_number,instr(phone_number,'.',-1)+1) as last_digitis
, salary
, department_id
from employees
where (department_id = 20 or salary between 6000 and 6500)
order by department_id;

-- 6.
select department_name
, count(*) employees
from employees
join departments using (department_id)
group by department_name
having count(*) > 5
order by employees desc;

-- 7.

select department_id
, department_name
from departments d
where 0 = (select count(*) from employees e where e.department_id = d.department_id)
order by department_name;

with c_dept as (
select department_id
, department_name
, count(employee_id) over (partition by department_id) count_emp
from departments
left join employees using (department_id)
where employee_id is null
)
select department_id
, department_name
from c_dept
where count_emp = 0
order by department_name;

-- 8.
select location_id
, city
, count(*) as count_employees
from locations 
join departments using (location_id)
join employees using (department_id)
group by location_id, city
order by count_employees;

-- 9.
select l.location_id
, l.city
, count(d.location_id) as departments
from locations l
left join departments d on (l.location_id = d.location_id)
where l.country_id='CA'
group by l.location_id, l.city;

-- 10.
select region_name
, min(salary) as min_sal
, max(salary) as max_sal
from regions
join countries using (region_id)
join locations using (country_id)
join departments using (location_id)
join employees using (department_id)
group by region_name
order by region_name;

-- 11.
select region_name
, count(employee_id) count_emp
from regions
left join countries using (region_id)
left join locations using (country_id)
left join departments using (location_id)
left join employees using (department_id)
group by region_name
order by region_name;

-- 12.
with c_app as (
select employee_id
, count(distinct application_id) as count_app
from users
join user_roles using (user_id)
join application_permissions using (role_id)
where employee_id <= 105
group by employee_id
)
select employee_id
, first_name
, last_name
, count_app
, case
    when count_app > 5
        then 'MORE THAN 5'
    ELSE '5 OR LESS'
  end as apps_note
from c_app
join employees using (employee_id)
order by employee_id;

-- 13.
with l_active as (
select department_id
, department_name
, active
, case
    when active = 'Y'
        then 1
    else 0
  end as is_active
, case
    when active = 'N'
        then 1
    else 0
  end as is_inactive    
from departments
left join employees using (department_id)
left join users using (employee_id)
)
select department_id
, department_name
, sum(is_active) as is_active
, sum(is_inactive) as is_inactive
from l_active
group by department_id, department_name
order by department_id;

with pivot_user as (
select * from (
    select department_id
    , department_name
    , active
    from departments
    left join employees using (department_id)
    left join users using (employee_id)
)    
pivot (
    count(active) for active in ('Y' as active, 'N' as inactive)
))
select department_id
, department_name
, sum(active) as active
, sum(inactive) as inactive
from pivot_user
group by department_id, department_name
order by department_id;

-- 14.
select department, active, users
from (
select *
from v_active_user_count
unpivot
(
    users for department in ("EXECUTIVE", "IT", "FINANCE", "PURCHASING", "SHIPPING", "SALES", "ADMINISTRATION", "MARKETING", "HUMAN_RESOURCES", "PUBLIC_RELATIONS", "ACCOUNTING")
)
)
order by department, active;

-- 15.
select * from (
select department_id
, department_name
, employee_id
, first_name
, last_name
, hire_date
, DENSE_RANK() over (partition by department_id order by hire_date) as rk
from departments
join employees using (department_id)
)
where rk <= 2
order by department_id, rk;

-- 16.
select department_id
, department_name
, employee_id
, last_name
, salary
, salary * case
    when department_id = 20 then 1.05
    when department_id = 30 then 1.10
    when department_id = 80 then 1.15
    when department_id = 90 then 1.20
    else 1.25    
    end as new_salary    
from employees
join departments using (department_id)
where salary > 10000
order by department_id, salary;

-- 17.
select * from departments where department_id in (90, 100);

with prev_creation as (
select department_id
, department_name
, employee_id
, last_name
, creation_date
, lag(creation_date,1) over (partition by department_id order by creation_date) prev_creation_date
from departments
join employees using (department_id)
join users using (employee_id)
where department_name in ('Executive', 'Finance')
)
select department_id
, department_name
, employee_id
, last_name
, creation_date
, case
    when creation_date - prev_creation_date > 365
        then 'More than 1 year before'
    else null
  end as previous_user_created
from prev_creation
order by department_id, creation_date;

-- 18.
with greater_sal as (
select department_id
, count(*)
from employees
where salary > 10000
group by department_id
having count(*) > 1
)
select d.department_id
, department_name
, manager_id
, location_id
from departments d
join greater_sal g on (d.department_id = g.department_id)
order by d.department_id;

-- 19.
select application_id
, application_name
, system_id
from applications
join application_permissions using (application_id)
join user_roles using (role_id)
join users using (user_id)
where employee_id = 100
order by system_id desc;

-- 20.
select * from departments where department_id in (10, 20, 30);

select department_id
, extract(year from hire_date) as year
, to_char(count(*), '09') as num_employees
, to_char(sum(salary),'fmL999G999D00') sum_salary
from employees
where department_id in (10, 20, 30)
and hire_date >= date '2003-01-01'
group by department_id, extract(year from hire_date)
order by department_id, year;