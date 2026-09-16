select * from orders;

-- how many orders were placed each year?
select 
count(*)  nb_of_orders,
DATE_FORMAT(creationtime, '%Y-%01-01')  year
from orders
group by DATE_FORMAT(creationtime, '%Y-%01-01');

-- how many orders were placed each month?
select 
monthname(creationtime) MonthName,
DATE_FORMAT(creationtime, '%Y-%m-01')  Month,
count(*)  nb_of_orders
from orders
group by DATE_FORMAT(creationtime, '%Y-%m-01') , monthname(creationtime) ;

-- show all orders that were placed during the month of february
select
*
from orders
where month(creationtime) = 2;

-- SHOW DATE WITH THIS FORMAT : Day Wed Jan 2025 Q1 12:34:56 PM
/*
Year: %Y (4-digit: 2026), %y (2-digit: 26)
Month: %m (01–12), %c (1–12), %M (Full name: September), %b (Abbreviated: Sep)
Day: %d (01–31), %e (1–31), %W (Weekday name: Tuesday), %a (Abbreviated weekday: Tue)
Time: %H (24-hour), %h (12-hour), %i (Minutes), %s (Seconds), %p (AM/PM)
*/
select creationtime,
	concat('Day ', date_format(creationtime, '%a %b %Y') , ' Q', quarter(creationtime),' ' , date_format(creationtime, '%H:%i:%s %p')) as format
from orders;

-- nb of orders per month
select 
	date_format(orderdate, '%b %y'),
    count(*)
from orders
group by  date_format(orderdate, '%b %y')

