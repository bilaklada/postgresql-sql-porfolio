-- =========================================================
-- File: 07_dates_and_time.sql
-- Goal: Work with dates, timestamps, intervals, and date buckets.
-- Dataset: dvdrental
-- Grain: one row per month, rental, or customer.
-- Notes: Date truncation is important for cohort and trend work.
-- =========================================================

-- Monthly rental volume.
SELECT
    DATE_TRUNC('month', r.rental_date)::date AS rental_month,
    COUNT(*) AS rental_count
FROM rental AS r
GROUP BY DATE_TRUNC('month', r.rental_date)::date
ORDER BY rental_month;

-- Rental duration in days for returned rentals.
SELECT
    r.rental_id,
    r.customer_id,
    r.rental_date,
    r.return_date,
    EXTRACT(EPOCH FROM (r.return_date - r.rental_date)) / 86400.0 AS rental_days
FROM rental AS r
WHERE r.return_date IS NOT NULL
ORDER BY rental_days DESC
LIMIT 25;

-- Customer recency from the last rental date in the dataset.
WITH dataset_bounds AS (
    SELECT MAX(rental_date)::date AS max_rental_date
    FROM rental
)
SELECT
    r.customer_id,
    MAX(r.rental_date)::date AS last_rental_date,
    b.max_rental_date - MAX(r.rental_date)::date AS days_since_last_rental
FROM rental AS r
CROSS JOIN dataset_bounds AS b
GROUP BY
    r.customer_id,
    b.max_rental_date
ORDER BY days_since_last_rental DESC;
