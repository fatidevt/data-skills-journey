## SQL Session 1 — SELECT, WHERE, GROUP BY, HAVING, ORDER BY, LIMIT

### Quick Recall
Q: Difference between WHERE and HAVING?
A: WHERE filters before grouping, HAVING filters after grouping

Q: Why use aggregate functions with GROUP BY?
A: Multiple rows collapse into one group — need SUM/COUNT/AVG to summarize them

Q: What is aliasing?
A: Giving columns/tables shorter or more meaningful names using AS
   Column: SELECT AVG(age) AS avg_age
   Table:  FROM employees e JOIN departments d ON e.dept_id = d.id

### SQL Query Order (always write in this order)
SELECT      -- columns to show
FROM        -- table
WHERE       -- filter rows (before grouping)
GROUP BY    -- group rows
HAVING      -- filter groups (after grouping)
ORDER BY    -- sort results
LIMIT       -- cap number of rows

### Key Syntax
-- Basic SELECT
SELECT name, city, bill_amount
FROM patients
WHERE city = 'Rabat';

-- Multiple conditions
WHERE gender = 'Female' AND (city = 'Rabat' OR city = 'Casablanca')

-- GROUP BY + aggregates
SELECT city, COUNT(*) AS total, ROUND(AVG(bill_amount), 2) AS avg_bill
FROM patients
GROUP BY city;

-- HAVING — filter after grouping
HAVING COUNT(*) >= 2 AND SUM(bill_amount) > 3000

-- ORDER BY
ORDER BY bill_amount DESC   -- descending
ORDER BY bill_amount ASC    -- ascending (default)

-- LIMIT
LIMIT 3   -- top 3 rows only

-- ALIASING
SELECT AVG(age) AS average_age      -- column alias
FROM employees e                     -- table alias

### Aggregate Functions
COUNT(*)        -- count all rows
COUNT(col)      -- count non-null values
SUM(col)        -- total
AVG(col)        -- average
MAX(col)        -- highest value
MIN(col)        -- lowest value
ROUND(val, 2)   -- round to 2 decimals

### Golden Rules
-- 1. Anything in SELECT (non-aggregate) must be in GROUP BY
SELECT city, COUNT(*) FROM patients GROUP BY city; -- ✅

-- 2. Use parentheses with OR inside AND
WHERE gender = 'Female' AND (city = 'Rabat' OR city = 'Casablanca') -- ✅

-- 3. HAVING uses aggregate or alias, not raw column
HAVING COUNT(*) >= 2        -- ✅
HAVING total_patients >= 2  -- ✅ in MySQL
WHERE COUNT(*) >= 2         -- ❌ never works
