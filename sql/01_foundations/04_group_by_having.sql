-- =========================================================
-- File: 04_group_by_having.sql
-- Goal: Aggregate data and filter grouped results.
-- Dataset: dvdrental
-- Grain: one row per group.
-- Notes: HAVING filters after aggregation.
-- =========================================================

-- Film count and pricing summary by rating.
SELECT
    f.rating,
    COUNT(*) AS film_count,
    ROUND(AVG(f.length), 2) AS avg_length_minutes,
    MIN(f.rental_rate) AS min_rental_rate,
    MAX(f.rental_rate) AS max_rental_rate
FROM film AS f
GROUP BY f.rating
ORDER BY f.rating;

-- Customers with high total spend.
SELECT
    p.customer_id,
    COUNT(*) AS payment_count,
    SUM(p.amount) AS total_amount,
    ROUND(AVG(p.amount), 2) AS avg_payment_amount
FROM payment AS p
GROUP BY p.customer_id
HAVING SUM(p.amount) >= 180
ORDER BY total_amount DESC;

-- Store-level customer counts, keeping only stores with meaningful volume.
SELECT
    c.store_id,
    COUNT(*) AS customer_count,
    COUNT(*) FILTER (WHERE c.activebool) AS active_customer_count
FROM customer AS c
GROUP BY c.store_id
HAVING COUNT(*) >= 250
ORDER BY customer_count DESC;
