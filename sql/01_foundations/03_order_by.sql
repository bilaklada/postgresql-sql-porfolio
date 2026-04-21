-- =========================================================
-- File: 03_order_by.sql
-- Goal: Sort output deliberately and make tie-breakers visible.
-- Dataset: dvdrental
-- Grain: one row per source record.
-- Notes: Stable ordering makes review and sample outputs easier.
-- =========================================================

-- Most expensive films, with deterministic tie-breakers.
SELECT
    f.film_id,
    f.title,
    f.rental_rate,
    f.replacement_cost
FROM film AS f
ORDER BY
    f.rental_rate DESC,
    f.replacement_cost DESC,
    f.title ASC
LIMIT 25;

-- Recent payments ordered by timestamp and payment id.
SELECT
    p.payment_id,
    p.customer_id,
    p.amount,
    p.payment_date
FROM payment AS p
ORDER BY
    p.payment_date DESC,
    p.payment_id DESC
LIMIT 25;

-- Shortest films by rating, useful for checking grouped distribution later.
SELECT
    f.rating,
    f.title,
    f.length
FROM film AS f
ORDER BY
    f.rating,
    f.length,
    f.title
LIMIT 30;
