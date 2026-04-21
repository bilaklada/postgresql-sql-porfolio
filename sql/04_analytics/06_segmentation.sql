-- =========================================================
-- File: 06_segmentation.sql
-- Goal: Segment customers and films using business rules.
-- Dataset: dvdrental
-- Grain: one row per customer or film.
-- Notes: Segments should be defined clearly and validated.
-- =========================================================

-- Customer value and recency segmentation.
WITH customer_revenue AS (
    SELECT
        p.customer_id,
        SUM(p.amount) AS total_revenue
    FROM payment AS p
    GROUP BY p.customer_id
),
customer_rentals AS (
    SELECT
        r.customer_id,
        COUNT(*) AS rental_count,
        MAX(r.rental_date)::date AS last_rental_date
    FROM rental AS r
    GROUP BY r.customer_id
),
dataset_bounds AS (
    SELECT MAX(rental_date)::date AS max_rental_date
    FROM rental
)
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COALESCE(cr.total_revenue, 0) AS total_revenue,
    COALESCE(rt.rental_count, 0) AS rental_count,
    db.max_rental_date - rt.last_rental_date AS days_since_last_rental,
    CASE
        WHEN COALESCE(cr.total_revenue, 0) >= 200 THEN 'high_value'
        WHEN COALESCE(cr.total_revenue, 0) >= 100 THEN 'mid_value'
        ELSE 'low_value'
    END AS value_segment,
    CASE
        WHEN db.max_rental_date - rt.last_rental_date <= 30 THEN 'recent'
        WHEN db.max_rental_date - rt.last_rental_date <= 90 THEN 'cooling'
        WHEN rt.last_rental_date IS NULL THEN 'no_rentals'
        ELSE 'inactive_or_old'
    END AS recency_segment
FROM customer AS c
LEFT JOIN customer_revenue AS cr
    ON cr.customer_id = c.customer_id
LEFT JOIN customer_rentals AS rt
    ON rt.customer_id = c.customer_id
CROSS JOIN dataset_bounds AS db
ORDER BY
    total_revenue DESC,
    c.customer_id;

-- Validate customer segment counts.
WITH customer_revenue AS (
    SELECT
        customer_id,
        SUM(amount) AS total_revenue
    FROM payment
    GROUP BY customer_id
)
SELECT
    CASE
        WHEN total_revenue >= 200 THEN 'high_value'
        WHEN total_revenue >= 100 THEN 'mid_value'
        ELSE 'low_value'
    END AS value_segment,
    COUNT(*) AS customer_count
FROM customer_revenue
GROUP BY value_segment
ORDER BY value_segment;
