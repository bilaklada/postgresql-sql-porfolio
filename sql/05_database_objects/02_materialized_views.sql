-- =========================================================
-- File: 02_materialized_views.sql
-- Goal: Materialize a reusable customer revenue summary.
-- Dataset: dvdrental
-- Grain: one row per customer.
-- Notes: Materialized views trade freshness for faster repeated reads.
-- =========================================================

CREATE SCHEMA IF NOT EXISTS portfolio;

DROP MATERIALIZED VIEW IF EXISTS portfolio.mv_customer_revenue;

CREATE MATERIALIZED VIEW portfolio.mv_customer_revenue AS
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(p.payment_id) AS payment_count,
    COALESCE(SUM(p.amount), 0) AS total_revenue,
    MAX(p.payment_date) AS last_payment_at
FROM customer AS c
LEFT JOIN payment AS p
    ON p.customer_id = c.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name;

CREATE UNIQUE INDEX IF NOT EXISTS mv_customer_revenue_customer_id_idx
    ON portfolio.mv_customer_revenue (customer_id);

-- Query the materialized summary.
SELECT
    customer_id,
    first_name,
    last_name,
    payment_count,
    total_revenue
FROM portfolio.mv_customer_revenue
ORDER BY total_revenue DESC
LIMIT 25;

-- Refresh pattern.
REFRESH MATERIALIZED VIEW portfolio.mv_customer_revenue;
