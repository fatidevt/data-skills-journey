-- INNER JOIN: Returns rows with matching values in both tables.
-- to join 2 tables it needs same data of at least one row are same
select *  
from employee_demographics;

select *  
from employee_salary;

select dem.employee_id, dem.age, sal.occupation
from employee_demographics as dem
inner join employee_salary as sal
	on dem.employee_id = sal.employee_id;
    
-- LEFT JOIN (Left Join): Returns all rows from the left table and matched rows from the right.
-- RIGHT JOIN (Right Join): Returns all rows from the right table and matched rows from the left.

-- inner join : matches rows from right table
-- right join : all rows from right table
-- left join : all rows from left table

select *
from employee_demographics as dem
left join employee_salary as sal
	on dem.employee_id = sal.employee_id;
    
select *
from employee_demographics as dem
right join employee_salary as sal
	on dem.employee_id = sal.employee_id;
    
-- self join
-- tie the table to itself
select emp1.employee_id as emp_kiki,
emp1.first_name as first_name_kiki,
emp1.last_name as last_name_kiki,
emp2.employee_id as emp_name,
emp2.first_name as first_name_name,
emp2.last_name as last_name_name
from employee_salary emp1
join employee_salary emp2
	on emp1.employee_id+1 = emp2.employee_id;
    
-- Join multiple tables

select *
from employee_demographics as dem
inner join employee_salary as sal
	on dem.employee_id = sal.employee_id
inner join parks_departments pd
	on sal.dept_id = pd.department_id
;
select * 
from parks_departments;
    

	
