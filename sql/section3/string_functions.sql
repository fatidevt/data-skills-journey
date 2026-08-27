select length('kiki');

select first_name, length(first_name)
from employee_demographics
order by 2;
-- order by 2 ==> order by 2nd column

select upper('sky');
select lower('SKY');

-- trim : removes unwanted spaces (or specified characters) from the beginning and end of a text string
-- left trim (LTRIM): remove spaces from left
-- right trim (RTRIM) : removes spaces from right

select ltrim('     amina  ');

select first_name, 
left(first_name, 4) as 4stChara, 
right(first_name, 4) as 4lastChara,
substring(first_name, 3, 2),
substring(birth_date, 6, 2) as birth_month
-- start with 3rd chara , extracts 2 chara 
from employee_demographics;

select first_name, replace(first_name, 'l', 'z')
from employee_demographics;

select locate('x','Alexender');

select first_name, last_name, concat(first_name, ' ' ,last_name)
from employee_demographics;
