SELECT id
, name
, hire_date
, trunc(months_between(sysdate, hire_date)) as months_worked
, add_months(hire_date, 6) as raise
, next_day(hire_date, 'MONDAY') as induction
, last_day(hire_date) + 1 as newsletter
FROM employee
where department_id != 3;