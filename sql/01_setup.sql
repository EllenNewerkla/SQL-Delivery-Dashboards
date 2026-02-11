CREATE TABLE customers (
  customer_id INT,
  customer_name VARCHAR(50),
  city VARCHAR(30),
  signup_date DATE
);

INSERT INTO customers VALUES
(1, 'Ana', 'São Paulo', '2023-01-10'),
(2, 'Bruno', 'Rio de Janeiro', '2023-01-15'),
(3, 'Carla', 'São Paulo', '2023-02-01'),
(4, 'Diego', 'Belo Horizonte', '2023-02-10'),
(5, 'Eduarda', 'Curitiba', '2023-02-15'),
(6, 'Felipe', 'São Paulo', '2023-03-01'),
(7, 'Gabriela', 'Rio de Janeiro', '2023-03-05'),
(8, 'Henrique', 'Curitiba', '2023-03-10'),
(9, 'Helen', 'São Paulo', '2024-02-14'),
(10, 'Igor', 'Rio de Janeiro', '2024-05-24'),
(11, 'Breno', 'Fortaleza', '2024-08-01'),
(12, 'João', 'São Paulo', '2024-09-12'),
(13, 'Marina', 'Campinas', '2024-09-18'),
(14, 'Rafael', 'Belo Horizonte', '2024-10-01'),
(15, 'Larissa', 'Curitiba', '2024-10-05'),
(16, 'Pedro', 'Rio de Janeiro', '2024-10-20'),
(17, 'Beatriz', 'São Paulo', '2024-11-02'),
(18, 'Lucas', 'Fortaleza', '2024-11-15'),
(19, 'Camila', 'Recife', '2024-12-01'),
(20, 'Thiago', 'Porto Alegre', '2024-12-10'),
(21, 'Renata', 'São Paulo', '2025-01-05'),
(22, 'Caio', 'Rio de Janeiro', '2025-01-07'),
(23, 'Juliana', 'Campinas', '2025-01-10'),
(24, 'Marcos', 'Belo Horizonte', '2025-01-12'),
(25, 'Patricia', 'Curitiba', '2025-01-15'),
(26, 'Daniel', 'São Paulo', '2025-01-18'),
(27, 'Fernanda', 'Recife', '2025-01-20'),
(28, 'Rodrigo', 'Porto Alegre', '2025-01-22'),
(29, 'Aline', 'Fortaleza', '2025-01-25'),
(30, 'Victor', 'São Paulo', '2025-01-28'),
(31, 'Isabela', 'Rio de Janeiro', '2025-02-02'),
(32, 'Gustavo', 'Campinas', '2025-02-04'),
(33, 'Natalia', 'Curitiba', '2025-02-06'),
(34, 'Paulo', 'São Paulo', '2025-02-08'),
(35, 'Amanda', 'Belo Horizonte', '2025-02-10'),
(36, 'Leonardo', 'Recife', '2025-02-12'),
(37, 'Vanessa', 'São Paulo', '2025-02-15'),
(38, 'Ricardo', 'Porto Alegre', '2025-02-18'),
(39, 'Bianca', 'Rio de Janeiro', '2025-02-20'),
(40, 'André', 'Campinas', '2025-02-22'),
(41, 'Sofia', 'São Paulo', '2025-03-01'),
(42, 'Mateus', 'Curitiba', '2025-03-03'),
(43, 'Clara', 'Belo Horizonte', '2025-03-05'),
(44, 'Henrique', 'Recife', '2025-03-07'),
(45, 'Luana', 'Fortaleza', '2025-03-10'),
(46, 'Bruno', 'São Paulo', '2025-03-12'),
(47, 'Carolina', 'Rio de Janeiro', '2025-03-15'),
(48, 'Diego', 'Porto Alegre', '2025-03-18'),
(49, 'Tatiane', 'Campinas', '2025-03-20'),
(50, 'Eduardo', 'São Paulo', '2025-03-22');


DROP TABLE IF EXISTS orders;

CREATE TABLE orders AS
SELECT
  ROW_NUMBER() OVER (ORDER BY rand()) AS order_id,
  customer_id,
  date_add('2024-01-01', CAST(rand() * 450 AS INT)) AS order_date,
  ROUND(30 + rand() * 200, 2) AS order_value,
  CASE
    WHEN rand() < 0.18 THEN 'canceled'
    ELSE 'delivered'
  END AS status
FROM (
  SELECT customer_id
  FROM customers
  LATERAL VIEW explode(
    CASE
      WHEN customer_id <= 10 THEN array_repeat(1, 12)   -- heavy users
      WHEN customer_id <= 30 THEN array_repeat(1, 4)    -- médio uso
      WHEN customer_id <= 50 THEN array_repeat(1, 2)    -- baixo uso
      ELSE array_repeat(1, 0)                            -- sem pedidos
    END
  ) tmp AS x
)
LIMIT 160;

select * from orders
