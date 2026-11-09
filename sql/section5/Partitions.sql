/* Definition:
Splitting a massive table into smaller physical pieces on disk, while your queries still treat it as a single table.

Why use it:
Faster queries: MySQL only searches the relevant partition instead of the whole table.
Easy maintenance: You can quickly delete old data by dropping an entire partition.

Quick Example (Range Partitioning by Year):
ALTER TABLE ma_table 
PARTITION BY RANGE COLUMNS(date_vente) (
    PARTITION p_2023 VALUES LESS THAN ('2024-01-01'),
    PARTITION p_2024 VALUES LESS THAN ('2025-01-01'),
    PARTITION p_futur VALUES LESS THAN (MAXVALUE)
);


-- list your partitions:
SELECT 
    TABLE_NAME, 
    PARTITION_NAME, 
    PARTITION_ORDINAL_POSITION, 
    TABLE_ROWS
FROM 
    INFORMATION_SCHEMA.PARTITIONS
WHERE 
    TABLE_SCHEMA = 'nom_de_votre_base' 
    AND TABLE_NAME = 'nom_de_votre_table';

-- Remove partitioning from the table
ALTER TABLE nom_de_votre_table REMOVE PARTITIONING;
*/


-- Step 1: Check file-per-table configuration
SHOW VARIABLES LIKE 'innodb_file_per_table';

-- Step 2: Create the partitioned table
CREATE TABLE Sales (
    SaleID INT NOT NULL,
    SaleDate DATE NOT NULL,
    Amount DECIMAL(10,2)
)
ENGINE = InnoDB

PARTITION BY RANGE COLUMNS(SaleDate) (

    PARTITION p_before_2023
    VALUES LESS THAN ('2023-01-01')
    TABLESPACE = innodb_file_per_table,

    PARTITION p_2023
    VALUES LESS THAN ('2024-01-01')
    TABLESPACE = innodb_file_per_table,

    PARTITION p_2024
    VALUES LESS THAN ('2025-01-01')
    TABLESPACE = innodb_file_per_table,

    PARTITION p_2025
    VALUES LESS THAN ('2026-01-01')
    TABLESPACE = innodb_file_per_table,

    PARTITION p_2026
    VALUES LESS THAN ('2027-01-01')
    TABLESPACE = innodb_file_per_table,

    PARTITION p_future
    VALUES LESS THAN (MAXVALUE)
    TABLESPACE = innodb_file_per_table
);

-- insert data
INSERT INTO Sales (SaleID, SaleDate, Amount)
VALUES
(1, '2022-05-10', 500),
(2, '2023-03-15', 700),
(3, '2024-06-20', 900),
(4, '2025-02-10', 1200),
(5, '2026-08-15', 1500),
(6, '2027-01-01', 2000);

-- Verify partitioning
SHOW CREATE TABLE Sales;

SELECT
    PARTITION_NAME,
    PARTITION_DESCRIPTION,
    TABLE_ROWS
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_SCHEMA = DATABASE()
AND TABLE_NAME = 'Sales';

-- test 
SELECT * FROM Sales PARTITION (p_2023);

-- Query lists all partitioned tables and their partitions
SELECT
    TABLE_SCHEMA AS DatabaseName,
    TABLE_NAME AS TableName,
    PARTITION_NAME AS PartitionName,
    PARTITION_METHOD AS PartitionFunction,
    PARTITION_ORDINAL_POSITION AS PartitionNumber,
    PARTITION_EXPRESSION AS PartitionExpression,
    PARTITION_DESCRIPTION AS PartitionDescription,
    TABLESPACE_NAME AS TablespaceName

FROM INFORMATION_SCHEMA.PARTITIONS

WHERE PARTITION_NAME IS NOT NULL

ORDER BY
    TABLE_SCHEMA,
    TABLE_NAME,
    PARTITION_ORDINAL_POSITION;


