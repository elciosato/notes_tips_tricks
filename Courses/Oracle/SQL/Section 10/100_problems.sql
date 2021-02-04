SELECT * from (
    select name, monthly_budget from department
)
pivot (
    max(monthly_budget) for name in ('ACCOUNTING', 'MARKETING', 'INFORMATION TECHNOLOGY')
)    ;

select * from (
SELECT name, birthdate, hire_date 
FROM employee 
WHERE department_id in (1,2))
unpivot (date_value for date_type in (birthdate,hire_date));