-- Challenge Problem — "The Hospital Annual Report"
-- hospital db
-- Client instructions:
-- "I need 3 reports:
select * from doctors;
select * from appointments;
/*
1. Give me a full appointment report showing:
Patient name, doctor name, specialty, city, amount, status
Include ALL appointments — even ones with no matching doctor
Order by amount descending
*/
select app.patient_name, doc.name, doc.specialty, doc.city, app.amount, app.status
from appointments app
left join doctors doc
on app.doctor_id = doc.doctor_id
order by amount desc;

/*
2. Give me a UNION report combining two lists:
All doctors from Rabat → label them 'Rabat Doctor'
All patients who paid more than 900 → label them 'High Value Patient'
Show only: name, label
No duplicates
Order alphabetically by name
*/
select name , 'Rabat Doctor' as label
from doctors
where city = 'Rabat'
union
select patient_name, 'High Value Patient' as label
from appointments
where amount > 900
order by name;
/*
3. Give me a performance report per specialty showing:
Specialty
Total doctors in that specialty (total_doctors)
Total completed appointments (completed_appointments)
Total revenue from completed appointments (total_revenue)
Average amount per completed appointment (avg_amount) rounded to 2 decimals
Only specialties with at least 1 completed appointment
Order by total_revenue descending
*/
SELECT 
    doc.specialty, 
    COUNT(DISTINCT doc.doctor_id) AS total_doctors, 
    COUNT(app.appointment_id) AS completed_appointments, 
    SUM(app.amount) AS total_revenue,
    ROUND(AVG(app.amount), 2) AS avg_amount
FROM doctors doc
INNER JOIN appointments app
    ON doc.doctor_id = app.doctor_id 
    AND app.status = 'completed'
GROUP BY 
    doc.specialty
HAVING 
    COUNT(app.appointment_id) >= 1
ORDER BY 
    total_revenue DESC;

