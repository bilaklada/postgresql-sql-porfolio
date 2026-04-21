-- =========================================================
-- File: 02_running_totals.sql
-- Goal: Calculate running totals and cumulative shares.
-- Dataset: dvdrental
-- Grain: one row per month or customer.
-- Notes: Window frames make cumulative metrics explicit.
-- =========================================================

-- Monthly revenue with running total.
WITH monthly_revenue AS (
    SELECT
        DATE_TRUNC('month', p.payment_date)::date AS payment_month,
        SUM(p.amount) AS monthly_revenue
    FROM payment AS p
    GROUP BY DATE_TRUNC('month', p.payment_date)::date
)
SELECT
    payment_month,
    monthly_revenue,
    SUM(monthly_revenue) OVER (
        ORDER BY payment_month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_revenue
FROM monthly_revenue
ORDER BY payment_month;

-- Customers ordered by revenue contribution with cumulative revenue share.
WITH customer_revenue AS (
    SELECT
        p.customer_id,
        SUM(p.amount) AS total_revenue
    FROM payment AS p
    GROUP BY p.customer_id
)
SELECT
    customer_id,
    total_revenue,
    SUM(total_revenue) OVER (
        ORDER BY total_revenue DESC, customer_id
    ) AS cumulative_revenue,
    ROUND(
        SUM(total_revenue) OVER (ORDER BY total_revenue DESC, customer_id)
        / SUM(total_revenue) OVER (),
        4
    ) AS cumulative_revenue_share
FROM customer_revenue
ORDER BY
    total_revenue DESC,
    customer_id;
