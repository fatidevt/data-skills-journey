-- STEP1 : write a query
-- for US customers find the total nb of customers and the avg score

select 
	count(*) as TotalCustomers,
	avg(score) as AvgScore
from customers
where country = 'USA';


-- STEP2 : Turning the query into a stored procedure
DELIMITER //
CREATE PROCEDURE GetCustomersSummary()
BEGIN
    SELECT 
        COUNT(*) AS TotalCustomers,
        AVG(score) AS AvgScore
    FROM customers
    WHERE country = 'USA';
END //

DELIMITER ;

-- STEP3: call the stored procedure
CALL GetCustomersSummary();

/* USING PARAMETERS */
-- stored procedure
DELIMITER //

CREATE PROCEDURE GetCustomersSummaryByCountry(
    IN input_country VARCHAR(50)
)
BEGIN
    SELECT 
        COUNT(*) AS TotalCustomers,
        AVG(score) AS AvgScore
    FROM customers
    -- Match the parameter's collation to your column's collation (or vice versa)
    WHERE country = input_country COLLATE utf8mb4_unicode_ci; 
END //

DELIMITER ;

-- call the stored procedure
CALL GetCustomersSummaryByCountry('Germany');


-- modify :: alter 
-- remove :: drop
