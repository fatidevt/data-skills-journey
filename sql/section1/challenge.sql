-- Challenge Problem — "The Clinic Annual Report"
-- The clinic director wants a complete summary report before the board meeting.
-- Client instructions:

/*1. Give me a patient summary by city showing:
City name
Total patients (total_patients)
Average bill rounded to 2 decimals (avg_bill)
Total revenue (total_revenue)
Most visits by any single patient (max_visits)
Only include cities with at least 2 patients AND total revenue above 3000
Order by total_revenue descending*/

select *
from patients;

select city, count(*) as total_patients , round(avg(bill_amount),2) as avg_bill ,  
	sum(bill_amount) as total_revenue , max(visits) as max_visits
from patients
group by city
having max_visits >= 2 and total_revenue > 3000
order by total_revenue desc;

/*2. Give me a diagnosis breakdown showing:
Diagnosis name
Number of patients (total_patients)
Average age of patients with that diagnosis, rounded to 1 decimal (avg_age)
Total bill (total_bill)
Only diagnoses where average age is above 35
Order by total_bill descending*/

select diagnosis, count(*) as total_patients, round(avg(age),1) as avg_age, sum(bill_amount) as total_bill
from patients
group by diagnosis
having avg_age > 35
order by total_bill desc;

/*3. Give me the top 3 highest billed patients — show name, city, diagnosis, and bill amount.*/

select name, city, diagnosis, bill_amount
from patients
order by bill_amount desc
limit 3;
