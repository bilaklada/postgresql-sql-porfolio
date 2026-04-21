-- =========================================================
-- File: 06_segmentation.sql
-- Goal: Segment customers and films using business rules.
-- Dataset: dvdrental
-- Grain: one row per customer or film.
-- Notes: Segments should be defined clearly and validated.
-- =========================================================

-- Customer value and recency segmentation.
WITH customer_metrics AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(p.amount) AS total_revenue,
        COUNT(DISTINCT r.rental_id) AS rental_count,
        MAX(r.rental_date)::date AS last_rental_date
    FROM customer AS c
    LEFT JOIN payment AS p
        ON p.customer_id = c.customer_id
    LEFT JOIN rental AS r
        ON r.rental_id = p.rental_id
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name
),
dataset_bounds AS (
    SELECT MAX(rental_date)::date AS max_rental_date
    FROM rental
)
SELECT
    cm.customer_id,
    cm.first_name,
    cm.last_name,
    COALESCE(cm.total_revenue, 0) AS total_revenue,
    COALESCE(cm.rental_count, 0) AS rental_count,
    db.max_rental_date - cm.last_rental_date AS days_since_last_rental,
    CASE
        WHEN COALESCE(cm.total_revenue, 0) >= 200 THEN 'high_value'
        WHEN COALESCE(cm.total_revenue, 0) >= 100 THEN 'mid_value'
        ELSE 'low_value'
    END AS value_segment,
    CASE
        WHEN db.max_rental_date - cm.last_rental_date <= 30 THEN 'recent'
        WHEN db.max_rental_date - cm.last_rental_date <= 90 THEN 'cooling'
        ELSE 'inactive_or_old'
    END AS recency_segment
FROM customer_metrics AS cm
CROSS JOIN dataset_bounds AS db
ORDER BY
    total_revenue DESC,
    cm.customer_id;

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
