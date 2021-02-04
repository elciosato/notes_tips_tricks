select * from (
SELECT department_id
, max(salary) as max_salary
, min(salary) as min_salary
, avg(salary) as average_salary 
FROM employee
group by department_id)
where max_salary > 2 * min_salary;