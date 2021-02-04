SELECT name
, job_id
, salary
, salary/30 daily_salary
, round(salary/30) round_daily_salary
, trunc(salary/30) trunc_daily_salary
, ceil(salary/30) ceil_daily_salary
, floor(salary/30) floor_daily_salary
FROM employee 
where salary/30 = trunc(salary/30)
and (department_id = 3
or hire_date >= date '2011-01-01');

WITH emp_data AS
  (
    SELECT Name, Job_Id,Salary, salary / 30 AS daily_salary
    FROM Employee
    WHERE Hire_Date > DATE '2010-12-31'
      OR Department_Id = 3
  )
Select e.*,
Round(Daily_Salary),
Trunc(Daily_Salary),
Ceil(Daily_Salary),
Floor(Daily_Salary)
FROM Emp_Data e
WHERE Daily_Salary = TRUNC(Daily_Salary);