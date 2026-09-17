-- Replace Values ------------------------------------------------------------------------
-- IFNULL(column_name, 'Fallback Value')
-- COALESCE(mobile_phone, home_phone, email, 'No Contact Info Available') AS primary_contact

-- NULLIF(expression1, expression2)
-- It compares the two expressions. If they are equal, the function returns NULL. If they are not equal, it returns expression1.

-- Zeroing Out (Prevents calculations from breaking/returning NULL)
SELECT price * IFNULL(discount, 0) FROM sales;

-- CHECK FOR NULLS

-- Filter FOR missing values (Find rows where the column is empty)
SELECT * FROM table_name 
WHERE column_name IS NULL;
-- Filter OUT missing values (Find rows where the column contains data)
SELECT * FROM table_name 
WHERE column_name IS NOT NULL;
-- Boolean Flag Check (Returns 1 if NULL, 0 if it contains data)
SELECT ISNULL(column_name) AS is_empty_flag FROM table_name;
-- Conditional Text Flag (Using CASE expressions for labels)
SELECT CASE 
    WHEN column_name IS NULL THEN 'Missing Data' 
    ELSE 'Valid Data' 
END AS data_status 
FROM table_name;
 -- EXAMPLES
select shipaddress , ifnull(shipaddress, 'MISSING DATA' )  from orders;
select shipaddress , ifnull(shipaddress, billaddress ) from orders;
select shipaddress , COALESCE(shipaddress, orderdate,'MISSING DATA' ) from orders;

-- find the avg scores of the customers
select * from customers;
select 
ifnull(score, 0)
from customers;

select 
avg(ifnull(score, 0)) as avg_score
from customers;

-- Display the full name of customers in a single field by merging their
-- first and last names, and add 10 bonus points to each customer's score.
select 
firstname, lastname,
concat(firstname, ' ', coalesce(lastname, '')) as full_name,
score,
coalesce(score, 0) + 10 as new_score
from customers;

-- USE CASES 
-- HANDLE NULLS BEFOR JOIN WHEN NULLS IN KEYS


-- HANDLE NULLS BEFORE SORTING DATA
-- EX : Sort the customers from lowest to highest scores,
-- with NULL values appearing last.

select *
from customers
order by case when score is null then 1 else 0 end, score;

-- NULLIF
-- Find the sales price for each order by dividing sales by quantity.
-- Uses NULLIF to avoid division by zero.
SELECT 
orderid,
sales,
quantity,
sales / quantity as price,
ifnull(sales / nullif(quantity,0) , 0) 
from orders;

-- IS NULL / IS NIT NULL
-- Identify the customers who have no scores 
select * from customers;
select 
	customerid, 
    firstname,
    lastname
from customers
where score is not null;

-- LEFT JOIN + IS NULL ==> ANT LEFT JOIN
-- List all details for customers who have not placed any orders 
select * from customers;
select * from orders;
select 
	c.*,
    o.orderid
from customers c
left join orders o
on c.customerid = o.customerid
where o.customerid is null;




















