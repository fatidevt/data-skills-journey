-- SELECT Statement
SELECT 
first_name,
gender,
age,
age +10
FROM employee_demographics;
# SQL fllow this rule for math : PEMDAS
#PEMDAS: Parentheses, Exponents, Multiplication and Division, and Addition and Subtraction


select distinct
first_name
from employee_demographics;

# distinct ==> only unique values
-- WHERE STETMENT

SELECT * 
FROM employee_demographics
WHERE gender != 'Female'

SELECT * 
FROM employee_demographics
WHERE birth_date > '1985-01-01'

SELECT * 
FROM employee_salary
WHERE salary >= 50000
WHERE first_name = 'Lislie'

-- Logical Operators : AND OR NOT --

SELECT * 
FROM employee_demographics
WHERE birth_date > '1985-01-01'
OR NOT gender = 'Female';


SELECT * 
FROM employee_demographics
WHERE (first_name = 'Leslie' AND age = 44) or age > 55

-- LIKE Statement
--    %    ==> anything
--    _    ==> spesific value

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'A__'
WHERE first_name LIKE '%r%'

-- Group By
-- (the selected column should be agreget function)
SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender;

SELECT *
FROM employee_salary
GROUP BY occupation


-- ORDER BY
-- by default ascending
SELECT *
FROM employee_demographics
ORDER BY first_name DESC;

SELECT *
FROM employee_demographics
ORDER BY gender, age DESC;

-- WE CAN ORDER BY POSITION OF THE COLUMN
-- 5 is the position of gender column
SELECT *
FROM employee_demographics
ORDER BY 5;


-- Having vs Where
-- Having is used as where but for group by statement
-- WHERE filters individual rows before grouping
-- HAVING filters groups after the GROUP BY action.

SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40

SELECT occupation, AVG(salary)
FROM employee_salary
WHERE occupation like '%manager%'
GROUP BY occupation
HAVING avg(salary)>60000


-- LIMIT
-- how many rows to show (TOP)
select *
from employee_demographics
order by age desc
limit 3,1

-- limit 3,1 
-- (3) is the Offset: How many rows to skip
-- (1) is the Count: How many rows to show

-- ALIASING
-- naming the column name
select gender , avg(age) as avg_age
from employee_demographics
group by gender
having avg_age > 35;
