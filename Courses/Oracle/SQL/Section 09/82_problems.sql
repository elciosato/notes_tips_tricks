SELECT initcap(name) as name
, concat(lower(email),'@gmail.com') as email 
, translate(phone,'.','-') as phone
, translate(substr(name,1,instr(name,' ')-1),'*AEIOU', '*') as code
FROM employee;

SELECT id
,name
, hire_date
, phone
, substr(phone,instr(phone,'.')+1,instr(phone,'.',1,2)-instr(phone,'.')-1) as phone2 
, bonus
FROM employee
where hire_date >= date '2010-01-01'
order by salary desc;

select instr('123.567.9','.',1,2) from dual; 