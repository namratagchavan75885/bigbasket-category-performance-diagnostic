-- 02_aggregation_joins.sql

-- (a) INNER JOIN + GROUP BY + HAVING for Delivered revenue by category
SELECT
    p.category,
    COUNT(o.order_id) AS delivered_orders,
    SUM(o.amount_inr) AS total_revenue,
    AVG(o.amount_inr) AS avg_revenue
FROM orders o
INNER JOIN products p ON o.product_id = p.product_id
WHERE o.status = 'Delivered'
GROUP BY p.category
HAVING total_revenue > 10000
ORDER BY total_revenue DESC;

-- (b) LEFT JOIN: preserve products with zero orders
SELECT
    p.product_name,
    COUNT(o.order_id) AS total_orders
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_orders ASC, p.product_name;
