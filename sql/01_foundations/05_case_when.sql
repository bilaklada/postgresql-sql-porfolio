-- =========================================================
-- File: 05_case_when.sql
-- Goal: Use CASE for readable analytical labels.
-- Dataset: dvdrental
-- Grain: one row per film or customer summary.
-- Notes: CASE labels must match documented business rules.
-- =========================================================

-- Classify films by length.
SELECT
    f.film_id,
    f.title,
    f.length,
    CASE
        WHEN f.length < 60 THEN 'short'
        WHEN f.length < 120 THEN 'medium'
        ELSE 'long'
    END AS length_band
FROM film AS f
ORDER BY
    f.length,
    f.title;

-- Classify customer spend after aggregation.
SELECT
    p.customer_id,
    SUM(p.amount) AS total_amount,
    CASE
        WHEN SUM(p.amount) >= 200 THEN 'high_value'
        WHEN SUM(p.amount) >= 100 THEN 'mid_value'
        ELSE 'low_value'
    END AS value_segment
FROM payment AS p
GROUP BY p.customer_id
ORDER BY total_amount DESC;

-- Validate that every film receives exactly one length band.
SELECT
    length_band,
    COUNT(*) AS film_count
FROM (
    SELECT
        CASE
            WHEN f.length < 60 THEN 'short'
            WHEN f.length < 120 THEN 'medium'
            ELSE 'long'
        END AS length_band
    FROM film AS f
) AS labeled_films
GROUP BY length_band
ORDER BY length_band;
