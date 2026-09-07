-- CTEs

-- CTE EXAMPLE
with CTE_Example as
(
select gender, avg(salary) avg_sal, max(salary) max_sal, min(salary) min_sal, count(salary) count_sal
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
group by gender
)
select avg(avg_sal)
from CTE_Example;

-- SUBQUERY EXAMPLE
SELECT avg(avg_sal)
FROM
(
select gender, avg(salary) avg_sal, max(salary) max_sal, min(salary) min_sal, count(salary) count_sal
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
group by gender
) example_subquery
;

-- the aliasing take the cte names
with CTE_Example (Gneder, Avg_sal, Max_sal, Min_sal, Count_sal)
 as
(
select gender, avg(salary) avg_sal, max(salary) max_sal, min(salary) min_sal, count(salary) count_sal
from employee_demographics dem
join employee_salary sal
	on dem.employee_id = sal.employee_id
group by gender
)
select *
from CTE_Example;

-- using multiple CTEs
with CTE_Example1 as
(
select employee_id, birth_date
from employee_demographics 
where birth_date > '1985-01-01'
),
CTE_Example2 AS
(
select employee_id, salary
from employee_salary
where salary > 50000
)
select *
from CTE_Example1 cte1
join CTE_Example2 cte2
	on cte1.employee_id = cte2.employee_id
;



