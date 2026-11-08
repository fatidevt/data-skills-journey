/* ------------------------------------------------------------------------------
   Tip 1: Select Only What You Need
------------------------------------------------------------------------------ */

-- Bad Practice
SELECT * FROM Sales.Customers

-- Good Practice
SELECT CustomerID, FirstName, LastName FROM Sales.Customers

/* ------------------------------------------------------------------------------
   Tip 2: Avoid unnecessary DISTINCT & ORDER BY
------------------------------------------------------------------------------ */

-- Bad Practice
SELECT DISTINCT
    FirstName
FROM Sales.Customers
ORDER BY FirstName

-- Good Practice
SELECT
    FirstName
FROM Sales.Customers

/* ------------------------------------------------------------------------------
   Tip 3: For Exploration Purpose, Limit Rows!
------------------------------------------------------------------------------ */

-- Bad Practice
SELECT
    OrderID,
    Sales
FROM Sales.Orders

-- Good Practice
SELECT TOP 10
    OrderID,
    Sales
FROM Sales.Orders

/* ==============================================================================
   2. FILTERING
============================================================================== */

/* ------------------------------------------------------------------------------
   Tip 4: Create nonclustered Index on frequently used Columns in WHERE clause
------------------------------------------------------------------------------ */

SELECT *
FROM Sales.Orders
WHERE OrderStatus = 'Delivered';

CREATE NONCLUSTERED INDEX Idx_Orders_OrderStatus ON Sales.Orders(OrderStatus)

/* ------------------------------------------------------------------------------
   Tip 5: Avoid applying functions to columns in WHERE clauses
------------------------------------------------------------------------------ */

-- Bad Practice
SELECT * FROM Sales.Orders
WHERE LOWER(OrderStatus) = 'delivered'

-- Good Practice
SELECT * FROM Sales.Orders
WHERE OrderStatus = 'Delivered'
---------------------------------------------------------
-- Bad Practice
SELECT *
FROM Sales.Customers
WHERE SUBSTRING(FirstName, 1, 1) = 'A'

-- Good Practice
SELECT *
FROM Sales.Customers
WHERE FirstName LIKE 'A%'
---------------------------------------------------------
-- Bad Practice
SELECT *
FROM Sales.Orders
WHERE YEAR(OrderDate) = 2025

-- Good Practice
SELECT *
FROM Sales.Orders
WHERE OrderDate BETWEEN '2025-01-01' AND '2025-12-31'

/* ------------------------------------------------------------------------------
   Tip 6: Avoid leading wildcards as they prevent index usage
------------------------------------------------------------------------------ */

-- Bad Practice
SELECT *
FROM Sales.Customers
WHERE LastName LIKE '%Gold%'

-- Good Practice
SELECT *
FROM Sales.Customers
WHERE LastName LIKE 'Gold%'

/* ------------------------------------------------------------------------------
   Tip 7: Use IN instead of Multiple OR
------------------------------------------------------------------------------ */

-- Bad Practice
SELECT *
FROM Sales.Orders
WHERE CustomerID = 1 OR CustomerID = 2 OR CustomerID = 3

-- Good Practice
SELECT *
FROM Sales.Orders
WHERE CustomerID IN (1, 2, 3)

/* ==============================================================================
   3. JOINS
============================================================================== */

/* ------------------------------------------------------------------------------
   Tip 8: Understand The Speed of Joins & Use INNER JOIN when possible
------------------------------------------------------------------------------ */

-- Best Performance
SELECT c.FirstName, o.OrderID FROM Sales.Customers c INNER JOIN Sales.Orders o ON c.CustomerID = o.CustomerID

-- Slightly Slower Performance
SELECT c.FirstName, o.OrderID FROM Sales.Customers c RIGHT JOIN Sales.Orders o ON c.CustomerID = o.CustomerID
SELECT c.FirstName, o.OrderID FROM Sales.Customers c LEFT JOIN Sales.Orders o ON c.CustomerID = o.CustomerID

-- Worst Performance
SELECT c.FirstName, o.OrderID FROM Sales.Customers c FULL OUTER JOIN Sales.Orders o ON c.CustomerID = o.CustomerID

/* ------------------------------------------------------------------------------
   Tip 9: Use Explicit Join (ANSI Join) Instead of Implicit Join (non-ANSI Join)
------------------------------------------------------------------------------ */

-- Bad Practice
SELECT o.OrderID, c.FirstName
FROM Sales.Customers c, Sales.Orders o
WHERE c.CustomerID = o.CustomerID

-- Good Practice
SELECT o.OrderID, c.FirstName
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
    ON c.CustomerID = o.CustomerID;

-- For simple queries: there is no measurable performance difference
-- if both ANSI and non-ANSI queries are correctly written.
-- For complex queries: ANSI joins are usually easier to optimize and debug
-- because their structure makes the intent of the query clearer.

/* ------------------------------------------------------------------------------
   Tip 10: Make sure to Index the columns used in the ON clause
------------------------------------------------------------------------------ */

SELECT c.FirstName, o.OrderID
FROM Sales.Orders AS o
INNER JOIN Sales.Customers AS c
    ON c.CustomerID = o.CustomerID;

CREATE NONCLUSTERED INDEX IX_Orders_CustomerID ON Sales.Orders(CustomerID)

/* ------------------------------------------------------------------------------
   Tip 11: Filter Before Joining (Big Tables)
------------------------------------------------------------------------------ */

-- Best Practice For Small-Medium Tables
-- Filter After Join (WHERE)
SELECT c.FirstName, o.OrderID
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE o.OrderStatus = 'Delivered';

-- Filter During Join (ON)
SELECT c.FirstName, o.OrderID
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
    ON c.CustomerID = o.CustomerID
   AND o.OrderStatus = 'Delivered';

-- Best Practice For Big Tables
-- Filter Before Join (SUBQUERY)
SELECT c.FirstName, o.OrderID
FROM Sales.Customers AS c
INNER JOIN (
    SELECT OrderID, CustomerID
    FROM Sales.Orders
    WHERE OrderStatus = 'Delivered'
) AS o
    ON c.CustomerID = o.CustomerID;
