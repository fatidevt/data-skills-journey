/*
SELECT DATE_ADD('2026-09-16', INTERVAL 3 MONTH); -- '2026-12-16'
SELECT ADDDATE('2026-09-16', INTERVAL 10 DAY);   -- '2026-09-26'
SELECT DATE_SUB('2026-09-16', INTERVAL 2 YEAR);  -- '2024-09-16'
SELECT SUBDATE('2026-09-16', INTERVAL 45 MINUTE);-- '2026-09-16 10:52:00'
SELECT NOW() + INTERVAL 1 WEEK;                   -- 1 week into the future
SELECT NOW() - INTERVAL 12 HOUR;                  -- 12 hours ago
SELECT DATEDIFF('2026-09-26', '2026-09-16');      -- Returns 10
SELECT DATEDIFF('2026-09-06', '2026-09-16');      -- Returns -10
SELECT TIMESTAMPDIFF(YEAR, '1995-05-10', '2026-09-16');  -- Returns Age: 31
SELECT TIMESTAMPDIFF(MONTH, '2026-01-01', '2026-09-16'); -- Returns 8
SELECT TIMEDIFF('14:30:00', '12:00:00');          -- Returns '02:30:00'
*/


select 
	employeeid, 
	birthdate,
    timestampdiff(year, birthdate, now()) as age
from employees;


-- Find the average shipping duration in days for each month.
select 
	month(orderdate) as orderdate,
    avg(DATEDIFF(shipdate, orderdate)) as avg_
from orders
group by month(orderdate);


-- Time Gap Analysis: Find the number of days between each order and the previous order.

SELECT 
    current_order.orderid,
    current_order.orderdate,
    previous_order.orderdate AS previous_order_date,
    -- Calculates: current_orderdate - previous_orderdate
    DATEDIFF(current_order.orderdate, previous_order.orderdate) AS days_since_last_order
FROM orders AS current_order
LEFT JOIN orders AS previous_order 
    ON previous_order.orderid = current_order.orderid - 1;



