-- =========================================================
-- File: 01_row_count_checks.sql
-- Goal: Compare expected and actual row counts after joins or summaries.
-- Dataset: dvdrental
-- Grain: one row per check.
-- Notes: Row-count checks help catch accidental duplication or row loss.
-- =========================================================

-- Payment to rental join should keep one row per payment.
SELECT
    'payment_to_rental' AS check_name,
    (SELECT COUNT(*) FROM payment) AS expected_rows,
    COUNT(*) AS actual_rows,
    COUNT(*) - (SELECT COUNT(*) FROM payment) AS row_difference
FROM payment AS p
INNER JOIN rental AS r
    ON r.rental_id = p.rental_id;

-- Customer summary should return one row per customer.
WITH customer_summary AS (
    SELECT
        c.customer_id,
        COUNT(r.rental_id) AS rental_count
    FROM customer AS c
    LEFT JOIN rental AS r
        ON r.customer_id = c.customer_id
    GROUP BY c.customer_id
)
SELECT
    'customer_summary' AS check_name,
    (SELECT COUNT(*) FROM customer) AS expected_rows,
    COUNT(*) AS actual_rows,
    COUNT(*) - (SELECT COUNT(*) FROM customer) AS row_difference
FROM customer_summary;

-- Film-category bridge count should match source bridge rows after joining parents.
SELECT
    'film_category_bridge' AS check_name,
    (SELECT COUNT(*) FROM film_category) AS expected_rows,
    COUNT(*) AS actual_rows,
    COUNT(*) - (SELECT COUNT(*) FROM film_category) AS row_difference
FROM film_category AS fc
INNER JOIN film AS f
    ON f.film_id = fc.film_id
INNER JOIN category AS c
    ON c.category_id = fc.category_id;
