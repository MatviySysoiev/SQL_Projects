SELECT *
FROM customers;

SELECT *
FROM orders;

SELECT 
    c.id,
    c.first_name, 
    COALESCE(o.order_id, NULL) AS order_id, 
    COALESCE(o.order_date, NULL) AS order_date, 
    COALESCE(o.sales, NULL) AS sales
FROM customers c
LEFT JOIN orders o
    ON c.id = o.customer_id;



SELECT 
    o.customer_id,
    c.first_name,
    o.order_id,
    o.order_date,
    o.sales
FROM orders o
LEFT JOIN customers c
    ON o.customer_id = c.id
ORDER BY o.customer_id;


SELECT 
    COALESCE(c.id, o.customer_id, NULL) as id,
    c.first_name,
    o.order_id,
    o.order_date,
    o.sales
FROM orders o
FULL JOIN customers c
    ON o.customer_id = c.id
ORDER BY id;


-- Left, Right Anti Join

SELECT 
    o.customer_id,
    c.first_name,
    o.order_id,
    o.order_date,
    o.sales
FROM orders o
LEFT JOIN customers c
    ON o.customer_id = c.id
WHERE c.id IS NULL
ORDER BY o.customer_id;

SELECT * -- 1 the same thing as 2
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM ORDERS o
    WHERE c.id = o.customer_id
);

SELECT c.* -- 2 the same thing as 1
FROM CUSTOMERS c
LEFT JOIN orders o
    ON c.id = o.customer_id
WHERE o.customer_id IS NULL;

SELECT o.* -- the same as the bottom result
FROM CUSTOMERS c
RIGHT JOIN orders o
    ON c.id = o.customer_id
WHERE c.id IS NULL;


SELECT o.* -- the bottom result
FROM orders o
LEFT JOIN customers c
    ON c.id = o.customer_id
WHERE c.id IS NULL;

-- full anti join

SELECT *
FROM customers c
FULL JOIN orders o
    on c.id = o.customer_id
WHERE 
    c.id IS NULL 
    OR o.customer_id IS NULL;

-- Cross join
SELECT *
FROM customers
CROSS JOIN orders 
