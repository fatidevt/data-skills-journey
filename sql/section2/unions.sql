select * from employee_demographics;
select * from employee_salary;
-- unuion by default use distinct
select first_name, last_name from employee_demographics
union all
select first_name, last_name from employee_salary;

select first_name, last_name, 'OLD Man' AS Label
from  employee_demographics
where age > 40 and gender = 'Male'
union
select first_name, last_name, 'OLD Lady' AS Label
from  employee_demographics
where age > 40 and gender= 'Female'
union
select first_name, last_name, 'Highly Paid Employee' AS Label
from  employee_salary
where salary > 70000
order by first_name;
