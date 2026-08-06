-- Intermediate exercises 
-- patients table

select * 
from patients;
/* 
1. Multi-condition filter
Find all female patients from Rabat or Casablanca with bill_amount > 1000, 
showing only name, city, gender, bill_amount. Order by bill_amount descending.
*/
select name, city, gender, bill_amount
from patients
where gender = 'Female' and (city = 'Rabat' or city='Casablanca') and bill_amount > 1000
order by bill_amount desc
;

/*
2. Aggregation per group
For each diagnosis, show:
	Total number of patients (total_patients)
	Average bill amount (avg_bill) rounded to 2 decimals
	Maximum number of visits (max_visits)
Order by avg_bill descending.
*/

select count(*) as total_patients , avg(bill_amount) as avg_bill , max(visits) as  max_visits
from patients
group by diagnosis
order by avg_bill desc;

/*
3. The "clinic manager" scenario
The clinic manager wants a report of cities where the total bill amount exceeds 4000 MAD, showing:
City name
Total bill (total_bill)
Number of patients (nb_patients)
Average age (avg_age) rounded to 1 decimal
*/

select city, sum(bill_amount) as total_bill , count(*) as nb_patients , round(avg(age), 1) as avg_age
from patients
group by city
having total_bill > 4000 
order by total_bill desc;
