-- A query inside another query
-- the sub query executed first then the main query
-- why we use them for complex queries, we should devise the prob into steps
-- step1 , subquery1 , step2 , subquery2 .... last_step , main_query
-- the main query executed based on the subquery results

-- Result Types --- 
-- 1. scalar subquery (one value)
select 
avg(sales)
from orders;
-- 2. Row Subquery (Single columns & Multiple rows)
select 
customerid
from orders;
-- 3. Table Subquery (Multiple columns & Multiple rows)
select 
orderdate,
orderid,
customerid
from orders;

-- How to use Subqueries in different locations --
-- 1. FROM CLAUSE
--  Find the products that have a price higher than the average price of all products.
select * 
from 
(
	-- subquery
	select
		productid,
		price,
		avg(price) over() as AvgPrice
	from products
) t
where price > AvgPrice;

-- Rank Customers based on their total amount of sales.
select 
* ,
dense_rank() over(order by total_sales desc) as rank_
from
(
	select 
	customerid,
	sum(sales) total_sales
	from orders
    group by customerid
) t;

-- 2. SELECT CLAUSE
-- SELECT COL1 (SELECT COL2 , COL3 FROM T1 WHERE CONDITION) FROM T1
-- RULE : the result of the subquery must be a scalar query

-- Show the product IDs, product names, prices, and the total number of orders.
select 
	productid, 
    product, 
    price,
    ( select count(*) from orders ) total_orders
from products;

select count(*) from orders;

-- 4. SUBQUERY - JOIN CLAUSE
--  Show all customer details and find the total orders of each customer.

select 
c.*,
o.TotalOrders
from customers c
left join(
select customerid, count(orderid)  TotalOrders
from orders
group by customerid) o
on c.customerid = o.customerid;

-- SUBQUERY | COMPARISON OPERATORS
-- only scalar subquery is allowed to be used

-- Find the products that have a price higher than the average price of all products.
select 
* 
from products
where price > (select avg(price) from products);

-- SUBQUERY | IN OPERATOR
-- logical operators : in any all exists
-- in operator => chec whether a value matches any value from a list

-- Show the details of orders made by customers in Germany.
select 
* 
from orders
where customerid in (select customerid from customers where country = 'Germany');

-- Show the details of orders made by customers not in Germany.
select 
* 
from orders
where customerid in (select customerid from customers where country != 'Germany');

-- any operator => check if a value matches any value within a list
-- Find female employees whose salaries are greater than the salaries of any male employees.

select 
* 
from employees
where gender = 'F' and salary > any (select salary from employees where gender = 'M' );

-- all operator => check if a value matches all value within a list
-- Find female employees whose salaries are greater than the salaries of all male employees.
select 
* 
from employees
where gender = 'F' and salary > all (select salary from employees where gender = 'M' );

-- Non - correlated | correlated subqueries
-- Non - correlated : run independently from the main query
-- correlated : rely on values from the subquery

-- Show all customer details and the total orders for each customer using a correlated subquery.
select 
* ,
(select count(*) from orders o where o.customerid = c.customerid) TotalOrders
from customers c;

-- SUBQUERY | EXISTS OPERATOR
-- Show the details of orders made by customers in Germany.

select 
* 
from orders o
where exists ( select * 
	           from customers c
			   where country = 'Germany'
			   and o.customerid = c.customerid);





