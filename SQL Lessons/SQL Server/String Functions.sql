SELECT
first_name,
country,
CONCAT(first_name, ' ', country) as name_country
FROM customers;

SELECT
first_name,
LOWER(first_name) as low_name,
UPPER(first_name) as up_name
FROM customers;

SELECT
first_name,
LEN(first_name) AS len_name,
LEN(TRIM(first_name)) AS len_trim_name,
LEN(first_name) - LEN(TRIM(first_name)) flag
FROM customers
WHERE first_name != TRIM(first_name);

UPDATE customers
SET first_name = TRIM(first_name)
WHERE id = 2;


SELECT 
'123-456-7890' AS phone_number,
REPLACE('123-456-7890', '-', '/') AS clean_phone,
REPLACE('123-456-7890', '-', '') AS clean_phone2;


SELECT
'report.txt' AS file_name,
REPLACE('report.txt', '.txt', '.csv') as new_filename;


SELECT
	first_name,
	TRIM(LEFT(first_name, 2)) first_2_char,
	TRIM(RIGHT(first_name, 2)) last_2_char
FROM customers;


SELECT
	first_name,
	SUBSTRING(TRIM(first_name), 2, LEN(first_name)) as sub_name
FROM customers;











