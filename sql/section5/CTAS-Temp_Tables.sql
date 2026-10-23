-- Table types : permanent + temporary
-- permanent : 2 ways to create : create/insert - CTAS
-- 

/* 
Create/Insert 
	1. Create | define the structure of the table
	2. Insert | insert data into the table

CTAS : Create Table As Select
	Create a new table based on the result of an sql query
    
Diff btw CTAS and Views:
	CTAS creates a permanent physical table once with a snapshot of data, 
    while a View creates a saved query that runs live and updates every time you open it.
*/

-- Create/Insert 
create table kiki
(
	id int,
    name varchar(50)
);

insert into kiki
values(1 , 'Frank');


-- CTAS syntax
create table kiki as 
(
	select ..
    from ..
    where ..
);

insert into kiki
values(1 , 'Frank');

-- ex ctas : total nb of orders of each month

create table Monthly_Orders as 
(
	select 
    monthname(orderdate) Order_Month,
    count(orderid) Total_Orders
    from orders
    group by monthname(orderdate)
);

drop table monthly_orders;
