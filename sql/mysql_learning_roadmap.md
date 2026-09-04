# MySQL Learning Roadmap for Data Analysts

A structured 60-hour roadmap designed to master MySQL and Workbench for freelance data analytics.

---

## Overview

| Phase | Core Focus | Estimated Hours |
| :--- | :--- | :--- |
| **Phase 1** | MySQL & Workbench Core Setup | 10 Hours |
| **Phase 2** | Data Aggregation & Multi-Table Joins | 15 Hours |
| **Phase 3** | Date, String & Data Cleanup Functions | 10 Hours |
| **Phase 4** | Advanced Analysis & Modular SQL | 15 Hours |
| **Phase 5** | Practical Portfolio Projects | 10 Hours |
| **Total** | **Complete SQL Roadmap** | **60 Hours** |

---

## Detailed Curriculum

### Phase 1: MySQL & Workbench Core Setup
* **Estimated Time:** 10 Hours
* **Objective:** Get familiar with the MySQL Workbench interface, table creation, basic querying, and basic filtering mechanics.

#### Topics Breakdown
* **Workbench Essentials (2 hrs):** Connecting to local instances, using the Query Editor, reading execution output, exporting/importing `.csv` and `.sql` files.
* **Database & Table Basics (3 hrs):** Data types (`INT`, `VARCHAR`, `DECIMAL`, `DATE`), `CREATE TABLE`, `INSERT INTO`, Primary & Foreign Keys.
* **Filtering & Sorting (5 hrs):** `SELECT`, `WHERE` filtering (`LIKE`, `IN`, `BETWEEN`), `ORDER BY`, `LIMIT`, and handling `NULL` values.

---

### Phase 2: Data Aggregation & Multi-Table Joins
* **Estimated Time:** 15 Hours
* **Objective:** Focus on combining datasets and calculating key business metrics like totals, averages, and group counts.

#### Topics Breakdown
* **Combining Tables with Joins (7 hrs):** `INNER JOIN`, `LEFT JOIN` (critical for missing data), `RIGHT JOIN`, and joining more than 2 tables at once.
* **Aggregating Data (5 hrs):** `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, along with `GROUP BY` and filtering aggregated results using `HAVING`.
* **Conditional Logic (3 hrs):** Writing `CASE WHEN` statements to create custom categories and data buckets.

---

### Phase 3: Date, String & Data Cleanup Functions
* **Estimated Time:** 10 Hours
* **Objective:** Learn to clean messy client datasets and analyze time-series patterns.

#### Topics Breakdown
* **Date & Time Operations (5 hrs):** `DATE_FORMAT()`, `DATEDIFF()`, `DATE_ADD()`, `YEAR()`, `MONTH()`, extracting cohort dates.
* **String Operations (5 hrs):** `CONCAT()`, `SUBSTRING()`, `TRIM()`, `REPLACE()`, `LOWER()`/`UPPER()`, handling inconsistent text entries.

---

### Phase 4: Advanced Analysis & Modular SQL
* **Estimated Time:** 15 Hours
* **Objective:** Master high-value queries for cohort tracking, ranking, and complex multi-step reporting.

#### Topics Breakdown
* **Common Table Expressions (CTEs) & Subqueries (6 hrs):** Using `WITH` clauses to break complex client queries into readable steps.
* **Window Functions (7 hrs):** `ROW_NUMBER()`, `RANK()`, `LEAD()`, `LAG()` combined with `OVER (PARTITION BY ... ORDER BY ...)`.
* **Database Views (2 hrs):** Using `CREATE VIEW` to store complex queries so clients or dashboards can connect directly to them.

---

### Phase 5: Practical Portfolio Projects
* **Estimated Time:** 10 Hours
* **Objective:** Apply your skills to simulated client datasets and store them on GitHub to show prospective buyers.

#### Topics Breakdown
* **E-Commerce Sales Analysis (5 hrs):** Calculate Month-over-Month growth, customer lifetime value (LTV), and top-selling categories using CTEs and window functions.
* **Customer Churn & Retention Cohorts (5 hrs):** Build a retention query calculating how many users return 30/60/90 days after signup.
