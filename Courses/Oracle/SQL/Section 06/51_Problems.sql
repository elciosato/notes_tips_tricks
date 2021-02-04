SELECT * FROM employee 
WHERE (birthdate < date '1980-01-01' or birthdate > date '1995-01-01')
and salary + nvl(bonus,0) > 2000
and not (name like 'N%' or name like '%N');