-- =========================================================
-- File: 01_select.sql
-- Goal: Practice explicit column selection and readable output.
-- Dataset: dvdrental
-- Grain: one row per source record.
-- Notes: I avoid SELECT * in portfolio queries except during quick exploration.
-- =========================================================

-- Film catalog preview with explicit business columns.
SELECT
    f.film_id,
    f.title,
    f.release_year,
    f.rental_duration,
    f.rental_rate,
    f.length,
    f.rating
FROM film AS f
ORDER BY f.film_id
LIMIT 20;

-- Customer profile fields used in later project queries.
SELECT
    c.customer_id,
    c.store_id,
    c.first_name,
    c.last_name,
    c.email,
    c.activebool,
    c.create_date
FROM customer AS c
ORDER BY c.customer_id
LIMIT 20;

-- Payment facts with date and amount.
SELECT
    p.payment_id,
    p.customer_id,
    p.staff_id,
    p.rental_id,
    p.amount,
    p.payment_date
FROM payment AS p
ORDER BY p.payment_date DESC
LIMIT 20;
