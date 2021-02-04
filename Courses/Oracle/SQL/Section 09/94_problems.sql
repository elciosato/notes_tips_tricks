SELECT id
, name
, birthdate
, birthdate + 2*365 as second_birthdate
, (hire_date - birthdate) * 24 as age_hired
FROM employee
where hire_date >= date '1980-01-01'
and phone like '1%'
order by department_id, salary desc;