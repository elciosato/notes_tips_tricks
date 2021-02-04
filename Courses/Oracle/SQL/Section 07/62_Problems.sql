SELECT department_id
,min(salary)
,max(salary)
,avg(bonus)
FROM employee WHERE bonus is not null
group by department_id
having min(salary) < 2000 or max(salary) > 4000
order by min(salary) DESC;