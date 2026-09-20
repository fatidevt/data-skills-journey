-- evaluates a list of conditions and return a value when the first condtion is met
-- 
/* syntax full form
case
	when1 condition then result1 (this is the most important condition)
    when2 condition then result2
    ....
    else result (if none of the when condition is true) its optional
end
*/

/* syntax quick form
case col_name
	when1 val1 then res1
    when2 val2 then res2
    ....
    else result
end
*/
 
/* Rules
the iutput should be sme data type 
*/

/* EX1
Create a report showing total sales for each category:
	   - High: Sales over 50
	   - Medium: Sales between 20 and 50
	   - Low: Sales 20 or less
   The results are sorted from highest to lowest total sales.
*/
select category,
sum(sales) as Total_sales
from
(	select 
		orderid,
		sales,
	case
		when sales > 50 then 'High'
		when sales > 20  then 'Medium'
		when sales <= 20 then 'Low'
	end category
	from orders
) t
group by category
order by Total_sales desc;

-- use case : mammping values

select 
	employeeid,
    firstname,
    lastname,
    gender,
case
	when gender = 'M' then 'Male'
    when gender = 'F' then 'Female'
    else 'Not Available'
end gender_
from employees;
 
 
 -- Retrieve customer details with abbreviated country codes using quick form 

select 
	customerid,
    firstname,
    lastname,
    country,
case
	when country = 'Germany' then 'DE'
    when country = 'USA' then 'US'
    else 'Not available'
end Country_Abrr
from customers;

-- use case : handle nulls
-- Calculate the average score of customers, treating NULL as 0,
-- and provide CustomerID and LastName details.

select 
	customerid,
    lastname,
    score,
    avg(score) over() Avg_Costumer,
avg(
	case
		when score is null then 0
		else score
	end
) over() Avg_Costumer_Clean
from customers;

-- conditional aggregation
-- Count how many orders each customer made with sales greater than 30 

select 
    customerid,
    sum(
    case 
		when sales > 30 then 1
        else 0
	end
    ) TotalHighSales,
    count(*) TotalOrders
    
from orders
group by customerid




