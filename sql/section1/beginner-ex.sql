-- Table clinic
-- Select all columns from patients.
select *
from patients

-- Select only name, city, and bill_amount for patients from Rabat.
select name, city, bill_amount
from patients
where city='Rabat'

-- Find all patients with bill_amount greater than 2000, ordered by bill_amount descending.
select *
from patients
where bill_amount>2000
order by bill_amount desc

-- Count the number of patients per city, ordered by count descending.
select city, COUNT(*) AS nb_of_petients
from patients
group by city
order by nb_of_petients desc;

-- Find cities with more than 2 patients — using HAVING.
select city, COUNT(*) AS nb_of_patients
from patients
group by city
having nb_of_patients > 2;






