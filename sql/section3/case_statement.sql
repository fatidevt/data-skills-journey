select first_name, last_name, age,
case
	when age <= 30 then 'Young'
    when age between 31 and 50 then 'Old'
    when age >= 50 then 'Too Old'
end as Age_Bracket
from employee_demographics;

-- pay increase and bonus
-- < 50000 = 5%
-- > 50000 = 7%
-- Finance = 10% bonus

select first_name, last_name, salary,
case
	when salary < 50000 then salary*1.05
    when salary > 50000 then salary*1.07
end as new_salary,
case 
	when dept_id = 6 then salary*0.1
end as bonus
from employee_salary;