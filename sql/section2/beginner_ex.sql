-- hospital db
select * 
from appointments;

select * 
from doctors;

-- Show all appointments with their doctor name and specialty — only where a match exists.
select doc.name, doc.specialty , app.appointment_id
from appointments as app
inner join doctors as doc
on app.doctor_id = doc.doctor_id;

-- Show all doctors, including doctors with no appointments.
select * 
from doctors as doc
left join appointments as app
on doc.doctor_id = app.doctor_id;

-- Show all appointments, including appointments with no matching doctor (like Lina's).
select * 
from appointments as app
left join doctors as doc
on app.doctor_id = doc.doctor_id;

-- Find doctors who have no appointments at all.
select * 
from doctors as doc
left join appointments as app
on doc.doctor_id = app.doctor_id
where app.doctor_id is NULL;

-- Show appointments with amount > 800 — display patient_name, doctor name, amount, sorted by amount descending.
-- we used inner cause appointments matched rows with doctors (we have doctor name)
select app.patient_name, doc.name, app.amount
from appointments as app
inner join doctors as doc
on app.doctor_id = doc.doctor_id
where app.amount > 800
order by app.amount desc;
