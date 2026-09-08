/*Level 1: Beginner CTE Exercises
Exercise 1: Single CTE
Using the employees table:
Write a query using a CTE named dept_avg that calculates the average salary for each department. 
Then, in the main query, join employees with dept_avg to display each employee: 
emp_name, department, salary, and their department average salary (avg_salary).*/
---------------------------------
select * from employees;
----------------------------------
with dept_avg as 
(
	select department , avg(salary) as avg_salary
    from employees
    group by department
)
select e.emp_name, e.department, e.salary, d.avg_salary
from employees e
join dept_avg d
on e.department = d.department;

/*
Exercise 2: Chaining CTEs (Multi-CTE)
Using the orders, order_items, and products tables:
Write a query using two CTEs:
cte_item_totals: Calculates the total cost for each line item (quantity * unit_price). Select order_id, product_id, and item_total.
cte_order_totals: Takes the result from cte_item_totals and calculates the total order value per order_id (SUM(item_total)).
Main Query: Select order_id and total_order_value from cte_order_totals for orders where the total value is greater than $50.00.
*/
select * from orders;
select * from order_items;
select * from products;
------
with cte_item_totals as 
(
	select oi.order_id, p.product_id, (oi.quantity * p.unit_price) as item_total
    from order_items oi
    join products p 
    on oi.product_id = p.product_id
),
cte_order_totals as
(	
	select order_id, SUM(item_total) AS total_order_value
    from cte_item_totals
    GROUP BY order_id
)
select order_id, total_order_value
from cte_order_totals
WHERE total_order_value > 50;

-- Find all customers whose total spending across all orders is greater than $200.
with customer_totals as
(
	select customer_id, sum(amount) as total_spent
    from my_orders
    group by customer_id
)
select customer_id, total_spent
from customer_totals 
where total_spent > 200; 

-- Find all products that are more expensive than the average product price in their category.
/*
Break it into 2 steps:
Step 1 (Inside the CTE):
Write a query that calculates the average unit_price for each category.
Select category and AVG(unit_price) AS avg_category_price from products, grouped by category.
Name this CTE category_averages.
Step 2 (The Main Query):
Join the original products table (p) with your CTE category_averages (ca) on category.
Select p.product_name, p.category, p.unit_price, and ca.avg_category_price.
Filter where p.unit_price > ca.avg_category_price.
*/
with category_averages as
(
	select category, avg(unit_price) as avg_category_price
    from products
    group by category
)
select p.product_id, p.product_name, p.unit_price, ca.avg_category_price
from products p 
join category_averages ca
on p.category = ca.category
where p.unit_price > ca.avg_category_price; 

/*
Practice Problem (Try breaking it down yourself!)
Using your employees table:
The Question: "Find the employee(s) who earn the highest salary in each department."
Before writing the SQL code, try answering these 3 questions in plain English:
Step 1 (Inside CTE): What window function and PARTITION BY / ORDER BY clause will 
you write to give every employee a salary ranking inside their department?
Step 2 (CTE Name): What will you name your temporary table?
Step 3 (Main Query): What filter will you put in the WHERE clause of your main query?
Once you write out the logic, turn it into SQL!
*/
select * from employees;
with sal_by_dep as 
(
select emp_id, emp_name, salary, department, 
row_number() over(partition by department order by salary desc ) as rnk
from employees
)
select * 
from sal_by_dep
where rnk = 1;








