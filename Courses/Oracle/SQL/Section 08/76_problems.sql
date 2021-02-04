select e.*
from employee e
order by salary asc
offset (&page - 1) * 4 rows fetch first 4 rows only;