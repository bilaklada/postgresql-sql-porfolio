-- =========================================================
-- File: 01_views.sql
-- Goal: Create reusable views for common analytical joins.
-- Dataset: dvdrental
-- Grain: documented per view.
-- Notes: Views keep repeated join logic consistent.
-- =========================================================

CREATE SCHEMA IF NOT EXISTS portfolio;

-- Grain: one row per rental, enriched with customer, film, store, and payment.
CREATE OR REPLACE VIEW portfolio.vw_rental_detail AS
SELECT
    r.rental_id,
    r.rental_date,
    r.return_date,
    c.customer_id,
    c.first_name AS customer_first_name,
    c.last_name AS customer_last_name,
    i.inventory_id,
    i.store_id,
    f.film_id,
    f.title AS film_title,
    f.rating,
    f.rental_duration,
    p.payment_id,
    p.amount AS payment_amount,
    p.payment_date
FROM rental AS r
INNER JOIN customer AS c
    ON c.customer_id = r.customer_id
INNER JOIN inventory AS i
    ON i.inventory_id = r.inventory_id
INNER JOIN film AS f
    ON f.film_id = i.film_id
LEFT JOIN payment AS p
    ON p.rental_id = r.rental_id;

-- Example usage.
SELECT
    store_id,
    COUNT(*) AS rental_count,
    SUM(payment_amount) AS revenue
FROM portfolio.vw_rental_detail
GROUP BY store_id
ORDER BY store_id;

-- Validation: the view should not duplicate rentals before considering payments.
SELECT
    COUNT(DISTINCT rental_id) AS distinct_rentals,
    COUNT(*) AS view_rows
FROM portfolio.vw_rental_detail;
