SELECT * FROM department 
WHERE id = (select department_id 
            from employee where birthdate = (select max(birthdate) from employee));
            
select name, (select avg(salary)
from employee
where department_id = d.id) as average_salary,(select min(birthdate)
from employee
where department_id = d.id) as oldest_emp_birthdate
from department d 
order by id desc;