select * from employee_demographics;
select * from employee_salary;

-- group by example avg salary by gender
select gender, avg(salary) as avg_salary
from employee_demographics dem 
join employee_salary sal
	on dem.employee_id = sal.employee_id
group by gender;

-- PARTITION BY keeps every individual row while performing group calculations.
-- PARTITION BY example avg salary by gender
select gender, avg(salary) over(partition by gender) as avg_salary
from employee_demographics dem 
join employee_salary sal
	on dem.employee_id = sal.employee_id;
    
-- sum salary
select dem.first_name, dem.last_name, gender, sal.salary, 
sum(salary) over(partition by gender order by dem.employee_id) as Rolling_Total
from employee_demographics dem 
join employee_salary sal
	on dem.employee_id = sal.employee_id;

-- row_number() vs rank() vs dense_rank()
-- row_number() / 1234
-- rank() next nb positionally / 1224
-- dense rank() next nb numerically / 1223
select dem.employee_id, dem.first_name, dem.last_name, gender, sal.salary, 
row_number() over(partition by gender order by salary desc) as row_num,
rank() over(partition by gender order by salary desc) as rank_num,
dense_rank() over(partition by gender order by salary desc) as dense_rank_num
from employee_demographics dem 
join employee_salary sal
	on dem.employee_id = sal.employee_id;



