-- =========================================================
-- File: 03_duplicate_detection.sql
-- Goal: Detect duplicate keys after transformations.
-- Dataset: dvdrental
-- Grain: one row per duplicate key.
-- Notes: Duplicate checks protect the intended output grain.
-- =========================================================

-- Primary-key duplicate check for payment.
SELECT
    payment_id,
    COUNT(*) AS row_count
FROM payment
GROUP BY payment_id
HAVING COUNT(*) > 1
ORDER BY payment_id;

-- Duplicate check after a safe payment-rental join.
WITH payment_rental AS (
    SELECT
        p.payment_id,
        r.rental_id
    FROM payment AS p
    INNER JOIN rental AS r
        ON r.rental_id = p.rental_id
)
SELECT
    payment_id,
    COUNT(*) AS row_count
FROM payment_rental
GROUP BY payment_id
HAVING COUNT(*) > 1
ORDER BY payment_id;

-- Show expected duplication when joining films to actors.
SELECT
    f.film_id,
    f.title,
    COUNT(*) AS film_actor_rows
FROM film AS f
INNER JOIN film_actor AS fa
    ON fa.film_id = f.film_id
GROUP BY
    f.film_id,
    f.title
HAVING COUNT(*) > 1
ORDER BY film_actor_rows DESC;
