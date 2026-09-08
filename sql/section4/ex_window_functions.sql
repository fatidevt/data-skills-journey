-- TAVLE CREATION
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);
INSERT INTO employees (emp_id, emp_name, department, salary) VALUES
(101, 'Alice', 'Sales', 80000),
(102, 'Bob', 'Sales', 80000),
(103, 'Charlie', 'Sales', 75000),
(104, 'Diana', 'IT', 95000),
(105, 'Evan', 'IT', 90000);
select * from employees;
-- Level 1: Beginner Practice
/*
Exercise 1
Write a query that displays every employee's emp_name, department, and salary, along with 
a column named salary_rank that ranks employees within their department by salary from highest to lowest. 
If two employees in the same department have identical salaries, they should receive the same rank, 
and the next rank should skip (e.g., 1, 1, 3).
*/
select emp_name, department, salary, 
	rank() over(partition by department order by salary desc) as salary_rank
from employees;

/*
Exercise 2
What exact value will your query output for salary_rank for Charlie?
*/
-- number 3

-- Level 2: Intermediate Practice
-- Create the table
CREATE TABLE my_orders (
    order_id INT PRIMARY KEY,
    customer_id VARCHAR(10),
    order_date DATE,
    amount INT
);
INSERT INTO my_orders (order_id, customer_id, order_date, amount) VALUES
(1, 'C101', '2024-01-01', 100),
(2, 'C101', '2024-01-05', 150),
(3, 'C101', '2024-01-10', 200),
(4, 'C102', '2024-01-02', 300),
(5, 'C102', '2024-01-08', 50);
select * from my_orders;
/*
Exercise 1: Cumulative Sum
Write a query to display order_id, customer_id, order_date, amount, 
and a column named running_total that shows the cumulative sum of order amounts for each customer, 
ordered chronologically by order_date.
*/
select order_id, customer_id, order_date, amount, 
sum(amount) over (partition by customer_id order by order_date asc) as running_total
from my_orders;

/*
Exercise 2: Filtering on Window Functions
Using the same orders table, suppose you want to find only the most recent order for each customer.
Will the following query work? Why or why not? If not, how do you fix it?

SELECT customer_id, order_id, order_date
FROM my_orders
WHERE ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) = 1;
*/

--
select order_id, customer_id, order_date, amount, 
	row_number() over (partition by customer_id order by order_date desc) as row_nb
from my_orders;
--


select order_id, customer_id, order_date
from
	(select order_id, customer_id, order_date, amount, 
	row_number() over (partition by customer_id order by order_date desc) as row_nb
    from my_orders
    ) sub
where row_nb=1; 

select * from employees;
/*
ex for subqueries:
Write a query using a Subquery to find the top earner (highest salary) in each department from our original employees table
*/

SELECT emp_id, emp_name, department, salary
FROM (
    SELECT emp_id, emp_name, department, salary,
           DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rnk
    FROM employees
) sub
WHERE rnk = 1;

/*
Level 3: Advanced Scenario (Core Functions Only)
Suppose you manage an e-commerce platform with a customer_purchases table tracking every transaction:

The Business Requirement:
Your marketing team wants to find the single highest purchase amount made by each customer in each category.
However, if a customer has a tie for their highest purchase amount in a category 
(e.g., Customer C101 spending $500 twice in Electronics), the team only wants to keep exactly one row 
(the earliest purchase date) so they don't send duplicate promotional emails.

The Challenge:
Write a single SQL query using a CTE or subquery that returns customer_id, category, 
purchase_date, and amount for these top purchases.
Hint: Think carefully about whether ROW_NUMBER(), RANK(), or DENSE_RANK() helps you break the tie and enforce 
getting exactly one row per customer-category pair.
*/
CREATE TABLE customer_purchases (
    purchase_id INT PRIMARY KEY,
    customer_id VARCHAR(50),
    category VARCHAR(100),
    purchase_date DATE,
    amount DECIMAL(10, 2)
);

-- Insert the structured data
INSERT INTO customer_purchases (purchase_id, customer_id, category, purchase_date, amount) VALUES
(1, 'C101', 'Electronics', '2024-01-01', 500.00),
(2, 'C101', 'Electronics', '2024-01-05', 500.00),
(3, 'C101', 'Books',       '2024-01-10', 30.00),
(4, 'C102', 'Electronics', '2024-01-02', 1200.00),
(5, 'C102', 'Books',       '2024-01-03', 45.00),
(6, 'C102', 'Books',       '2024-01-08', 45.00);
--
SELECT * FROM customer_purchases;

SELECT customer_id, category, purchase_date, amount
FROM (
    SELECT customer_id, category, purchase_date, amount, 
           ROW_NUMBER() OVER (
               PARTITION BY customer_id, category 
               ORDER BY amount DESC, purchase_date ASC
           ) AS row_kiki
    FROM customer_purchases
) sub
WHERE row_kiki = 1;





