-- 153. The Hierarchical Query Clause
SELECT employee_id
, first_name
, last_name
, job_id
, manager_id
, prior first_name as mgr_first_name
, prior last_name as mgr_last_name
, prior job_id as mgr_job_id
FROM employees
start with manager_id is null
connect by manager_id = prior employee_id
order by employee_id;

-- 155. Hierarchical Pseudo-columns
with hierar_emp as (
select employee_id
, first_name
, job_id
, prior first_name
, level as q_level
, connect_by_isleaf as isleaf
, connect_by_iscycle as iscycle
from employees
start with manager_id is null
connect by nocycle manager_id = prior employee_id
)
select *
from hierar_emp
where q_level > 2 or isleaf = 1
order by q_level desc;

-- 157. Hierarchical Operators and Functions
-- Problem 1
select employee_id
, first_name
, last_name
, manager_id
, sys_connect_by_path(employee_id, '/') as path
from employees
start with employee_id = 101
connect by manager_id = prior employee_id;

-- Problem 2
with h_emp as (
select employee_id
, first_name || ' ' || last_name as full_name
, connect_by_isleaf as isleaf
, sys_connect_by_path(employee_id, '/') as path
, manager_id
, count(*) over (partition by manager_id) as count_emp
from employees
start with manager_id is null
connect by manager_id = prior employee_id)
select employee_id
, full_name
, (select count(*) from employees start with manager_id = e1.employee_id connect by manager_id=prior employee_id) employees
from h_emp e1
where isleaf = 0
order by employees desc, full_name;


with hierarch as (
select employee_id
, connect_by_root(employee_id) as root_id
, connect_by_root(first_name || ' ' || last_name) as full_name
from employees
connect by manager_id = prior employee_id
)
select root_id
, full_name
, count(*) as employees
from hierarch
where root_id != employee_id
group by root_id, full_name
order by employees desc;

-- 159. Understanding The Execution of Hierarchical
select level
, e.employee_id
, e.last_name
, d.department_name
, sys_connect_by_path (e.last_name,'/') as path
from employees e
join departments d on (e.department_id = d.department_id)
start with e.last_name = 'Urman'
connect by e.employee_id = prior e.manager_id;

-- 161. Sorting The Results of Hierarchical Queries
SELECT employee_id
, last_name
, salary
, sys_connect_by_path(employee_id,'/') as path
, level
FROM employees
start with manager_id is null
connect by manager_id = prior employee_id
order siblings by salary, last_name desc;