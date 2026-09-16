-- data type is integer 
select
orderid,
creationtime,
year(creationtime) Year,
month(creationtime) Month,
day(creationtime) Day,
hour(creationtime) Hour,
minute(creationtime) Minute,
quarter(creationtime) Quarter,
week(creationtime) Week,
weekday(creationtime) Weekday
from orders;

-- dayname() + monthname()  data type is string
select
orderid,
creationtime,
DAYNAME(creationtime) day_name,
monthname(creationtime) month_name
from orders; 

-- DATE(NOW()) / time(now()) data type is datetime
select
date(now()),
time(now());

/*
Day : DATE(date_column)2026-09-10
Month : DATE_FORMAT(date_column, '%Y-%m-01') 2026-09-01
Year : DATE_FORMAT(date_column, '%Y-01-01') 2026-01-01
Hour : DATE_FORMAT(date_column, '%Y-%m-%d %H:00:00') 2026-09-10 18:00:00
Minute : DATE_FORMAT(date_column, '%Y-%m-%d %H:%i:00') 2026-09-10 18:29:00
data typpe is datetime
*/

SELECT DATE_FORMAT(NOW(), '%W, %b %d, %Y %H:%i');
select 
creationtime,
date_format(creationtime,'%Y-%m-%d %H:%i:00') as minutes,
DATE_FORMAT(creationtime, '%Y-01-01') as year_data,
date(creationtime)
from orders;
-- ex to seebenifit of date_format()
-- give me number of orders per month
select 
DATE_FORMAT(creationtime, '%Y-%m-01') as creation,
count(*)
from orders
group by DATE_FORMAT(creationtime, '%Y-%m-01');

-- give me number of orders per year
select 
DATE_FORMAT(creationtime, '%Y-%01-01') as creation,
count(*)
from orders
group by DATE_FORMAT(creationtime, '%Y-%01-01');

-- end / start of a month
SELECT 
creationtime,
LAST_DAY(creationtime) as EndOfMonth,
date_format(creationtime, '%Y-%m-01') as StartOfMonth,
(EndOfMonth - StartOfMonth) as days
from orders



