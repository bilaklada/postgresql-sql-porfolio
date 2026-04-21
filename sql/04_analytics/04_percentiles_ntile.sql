-- =========================================================
-- File: 04_percentiles_ntile.sql
-- Goal: Segment distributions with NTILE and percentile functions.
-- Dataset: dvdrental
-- Grain: one row per customer or distribution summary.
-- Notes: Percentiles help describe skew without relying only on averages.
-- =========================================================

-- Quartile customers by total revenue.
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
    NTILE(4) OVER (ORDER BY total_revenue DESC, customer_id) AS revenue_quartile
FROM customer_revenue
ORDER BY
    revenue_quartile,
    total_revenue DESC;

-- Distribution of film lengths.
SELECT
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY length) AS p25_length,
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY length) AS median_length,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY length) AS p75_length,
    MIN(length) AS min_length,
    MAX(length) AS max_length
FROM film;

-- Rental duration percentile summary for returned rentals.
WITH rental_durations AS (
    SELECT
        EXTRACT(EPOCH FROM (return_date - rental_date)) / 86400.0 AS rental_days
    FROM rental
    WHERE return_date IS NOT NULL
)
SELECT
    PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY rental_days) AS median_rental_days,
    PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY rental_days) AS p90_rental_days,
    MAX(rental_days) AS max_rental_days
FROM rental_durations;
