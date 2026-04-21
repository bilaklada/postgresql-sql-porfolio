-- =========================================================
-- Project: Customer Lifetime Value
-- Goal: Build a customer-level value and recency summary.
-- Dataset: dvdrental
-- Grain: one row per customer.
-- =========================================================

WITH customer_revenue AS (
    SELECT
        p.customer_id,
        COUNT(*) AS payment_count,
        SUM(p.amount) AS lifetime_revenue,
        AVG(p.amount) AS avg_payment_amount,
        MAX(p.payment_date) AS last_payment_at
    FROM payment AS p
    GROUP BY p.customer_id
),
customer_rentals AS (
    SELECT
        r.customer_id,
        COUNT(*) AS rental_count,
        MIN(r.rental_date)::date AS first_rental_date,
        MAX(r.rental_date)::date AS last_rental_date
    FROM rental AS r
    GROUP BY r.customer_id
),
dataset_bounds AS (
    SELECT MAX(rental_date)::date AS max_rental_date
    FROM rental
),
customer_lifetime_value AS (
    SELECT
        c.customer_id,
        c.store_id,
        c.first_name,
        c.last_name,
        c.email,
        COALESCE(cr.lifetime_revenue, 0) AS lifetime_revenue,
        COALESCE(cr.payment_count, 0) AS payment_count,
        ROUND(COALESCE(cr.avg_payment_amount, 0), 2) AS avg_payment_amount,
        COALESCE(rt.rental_count, 0) AS rental_count,
        rt.first_rental_date,
        rt.last_rental_date,
        db.max_rental_date - rt.last_rental_date AS days_since_last_rental
    FROM customer AS c
    LEFT JOIN customer_revenue AS cr
        ON cr.customer_id = c.customer_id
    LEFT JOIN customer_rentals AS rt
        ON rt.customer_id = c.customer_id
    CROSS JOIN dataset_bounds AS db
)
SELECT
    customer_id,
    store_id,
    first_name,
    last_name,
    email,
    lifetime_revenue,
    payment_count,
    avg_payment_amount,
    rental_count,
    first_rental_date,
    last_rental_date,
    days_since_last_rental,
    CASE
        WHEN lifetime_revenue >= 200 THEN 'high_value'
        WHEN lifetime_revenue >= 100 THEN 'mid_value'
        ELSE 'low_value'
    END AS value_segment,
    CASE
        WHEN days_since_last_rental <= 30 THEN 'recent'
        WHEN days_since_last_rental <= 90 THEN 'cooling'
        WHEN days_since_last_rental IS NULL THEN 'no_rentals'
        ELSE 'inactive_or_old'
    END AS recency_segment
FROM customer_lifetime_value
ORDER BY
    lifetime_revenue DESC,
    rental_count DESC,
    customer_id;
