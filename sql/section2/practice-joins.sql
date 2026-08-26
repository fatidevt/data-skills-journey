/*
INNER JOIN → matching rows
LEFT JOIN → keep all customers
RIGHT JOIN → keep all orders
is null to find unmattched rows
*/
select * from customers;
select * from orders;
-- Show customers who have placed an order
select c.name , o.product
from customers as c
inner join orders as o
on c.customer_id = o.customer_id;

-- Show ALL customers, including customers who have never placed an order.
select c.name , c.city ,  o.product
from customers as c
left join orders as o
on c.customer_id = o.customer_id;

-- Show ALL orders, including orders whose customer doesn't exist in the customers table.
select o.order_id , c.name ,  o.product
from customers as c
right join orders as o
on c.customer_id = o.customer_id;

-- Find customers who have NOT placed any order.
SELECT c.name, c.city
FROM customers AS c
LEFT JOIN orders AS o
  ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;

-- Show customers who placed an order worth more than $50.
SELECT c.name, o.product, o.amount
FROM customers AS c
INNER JOIN orders AS o
  ON c.customer_id = o.customer_id
WHERE o.amount > 50;

-- Show ALL customers, even customers who have never placed an order. For customers who have orders, only show orders worth more than $50.
SELECT c.name, o.product, o.amount
FROM customers AS c
LEFT JOIN orders AS o
  ON c.customer_id = o.customer_id
  AND o.amount > 50;

/*
INNER = matching only
LEFT = keep everything from the LEFT table. (A)
RIGHT = keep everything from the RIGHT table. (B)
from A join B
---------------
Find A without B : 
FROM A
LEFT JOIN B
WHERE B.id IS NULL
*/

-- Show customers who have placed an order. Display their name, product, and amount. 
-- Only include orders greater than $50, and sort the results from the highest amount to the lowest.

SELECT c.name, o.product, o.amount
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id
WHERE o.amount > 50
ORDER BY o.amount desc;

-- Show ALL customers and their orders. 
-- However, only show orders greater than $50. Keep customers who don't have any order greater than $50. Finally, sort customers alphabetically by name.

SELECT c.name, o.product, o.amount
FROM customers AS c
left JOIN orders AS o
ON c.customer_id = o.customer_id
and o.amount > 50
ORDER BY c.name;

/*
ON → controls which rows match during the JOIN
WHERE → filters the result AFTER the JOIN
*/


