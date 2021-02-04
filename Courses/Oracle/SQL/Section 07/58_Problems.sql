SELECT count(*) as employees
, sum(salary) as total_salaries
, avg(salary) as average_salary
, sum(salary)/count(*)  as manual_average_salary
FROM employee WHERE department_id = 1;

SELECT * FROM department;