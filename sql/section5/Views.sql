-- virtual table based on the result set of a query without storing the data in dayabase
-- views are read only
-- USE CASE 1 : Central query logic : store central, complex query logic in the database for access by multiple queries, reducing project complexity

-- ex : find the running total of sales for each month
-- using cte
with cte_monthly_summary as
(
		select 
        month(orderdate) OrderMonth,
        sum(sales) totol_sales,
        count(orderid) total_orders,
        sum(quantity) total_quantity
        from orders
        group by month(orderdate)
)
select 
OrderMonth,
totol_sales,
sum(totol_sales) over(order by OrderMonth ) as RunningTotal
from cte_monthly_summary;


-- using view

create view V_monthly_summary as 
(
	select 
	month(orderdate) OrderMonth,
	sum(sales) totol_sales,
	count(orderid) total_orders,
    sum(quantity) total_quantity
	from orders
	group by month(orderdate)
) ;


select 
OrderMonth,
totol_sales,
sum(totol_sales) over(order by OrderMonth ) as RunningTotal
from V_monthly_summary;

-- REMOVE A VIEW
drop view view_name;

-- Update a view
alter view ...;

-- USE CASE 2 : hide comlexity and improuve abstraction
-- encapsulates complex query logic , creating views for users (analysts ..) to not be obliged to explain 
-- the database schema or relationship models every time they need data.

/* TASK:
   Create a view that combines details from Orders, Products, Customers, and Employees.
   This view abstracts the complexity of multiple table joins.
*/

create view View_Combine_Details as
(
	select 
    o.orderid,
    o.orderdate,
    p.product,
    p.category,
    concat( coalesce(c.firstname, '') ,' ' , coalesce(c.lastname, '') ) as CustomerName,
    c.country as CustomerCountry,
    concat( coalesce(e.firstname, '') , ' ' , coalesce(e.lastname, '') ) as EmployeeName,
    e.department as EmployeeDepartment,
    o.sales,
    o.quantity
    from orders o
    left join products p
    on o.productid = p.productid
    left join customers c
    on o.customerid = c.customerid
    left join employees e
    on o.salespersonid = e.employeeid
);

-- CASE 3 : DATA SECURITY
-- PROTECT SENSITIVE DATA BY HIDING COLUMNS AND/OR ROWS FROM TABLES

/* TASK:
   Create a view for the EU Sales Team that combines details from all tables,
   but excludes data related to the USA.
*/

CREATE VIEW View_EU as
(
	select 
    o.orderid,
    o.orderdate,
    p.product,
    p.category,
    concat( coalesce(c.firstname, '') ,' ' , coalesce(c.lastname, '') ) as CustomerName,
    c.country as CustomerCountry,
    concat( coalesce(e.firstname, '') , ' ' , coalesce(e.lastname, '') ) as EmployeeName,
    e.department as EmployeeDepartment,
    o.sales,
    o.quantity
    from orders o
    left join products p
    on o.productid = p.productid
    left join customers c
    on o.customerid = c.customerid
    left join employees e
    on o.salespersonid = e.employeeid
    where c.country != 'USA'
    
);



