-- 01_foundations.sql
-- Foundational SELECT / WHERE / DISTINCT / ORDER BY / LIMIT / AS / IN / BETWEEN / NOT BETWEEN / IS NULL

-- 1. SELECT + WHERE: orders from Mumbai
SELECT * FROM orders
WHERE customer_id IN (SELECT customer_id FROM customers WHERE city = 'Mumbai');

-- 2. DISTINCT: every distinct category
SELECT DISTINCT category
FROM products
ORDER BY category;

-- 3. ORDER BY + LIMIT: five highest-value orders
SELECT order_id, amount_inr
FROM orders
ORDER BY amount_inr DESC
LIMIT 5;

-- 4. Alias (AS): aggregate with a readable output name
SELECT COUNT(*) AS total_orders
FROM orders;

-- 5. IN: orders using UPI or Credit Card
SELECT *
FROM orders
WHERE payment_mode IN ('UPI', 'Credit Card');

-- 6. BETWEEN: orders with amount from INR 100 to INR 500 inclusive
SELECT *
FROM orders
WHERE amount_inr BETWEEN 100 AND 500;

-- 7. NOT BETWEEN: orders outside INR 100 to INR 500
SELECT *
FROM orders
WHERE amount_inr NOT BETWEEN 100 AND 500;

-- 8. IS NULL: orders with no rating recorded
SELECT *
FROM orders
WHERE rating IS NULL;
