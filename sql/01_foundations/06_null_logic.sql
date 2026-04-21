-- =========================================================
-- File: 06_null_logic.sql
-- Goal: Handle NULL values explicitly.
-- Dataset: dvdrental
-- Grain: one row per record or summary.
-- Notes: NULL means unknown or missing, not zero.
-- =========================================================

-- Open rentals have no return date yet.
SELECT
    r.rental_id,
    r.customer_id,
    r.rental_date,
    r.return_date,
    CASE
        WHEN r.return_date IS NULL THEN 'open'
        ELSE 'returned'
    END AS rental_status
FROM rental AS r
WHERE r.return_date IS NULL
ORDER BY r.rental_date;

-- Use COALESCE after a left join to make zero-rental films visible.
SELECT
    f.film_id,
    f.title,
    COALESCE(rental_counts.rental_count, 0) AS rental_count
FROM film AS f
LEFT JOIN (
    SELECT
        i.film_id,
        COUNT(r.rental_id) AS rental_count
    FROM inventory AS i
    LEFT JOIN rental AS r
        ON r.inventory_id = i.inventory_id
    GROUP BY i.film_id
) AS rental_counts
    ON rental_counts.film_id = f.film_id
ORDER BY
    rental_count,
    f.title
LIMIT 30;

-- Null baseline for commonly used columns.
SELECT
    COUNT(*) FILTER (WHERE email IS NULL) AS customers_without_email,
    COUNT(*) FILTER (WHERE create_date IS NULL) AS customers_without_create_date,
    COUNT(*) AS customer_count
FROM customer;
