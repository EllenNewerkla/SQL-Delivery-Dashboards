-- 1. Liste todos os clientes da cidade de São Paulo.
SELECT customer_id, customer_name, city 
FROM customers
WHERE city = 'São Paulo';

SELECT * FROM customers;
-- 2.Liste todos os pedidos entregues (status = 'delivered').
SELECT order_id, status, order_value
FROM orders
WHERE status = 'delivered';

-- 3.Mostre os pedidos com valor maior que 60.
SELECT order_id, order_value
FROM orders
WHERE order_value > 60
ORDER BY order_value DESC;

-- 4. Ordene os pedidos do mais caro para o mais barato.
SELECT order_id, order_value
FROM orders
ORDER BY order_value DESC;

-- NIVEL 2
-- 5. Quantos pedidos cada cliente fez?
SELECT customer_name, COUNT(order_id) as total_orders
FROM customers
LEFT JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY customer_name
ORDER BY total_orders DESC;

-- 6. Qual o valor total gasto por cliente (somente pedidos entregues)?
SELECT customer_name, SUM(order_value) AS total_orders_price
FROM customers
JOIN orders
ON customers.customer_id = orders.customer_id
WHERE status = 'delivered'
GROUP BY customer_name
ORDER BY total_orders_price DESC;

-- 7. Mostre apenas clientes que fizeram mais de 1 pedido.
SELECT c.customer_id, c.customer_name, COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name 
HAVING total_orders > 1
ORDER BY total_orders DESC;

-- 8. Qual o ticket médio (AVG) por cliente?
SELECT customer_name, AVG(order_value)
FROM customers
JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY customer_name
ORDER BY AVG(order_value) DESC;

-- NIVEL 3
-- 09. Liste: nome do cliente, cidade, valor do pedido e status
SELECT customer_name, city, order_value, status
FROM customers
JOIN orders
ON customers.customer_id = orders.customer_id;

-- 10. Qual o total gasto por cidade (somente pedidos entregues)?
SELECT city, SUM(order_value) AS total_orders_price
FROM customers
JOIN orders
ON customers.customer_id = orders.customer_id
WHERE status = 'delivered'
GROUP BY city
ORDER BY total_orders_price DESC;

-- 11. Liste clientes que nunca fizeram pedido.
SELECT customer_name, order_id
FROM customers
LEFT JOIN orders
ON customers.customer_id = orders.customer_id
WHERE order_id IS NULL;

-- 12. Para cada cliente, mostre: total de pedidos e total de pedidos cancelados
SELECT customer_name, COUNT(order_id) AS total_pedidos,
COUNT(CASE WHEN status = 'canceled' THEN 1 END) AS total_pedidos_cancelados
FROM customers
LEFT JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY customer_name
ORDER BY total_pedidos DESC;

-- Taxa de cancelamento (%) por cliente
SELECT c.customer_name, ROUND(100.0 * SUM(CASE WHEN status = 'canceled' THEN 1 ELSE 0 END) / NULLIF(COUNT(order_id), 0), 2) AS cancel_rate_pct, COUNT(order_id) AS total_orders
FROM customers c
LEFT JOIN orders o
  ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY cancel_rate_pct DESC;

-- Quais clientes gastaram acima da média geral da plataforma?
SELECT customer_name, AVG(order_value) AS avg_order_value
FROM orders
JOIN customers
ON orders.customer_id = customers.customer_id
GROUP BY customer_name
HAVING avg_order_value > (SELECT AVG(order_value) FROM orders)
ORDER BY avg_order_value DESC;
