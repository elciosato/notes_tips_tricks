SELECT bonus, count(*), max(salary) FROM employee
where birthdate < date '1995-01-01'
group by bonus;