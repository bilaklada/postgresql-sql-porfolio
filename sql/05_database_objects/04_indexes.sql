-- =========================================================
-- File: 04_indexes.sql
-- Goal: Demonstrate indexing patterns for common query shapes.
-- Dataset: dvdrental
-- Grain: one row per explain output.
-- Notes: This demo rolls back index creation so source tables are unchanged.
-- =========================================================

BEGIN;

EXPLAIN
SELECT
    p.customer_id,
    p.payment_date,
    p.amount
FROM payment AS p
WHERE p.customer_id = 42
ORDER BY p.payment_date DESC;

CREATE INDEX payment_customer_date_demo_idx
    ON payment (customer_id, payment_date DESC);

EXPLAIN
SELECT
    p.customer_id,
    p.payment_date,
    p.amount
FROM payment AS p
WHERE p.customer_id = 42
ORDER BY p.payment_date DESC;

-- Expression index demo for case-insensitive film title lookup.
CREATE INDEX film_lower_title_demo_idx
    ON film (LOWER(title));

EXPLAIN
SELECT
    f.film_id,
    f.title
FROM film AS f
WHERE LOWER(f.title) = LOWER('Academy Dinosaur');

ROLLBACK;
