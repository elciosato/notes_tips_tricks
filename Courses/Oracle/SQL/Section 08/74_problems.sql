with emp as (
select e.*,
row_number() over (order by salary desc) as rn
from employee e
order by salary desc)
select *
from emp
where rn <= 5;