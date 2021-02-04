SELECT * FROM employee 
WHERE hire_date between date '&start_date' and date '&end_date';

SELECT * FROM employee
where department_id = &department_id
and (salary = &&sal or salary = &sal/2 or salary = &salary2);

UNDEFINE sal;