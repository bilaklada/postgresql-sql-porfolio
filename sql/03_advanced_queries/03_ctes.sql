-- =========================================================
-- File: 03_ctes.sql
-- Goal: Structure multi-step SQL with common table expressions.
-- Dataset: dvdrental
-- Grain: one row per customer in the final output.
-- Notes: I use CTEs to make each calculation step reviewable.
-- =========================================================

WITH customer_revenue AS (
    SELECT
        p.customer_id,
        SUM(p.amount) AS total_revenue,
        COUNT(*) AS payment_count
    FROM payment AS p
    GROUP BY p.customer_id
),
customer_rentals AS (
    SELECT
        r.customer_id,
        COUNT(*) AS rental_count,
        MAX(r.rental_date) AS last_rental_at
    FROM rental AS r
    GROUP BY r.customer_id
),
final AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        COALESCE(cr.total_revenue, 0) AS total_revenue,
        COALESCE(cr.payment_count, 0) AS payment_count,
        COALESCE(rt.rental_count, 0) AS rental_count,
        rt.last_rental_at
    FROM customer AS c
    LEFT JOIN customer_revenue AS cr
        ON cr.customer_id = c.customer_id
    LEFT JOIN customer_rentals AS rt
        ON rt.customer_id = c.customer_id
)
SELECT
    customer_id,
    first_name,
    last_name,
    total_revenue,
    payment_count,
    rental_count,
    last_rental_at
FROM final
ORDER BY total_revenue DESC
LIMIT 50;

-- Validation: final CTE should keep one row per customer.
WITH final_customer_ids AS (
    SELECT c.customer_id
    FROM customer AS c
)
SELECT
    COUNT(*) AS rows_returned,
    COUNT(DISTINCT customer_id) AS distinct_customers
FROM final_customer_ids;
