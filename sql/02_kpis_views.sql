-- AVG de cada Cliente
SELECT customer_name, AVG(order_value)
FROM customers
JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY customer_name
ORDER BY AVG(order_value) DESC;

-- Total Ganho por Cidade
SELECT city, SUM(order_value) AS total_orders_price
FROM customers
JOIN orders
ON customers.customer_id = orders.customer_id
WHERE status = 'delivered'
GROUP BY city
ORDER BY total_orders_price DESC
LIMIT 5;

-- Total de Pedidos e Cancelamentos por Cliente
SELECT customer_name, COUNT(order_id) AS total_pedidos,
COUNT(CASE WHEN status = 'canceled' THEN 1 END) AS total_pedidos_cancelados
FROM customers
LEFT JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY customer_name
ORDER BY total_pedidos DESC
LIMIT 15;

-- SELECT customer_name, ROUND(100.0 * SUM(CASE WHEN status = 'canceled' THEN 1 ELSE 0 END)/ NULLIF(COUNT(order_id), 0), 2) AS cancel_rate_pct
FROM customers 
LEFT JOIN orders 
  ON customers.customer_id = orders.customer_id
GROUP BY customer_name
HAVING COUNT(order_id) >= 3
ORDER BY cancel_rate_pct DESC
LIMIT 7;