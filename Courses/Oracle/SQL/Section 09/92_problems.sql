SELECT id
, name
, salary as current_salary
, decode(department_id, 1, salary*1.1, 2, salary*1.15, salary*1.20) as new_salary
, case
    when department_id = 1
      then salary*1.1
    when department_id = 2
      then salary*1.15
    else
      salary * 1.20
  end as new_salary2
FROM employee;

select * FROM department;

SELECT id
, name
, salary
, extract(year from hire_date) as hire_year
, case
    when salary < 2500
        then 'A'
    when salary >= 2500 and salary < 4000
        then 'B'
    when extract(year from hire_date) < 2014
        then 'C'
    else
        'D'
  end as classification
FROM employee 
WHERE department_id != 2
and phone is not null
order by salary;

SELECT id,name,salary,
  TO_CHAR(hire_date,'YYYY') AS hire_year,
  CASE
    WHEN salary < 2500
      THEN 'A'
    WHEN salary >= 2500 AND salary < 4000
      THEN 'B'
    WHEN salary >= 4000 AND hire_date < DATE '2014-01-01'
      THEN 'C'
    WHEN salary >= 4000 AND TO_CHAR(hire_date,'YYYY') IN ('2014','2015')
      THEN 'D'
  END AS classification
FROM employee
WHERE department_id != 2
  AND phone IS NOT NULL
ORDER BY salary,hire_date;