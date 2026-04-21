-- =========================================================
-- File: 04_data_quality_baseline.sql
-- Goal: Establish baseline row counts and quality checks.
-- Dataset: dvdrental
-- Grain: one row per check.
-- Notes: I run checks like these before trusting project outputs.
-- =========================================================

-- Row counts for core analytical tables.
SELECT 'customer' AS table_name, COUNT(*) AS row_count FROM customer
UNION ALL
SELECT 'film' AS table_name, COUNT(*) AS row_count FROM film
UNION ALL
SELECT 'inventory' AS table_name, COUNT(*) AS row_count FROM inventory
UNION ALL
SELECT 'rental' AS table_name, COUNT(*) AS row_count FROM rental
UNION ALL
SELECT 'payment' AS table_name, COUNT(*) AS row_count FROM payment
ORDER BY table_name;

-- Key null checks for fact-like tables.
SELECT
    'rental' AS table_name,
    COUNT(*) FILTER (WHERE rental_id IS NULL) AS null_primary_key,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS null_customer_id,
    COUNT(*) FILTER (WHERE inventory_id IS NULL) AS null_inventory_id,
    COUNT(*) FILTER (WHERE rental_date IS NULL) AS null_event_date
FROM rental
UNION ALL
SELECT
    'payment' AS table_name,
    COUNT(*) FILTER (WHERE payment_id IS NULL) AS null_primary_key,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS null_customer_id,
    COUNT(*) FILTER (WHERE rental_id IS NULL) AS null_inventory_id,
    COUNT(*) FILTER (WHERE payment_date IS NULL) AS null_event_date
FROM payment;

-- Date sanity checks for rentals.
SELECT
    COUNT(*) AS rental_rows,
    COUNT(*) FILTER (WHERE return_date IS NULL) AS open_rentals,
    COUNT(*) FILTER (WHERE return_date < rental_date) AS return_before_rental,
    MIN(rental_date) AS first_rental_at,
    MAX(rental_date) AS last_rental_at
FROM rental;
