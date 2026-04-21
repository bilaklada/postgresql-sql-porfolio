-- =========================================================
-- File: 08_basic_aggregations.sql
-- Goal: Practice COUNT, SUM, AVG, MIN, MAX, and FILTER.
-- Dataset: dvdrental
-- Grain: one row per summary or group.
-- Notes: Aggregates should match the fact table grain.
-- =========================================================

-- Revenue summary from payment facts.
SELECT
    COUNT(*) AS payment_count,
    COUNT(DISTINCT customer_id) AS paying_customer_count,
    SUM(amount) AS total_revenue,
    ROUND(AVG(amount), 2) AS avg_payment_amount,
    MIN(amount) AS min_payment_amount,
    MAX(amount) AS max_payment_amount
FROM payment;

-- Rental completion summary.
SELECT
    COUNT(*) AS rental_count,
    COUNT(*) FILTER (WHERE return_date IS NOT NULL) AS returned_rental_count,
    COUNT(*) FILTER (WHERE return_date IS NULL) AS open_rental_count,
    ROUND(
        COUNT(*) FILTER (WHERE return_date IS NOT NULL)::numeric / NULLIF(COUNT(*), 0),
        4
    ) AS returned_rental_ratio
FROM rental;

-- Category-level film count and replacement-cost exposure.
SELECT
    c.category_id,
    c.name AS category_name,
    COUNT(DISTINCT f.film_id) AS film_count,
    SUM(f.replacement_cost) AS total_replacement_cost
FROM category AS c
INNER JOIN film_category AS fc
    ON fc.category_id = c.category_id
INNER JOIN film AS f
    ON f.film_id = fc.film_id
GROUP BY
    c.category_id,
    c.name
ORDER BY total_replacement_cost DESC;
