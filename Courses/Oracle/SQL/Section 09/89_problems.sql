SELECT id
, name
, birthdate
, to_date(extract(month from birthdate) || '-' || 
  extract(day from birthdate) || '-' || 
  extract(year from birthdate) default null on conversion error) as alt_birthdate
, TO_DATE(TO_CHAR(birthdate,'DDMMYYYY') DEFAULT NULL ON CONVERSION ERROR,'MMDDYYYY') AS alt_birthdate2
, phone
, to_char(salary,'fmL99,990.00') as salary
, to_char(department_id,'fm0009') as department
FROM employee 
WHERE birthdate > date '1970-12-31'
and phone is not null;

select trunc(sysdate, 'yyyy')
, extract(year from sysdate) from dual; 

SELECT name
, to_char(birthdate,'dd-MON') as birthdate
, to_char(hire_date, 'MON-yyyy') as hire_date
, phone
, to_char(substr(phone,-4),'L9,990.00') as bonus
, to_char(to_date('01-' || 
  to_char(substr(phone,-1),'09') || 
  '-2021' default '01-12-2021' on conversion error,
  'dd-mm-yyyy'),'month') as bonus_month 
, TO_CHAR(TO_DATE(SUBSTR(phone,-1) DEFAULT '12' ON CONVERSION ERROR,'mm'),'month') AS bonus_month
FROM employee 
WHERE (hire_date < date '2015-01-01' and salary > 2500)
or (extract(year from hire_date) = 2015 and salary < 3000) ;