-- =========================================================
-- File: 03_lag_lead_period_comparison.sql
-- Goal: Compare current and previous periods with LAG and LEAD.
-- Dataset: dvdrental
-- Grain: one row per period or customer event.
-- Notes: LAG/LEAD are useful for time-aware analysis.
-- =========================================================

-- Month-over-month revenue comparison.
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
    LAG(monthly_revenue) OVER (ORDER BY payment_month) AS previous_month_revenue,
    monthly_revenue - LAG(monthly_revenue) OVER (ORDER BY payment_month) AS revenue_change
FROM monthly_revenue
ORDER BY payment_month;

-- Customer rental sequence with days between rentals.
SELECT
    r.customer_id,
    r.rental_id,
    r.rental_date,
    LAG(r.rental_date) OVER (
        PARTITION BY r.customer_id
        ORDER BY r.rental_date
    ) AS previous_rental_date,
    r.rental_date
        - LAG(r.rental_date) OVER (
            PARTITION BY r.customer_id
            ORDER BY r.rental_date
        ) AS time_since_previous_rental,
    LEAD(r.rental_date) OVER (
        PARTITION BY r.customer_id
        ORDER BY r.rental_date
    ) AS next_rental_date
FROM rental AS r
ORDER BY
    r.customer_id,
    r.rental_date;
