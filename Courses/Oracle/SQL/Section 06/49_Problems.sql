SELECT * FROM employee where name not like '%OO%' and name like '%O%O%';

SELECT * FROM department where monthly_budget > 15000 and (name like '%G%' or name like 'H%');

SELECT * FROM department where name in ('INFORMATION TECHNOLOGY', 'HUMAN RESOURCES');

SELECT * FROM employee 
where department_id in (3,4) 
and salary between 3000 and 5000
and birthdate >= date '1970-01-01' and birthdate < date '1991-01-01';