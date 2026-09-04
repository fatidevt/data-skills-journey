# Comprehensive SQL Commands Cheat Sheet

A complete reference guide to SQL commands categorized by sub-language, optimized for data analysis, query optimization, and freelance client reporting.

---

## 1. DQL (Data Query Language)
Used to retrieve and analyze data stored within relational databases.

### Key Commands
- **`SELECT`**: Fetches specific columns or calculated expressions from one or more tables.

### Basic Syntax & Clauses Order
```sql
SELECT column1, COUNT(column2) AS total_count
FROM table_name
JOIN secondary_table ON table_name.id = secondary_table.foreign_id
WHERE filter_condition
GROUP BY column1
HAVING COUNT(column2) > 10
ORDER BY total_count DESC
LIMIT 50;
```

---

## 2. DML (Data Manipulation Language)
Used to manipulate and manage row-level data stored inside database tables.

### Key Commands
- **`INSERT INTO`**: Adds new record rows into a table.
- **`UPDATE`**: Modifies existing data within specified table rows.
- **`DELETE`**: Removes existing rows based on a filtering condition.

### Syntax Examples
```sql
-- Insert new records
INSERT INTO clients (client_name, email, registration_date)
VALUES ('DataCorp', 'contact@datacorp.com', CURRENT_DATE);

-- Update existing records
UPDATE sales
SET status = 'Completed', updated_at = NOW()
WHERE payment_status = 'Paid' AND status = 'Pending';

-- Delete records safely
DELETE FROM customer_logs
WHERE log_date < '2025-01-01';
```

---

## 3. DDL (Data Definition Language)
Used to define, alter, and manage database schema structures (tables, views, indexes).

### Key Commands
- **`CREATE`**: Instantiates new databases, tables, or analytical views.
- **`ALTER`**: Modifies existing table structures (adding, dropping, or modifying columns).
- **`DROP`**: Deletes a table, view, or database permanently.
- **`TRUNCATE`**: Fast-deletes all rows from a table while keeping the table structure intact.

### Syntax Examples
```sql
-- Create a new table
CREATE TABLE projects (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    budget DECIMAL(10, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Modify table structure
ALTER TABLE projects ADD COLUMN status VARCHAR(20) DEFAULT 'Active';

-- Truncate vs Drop
TRUNCATE TABLE temporary_imports; -- Clears data, retains schema
DROP TABLE outdated_backup;       -- Removes data and schema permanently
```

---

## 4. DCL (Data Control Language)
Used to manage database user access rights, administrative privileges, and security.

### Key Commands
- **`GRANT`**: Grants specific administrative or query permissions to users.
- **`REVOKE`**: Removes assigned access privileges from users.

### Syntax Examples
```sql
-- Grant read-only access to a report user
GRANT SELECT ON analytics_db.* TO 'analyst_user'@'localhost';

-- Revoke permissions
REVOKE INSERT, UPDATE ON analytics_db.* FROM 'analyst_user'@'localhost';
```

---

## 5. TCL (Transaction Control Language)
Used to manage multi-step transactions, ensuring data integrity and consistency across database operations.

### Key Commands
- **`COMMIT`**: Saves all changes made in the current transaction permanently.
- **`ROLLBACK`**: Undoes all changes executed within the current transaction block.
- **`SAVEPOINT`**: Sets a rollback checkpoint within a multi-step transaction.

### Syntax Examples
```sql
START TRANSACTION;

UPDATE accounts SET balance = balance - 500 WHERE account_id = 101;
UPDATE accounts SET balance = balance + 500 WHERE account_id = 202;

-- Check logic before committing
COMMIT;

-- In case of failure:
-- ROLLBACK;
```

---

## Summary Matrix

| Category | Full Name | Primary Focus | Key Commands |
| :--- | :--- | :--- | :--- |
| **DQL** | Data Query Language | Data Fetching & Analysis | `SELECT` |
| **DML** | Data Manipulation Language | Row-Level Data Management | `INSERT`, `UPDATE`, `DELETE` |
| **DDL** | Data Definition Language | Schema & Table Architecture | `CREATE`, `ALTER`, `DROP`, `TRUNCATE` |
| **DCL** | Data Control Language | Permissions & Access Control | `GRANT`, `REVOKE` |
| **TCL** | Transaction Control Language | Data Integrity & Consistency | `COMMIT`, `ROLLBACK`, `SAVEPOINT` |

---

## MySQL Query Execution Order

When MySQL executes a `SELECT` statement, it processes clauses in this exact logical order:

$$	ext{FROM \& JOIN} \longrightarrow 	ext{WHERE} \longrightarrow 	ext{GROUP BY} \longrightarrow 	ext{HAVING} \longrightarrow 	ext{SELECT} \longrightarrow 	ext{DISTINCT} \longrightarrow 	ext{ORDER BY} \longrightarrow 	ext{LIMIT}$$
