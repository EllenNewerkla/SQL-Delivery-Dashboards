# SQL Delivery Case (Databricks)

Projeto com **SQL, usando a plataforma Databricks** simulando uma app de delivery de comida.
O objetivo é calcular métricas de negócio (GMV, ticket médio, cancelamento) e apresentar os principais resultados em um dashboard.

## Dataset
- Dados **sintéticos** gerados via SQL para simular comportamentos reais:
  - clientes heavy users
  - clientes ocasionais
  - clientes com alto cancelamento
  - distribuição desigual por cidade

## Modelagem
- `customers` (customer_id, customer_name, city, signup_date)
- `orders` (order_id, customer_id, order_date, order_value, status)

## KPIs e análises
- Ganhos (GMV) por cidade (Top 5)
- Ticket médio por cliente
- Taxa de cancelamento por cliente (Top 5, mínimo de pedidos)
- Total de pedidos vs cancelamentos por cliente

## Dashboard
<img width="1481" height="614" alt="Captura de tela 2026-02-10 175244" src="https://github.com/user-attachments/assets/1a911b2d-7df2-4738-bd5f-4c3cea9d3682" />


## Como reproduzir
1. Rode o setup e geração de dados:
   - `sql/01_setup.sql`
2. Rode as queries para KPIs / dashboard:
   - `sql/02_kpis_views.sql`
3. Consulte as queries dos exercícios:
   - `sql/03_exercises.sql`

## Tecnologias
- Databricks (Spark SQL)
- Git/GitHub
