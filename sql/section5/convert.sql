-- Syntax: CONVERT(expression, data_type)
SELECT CONVERT('123.45', DECIMAL(5,2)); -- Returns the numeric value 123.45
SELECT CONVERT(42, CHAR);               -- Converts the integer 42 into the string '42'
SELECT CONVERT('-42.8', SIGNED); -- Returns -43
SELECT CONVERT('42.2', UNSIGNED); -- Returns 42
SELECT CONVERT('abc', BINARY);
SELECT CONVERT('2026-09-15 16:00:00', DATE); -- Returns '2026-09-15'

select convert('123', signed) as 'string into int';
select convert('-123', signed) as 'string into int';
select convert('123', unsigned) as 'string into int';
select creationtime, convert(creationtime, date) as 'date' from orders ;
select creationtime, convert(creationtime, time) as 'time' from orders ;
select creationtime, convert(creationtime, datetime) as 'datetime' from orders ;


-- Step 1: Set the session's time locale to Saudi Arabia / Arabic
SET lc_time_names = 'ar_SA';

-- Step 2: Use DATE_FORMAT with standard format specifiers
SELECT DATE_FORMAT('2026-09-15', '%W, %d %M %Y') AS 'arabic_date';
-- Returns: "الثلاثاء, 15 سبتمبر 2026"

-- return to default : 
SET lc_time_names = @@global.lc_time_names;
SELECT DATE_FORMAT('2026-09-15', '%W, %d %M %Y');
