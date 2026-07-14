use MyDatabase;

SELECT TOP 3 *
FROM customers
ORDER BY score DESC;

WITH cte_table AS (
	SELECT *,
	DENSE_RANK() OVER(PARTITION BY country ORDER BY score DESC) AS ranking
	FROM customers
)
SELECT id, first_name, country, score, ranking
FROM cte_table
WHERE ranking <= 1;

-- DATA DEFINITION LANGUAGE (DDL)

CREATE TABLE people (
	id INT NOT NULL,
	person_name VARCHAR(50) NOT NULL,
	birth_date DATE,
	phone VARCHAR(15) NOT NULL,
	CONSTRAINT pk_people PRIMARY KEY (id)
);

SELECT * FROM people;

ALTER TABLE people
ADD email VARCHAR(50) NOT NULL;

ALTER TABLE people
DROP COLUMN emaiL;

DROP TABLE people;

-- DATA MANILULATION LANGUAGE (DML)

INSERT INTO customers (id, first_name, country, score)
VALUES 
	(6, 'Anna', 'Ukraine', NULL),
	(7, 'Sam', NULL, 12);

INSERT INTO customers(id, first_name)
VALUES
	(8, 'Sarah');

-- Insert using select

INSERT INTO people (id, person_name, birth_date, phone)
SELECT id,
first_name, 
NULL,
'Unknown'
FROM CUSTOMERS;

SELECT *
FROM people;

-- UPDATE

SELECT *
FROM customers;

UPDATE customers
SET score = 0
WHERE id = 6;

SELECT *
FROM customers;

UPDATE customers
SET country = 'UK', score = 0
WHERE id = 3;

UPDATE customers
SET score = 0
WHERE score IS NULL;
 
 -- DELETE

 DELETE FROM customers
 WHERE id > 5;

 -- TRUNCATE IS FASTER

 TRUNCATE TABLE people