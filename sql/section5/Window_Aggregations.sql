-- Find the total sales across all orders,
-- additionally providing details such as OrderID and OrderDate 
select 
	productid,
    sum(sales) over () Total_Sales,
    orderid,
    orderdate
from orders;

-- Find the total sales across all orders and for each product,
-- additionally providing details such as OrderID and OrderDate 

select 
	orderid,
    orderdate,
    sum(sales) over (partition by productid)
from orders;


-- Find the total sales across all orders, for each product,
-- and for each combination of product and order status,
-- additionally providing details such as OrderID and OrderDate 
select 
	productid,
    orderdate,
    orderid,
    orderstatus,
    sum(sales) over (partition by productid) as total_sales_by_product,
    sum(sales) over (partition by productid, orderstatus) as total_sales_by_product_and_status
from orders;

-- Rank each order by Sales from highest to lowest
select 
    orderid,
    sales,
    rank() over (order by sales desc ) rank_sales
from orders;

-- frame
select 
	orderid,
    orderdate,
	orderstatus,
    sales,
    sum(sales) over (partition by orderstatus order by orderdate rows between current row and 2 following) kiki
from orders;

--  Rank customers by their total sales 
-- rule anything inside the window funct should be part of the group by 
select 
	customerid,
    sum(sales),
    rank() over ( order by sum(sales) )
from orders
group by customerid;


-- Find the Average Sales Across All Orders 
-- Find the Average Sales for Each Product
select 
	orderid,
    orderdate,
    productid,
    sales,
    avg(sales) over() avg_sales_,
    avg(sales) over(partition by productid) avg_sales_by_prod
from orders;

-- Find the Average Scores of Customers
select 
	*,
    coalesce(score, 0) customer_score,
    avg(score) over() avg_score,
    avg(coalesce(score, 0)) over() acg_score_without_null
from customers;

-- Find all orders where Sales exceed the average Sales across all orders
select
	orderid,
	orderdate,
    sales
from(
	select 
		orderid,
		orderdate,
		sales,
		avg(sales) over () avg_sales
	from orders
    ) t
where sales > avg_sales;

-- Find the Highest and Lowest Sales across all orders
-- Find the Highest and Lowest Sales across all orders and by Product
select 
	orderid,
    orderdate,
    sales,
    productid,
    max(sales) over() as HighestSales,
    min(sales) over() as LowestSales,
    max(sales) over(partition by productid) as HighestSalesByProd,
    min(sales) over(partition by productid) as LowestSalesByProd
from orders;

-- Show the employees who have the highest salaries
select 	
	*
from(
    select 
		*,
		max(salary) over() highest_salaries
	from employees
    ) t
where salary = highest_salaries ;

-- Find the deviation of each Sale from the minimum and maximum Sales
-- deviation from min = sales - min
-- deviation from max = max - sales
-- objectif = evaluating the data points to the extremes

select 
	orderid,
    orderdate,
    sales,
    productid,
    max(sales) over() as HighestSales,
    min(sales) over() as LowestSales,
    sales  - min(sales) over() DeviationFromMin,
    max(sales) over() - sales DeviationFromMax 
from orders; 

/* Use Case | ROLLING SUM & AVERAGE */
-- Calculate the moving average of Sales for each Product over time
select 
    productid,
    sales,
    orderdate,
    avg(sales) over(partition by productid)  AvgByProduct,
	avg(sales) over(partition by productid order by orderdate)  MovingAvg
from orders;

-- Calculate the moving average of Sales for each Product over time,
-- including only the next order
select 
    productid,
    sales,
    orderdate,
	avg(sales) over(partition by productid order by orderdate)  MovingAvg,
	avg(sales) over(partition by productid order by orderdate rows between current row and 1 following)  MovingAvgNextOrder
from orders;


 
