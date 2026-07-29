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
