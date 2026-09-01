-- hospital db
select * 
from appointments;

select * 
from doctors;

/*1. JOIN + GROUP BY
For each doctor, show:
Doctor name
Specialty
Total appointments (total_appointments)
Total revenue (total_revenue)
Only include completed appointments
Order by total_revenue descending
*/

-- NOTES: 
-- All non-aggregated SELECT columns must be in GROUP BY.
-- Always include doctor_id in GROUP BY to avoid merging doctors with identical names.
select 
	doc.name, 
    doc.specialty, 
    count(app.appointment_id) as total_appointments, 
    sum(app.amount) as total_revenue
from doctors doc
inner join appointments app
	on doc.doctor_id = app.doctor_id
where app.status = 'completed'
group by 
	doc.doctor_id, 
	doc.name, 
	doc.specialty
order by 
	total_revenue desc;

/*
2. LEFT JOIN + IS NULL + condition in ON
Show all doctors and their completed appointments only — 
but keep doctors who have no completed appointments too (show NULL for their appointment columns).
Hint: put the status condition in ON, not WHERE
*/
-- condition in ON
select doc.name, app.status
from doctors doc
left join appointments app
on doc.doctor_id = app.doctor_id and app.status = 'completed';

-- condition in WHERE
select doc.name, app.status
from doctors doc
left join appointments app
on doc.doctor_id = app.doctor_id where app.status = 'completed';

/*
3. The "hospital manager" scenario
The manager wants a report showing:

Doctor name, city, specialty
Number of completed appointments (completed_appointments)
Total revenue from completed appointments (total_revenue)
Only doctors with total revenue above 1000
Order by total_revenue descending
*/
select doc.name, doc.city, doc.specialty, count(app.appointment_id) as completed_appointments ,  sum(app.amount) as total_revenue
from doctors doc
inner join appointments app
on doc.doctor_id = app.doctor_id
where app.status = 'completed'
group by 
	doc.doctor_id, doc.name, doc.city, doc.specialty
having sum(app.amount)> 1000
order by total_revenue desc;




