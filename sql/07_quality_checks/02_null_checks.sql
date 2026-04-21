-- =========================================================
-- File: 02_null_checks.sql
-- Goal: Identify unexpected nulls in important analytical fields.
-- Dataset: dvdrental
-- Grain: one row per table check.
-- Notes: Some nulls are valid, but they should be known.
-- =========================================================

SELECT
    'customer' AS table_name,
    'email' AS column_name,
    COUNT(*) AS row_count,
    COUNT(*) FILTER (WHERE email IS NULL) AS null_count
FROM customer
UNION ALL
SELECT
    'customer' AS table_name,
    'store_id' AS column_name,
    COUNT(*) AS row_count,
    COUNT(*) FILTER (WHERE store_id IS NULL) AS null_count
FROM customer
UNION ALL
SELECT
    'rental' AS table_name,
    'return_date' AS column_name,
    COUNT(*) AS row_count,
    COUNT(*) FILTER (WHERE return_date IS NULL) AS null_count
FROM rental
UNION ALL
SELECT
    'rental' AS table_name,
    'inventory_id' AS column_name,
    COUNT(*) AS row_count,
    COUNT(*) FILTER (WHERE inventory_id IS NULL) AS null_count
FROM rental
UNION ALL
SELECT
    'payment' AS table_name,
    'rental_id' AS column_name,
    COUNT(*) AS row_count,
    COUNT(*) FILTER (WHERE rental_id IS NULL) AS null_count
FROM payment
UNION ALL
SELECT
    'payment' AS table_name,
    'staff_id' AS column_name,
    COUNT(*) AS row_count,
    COUNT(*) FILTER (WHERE staff_id IS NULL) AS null_count
FROM payment;

-- Films without inventory are important for demand analysis.
SELECT
    COUNT(*) AS films_without_inventory
FROM film AS f
LEFT JOIN inventory AS i
    ON i.film_id = f.film_id
WHERE i.inventory_id IS NULL;
