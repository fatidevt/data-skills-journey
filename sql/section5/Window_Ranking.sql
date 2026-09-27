-- window functions - ranking
-- Rules
-- order by is required -- 
-- expression is empty 
-- frame not allowed

-- ROW NUMBER
-- ASIGN A UNIQUE NB TO EACH ROW + it doesn't handle ties (in case there is dupplicated data)
-- syntax : row_number() over(order by sales desc)

-- RANK
-- ASIGN A RANK NB TO EACH ROW + it handles ties (in case there is dupplicated data) + it leaves a gap
-- syntax : rank() over( order by sales desc )

-- DENSE RANK
-- ASIGN A RANK NB TO EACH ROW + it handles ties (in case there is dupplicated data) + it doesn't leaves any gaps
-- syntax : dense_rank() over( order by sales desc )

-- Exercice :  Rank Orders Based on Sales from Highest to Lowest
select 
	orderid,
    orderdate,
    sales,
    row_number() over( order by sales desc ) Sales_Row,
	rank() over( order by sales desc ) Sales_Rank,
	dense_rank() over( order by sales desc ) Sales_Dense_Rank
from orders;

-- Use Case | Top-N Analysis: Find the Highest Sale for Each Product
select * 
from (
select 
	orderid,
	productid,
	sales,
	row_number() over (partition by productid order by sales desc) row_sales
from orders) t
where row_sales = 1;

-- Use Case | Bottom-N Analysis: Find the Lowest 2 Customers Based on Their Total Sales
select * 
from
(	
	select 
		customerid,
		sum(sales) as total_sales_cust,
		row_number() over(order by  sum(sales) ) as row_sales
	from orders
	group by customerid
) t 
where row_sales <= 2;

-- Use Case | Assign Unique IDs to the Rows of the 'Order Archive'
select 
	*,
	row_number() over(order by orderid) as UniqueIDs
from orders_archive;

-- Use Case | Identify Duplicates:
-- Identify Duplicate Rows in 'Order Archive' and return a clean result without any duplicates
-- Notes : if the ranks > 1 so the primary key (the parition by column) has duplicates
-- for this exercices we choose for duplicated orders the recent order using creationtime
-- ex for order 4 we choosed to keep recent one with creation date 14:50 and not 05:50
select * 
from
(
	select 
		orderid,
		orderdate,
		creationtime,
		row_number() over(partition by orderid order by creationtime desc) as row_
	from orders_archive
) t
where row_ = 1;

select 
		orderid,
		orderdate,
		creationtime,
		row_number() over(partition by orderid order by creationtime desc) as row_

from orders_archive;

-- NTILE
-- divide sth rows into a specified number of groups approximately equal groups (Buckets)
-- syntax : ntile(nb_of_buckets) over (order by column)
-- bucket size = nub_of_rows / nb_of_buckets
-- exemple1 nub_of_rows = 6 , nb_of_buckets = 2 ,  so bucket size = 3
-- so 1 1 1 2 2 2
-- exemple2 nub_of_rows = 5 , nb_of_buckets = 2 ,  so bucket size = 2.5
-- sql rule : larger groups came first
-- so 1 1 1 2 2 

-- Divide Orders into Groups Based on Sales
select 
	orderid,
    sales,
    ntile(1) over(order by sales desc) as OneBucket,
    ntile(2) over(order by sales desc) as TwoBuckets,
    ntile(3) over(order by sales desc) as ThreeBuckets
from orders;

-- Segment all Orders into 3 Categories: High, Medium, and Low Sales.
select 
	*,
    case tile
		when 1 then 'High'
		when 2 then 'Meduim'
		when 3 then 'Low'
    end sales_category
from
(
	select 
		orderid,
		sales,
		ntile(3) over(order by sales desc) tile
	from orders
) t ;

-- In order to export the data ,  Divide Orders into 2 Groups 
select 
	* ,
    ntile(2) over() Groups_
from orders;

-- CUME_DIST
-- cumulative distribution, calculates the distribution of data points within a window
-- formula : cum_dist = position nr / nb_of_rows
-- syntax = cum_dist() over(order by sales desc)
-- rule : if we have duplicates the position of the last occurence of the same values
-- example if we have sales 80 80 in row 2 , 3 so :  3/nb_of_rows will be cume_dist of row 2 and 3

-- percent_rank
-- cumulative distribution, calculates the distribution of data points within a window
-- formula : percent_rank = position_nr -1  / nb_of_rows -1
-- syntax = cum_dist() over(order by sales desc)
-- rule : if we have duplicates the position of the first occurence of the same values
-- example if we have sales 80 80 in row 2 , 3 so :  2/nb_of_rows will be cume_dist of row 2 and 3

-- Find Products that Fall Within the Highest 40% of the Prices
-- 40% most expensive products
select 
*,
concat(DistRank * 100 , '%' ) as percentage  
from
(
	select 
		productid,
		product,
		price,
		cume_dist() over( order by price desc) DistRank
	from products
) t where DistRank <= 0.4




