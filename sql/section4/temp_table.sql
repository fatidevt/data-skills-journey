-- Temp Tables
create temporary table temp_table
(first_name varchar(50),
last_name varchar(50),
favorite_movie varchar(100)
);

select * 
from temp_table;

insert into temp_table
values('Fatima zahra', 'Fridi', 'Alice');

-- creating temp table using existing one
select * 
from employee_salary;

create temporary table salary_over_60k
select *  
from employee_salary
where salary >= 60000;

select * 
from salary_over_60k;


