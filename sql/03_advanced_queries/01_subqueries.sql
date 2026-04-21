-- =========================================================
-- File: 01_subqueries.sql
-- Goal: Use subqueries for filtered and summarized analysis.
-- Dataset: dvdrental
-- Grain: one row per outer query entity.
-- Notes: Subqueries are useful when a comparison needs a derived value.
-- =========================================================

-- Films longer than the average film length.
SELECT
    f.film_id,
    f.title,
    f.length
FROM film AS f
WHERE f.length > (
    SELECT AVG(length)
    FROM film
)
ORDER BY
    f.length DESC,
    f.title;

-- Customers with above-average total spend.
SELECT
    customer_totals.customer_id,
    customer_totals.total_amount
FROM (
    SELECT
        p.customer_id,
        SUM(p.amount) AS total_amount
    FROM payment AS p
    GROUP BY p.customer_id
) AS customer_totals
WHERE customer_totals.total_amount > (
    SELECT AVG(total_amount)
    FROM (
        SELECT SUM(amount) AS total_amount
        FROM payment
        GROUP BY customer_id
    ) AS all_customer_totals
)
ORDER BY customer_totals.total_amount DESC;

-- Payments larger than the customer's own average payment.
SELECT
    p.payment_id,
    p.customer_id,
    p.amount,
    p.payment_date
FROM payment AS p
WHERE p.amount > (
    SELECT AVG(p2.amount)
    FROM payment AS p2
    WHERE p2.customer_id = p.customer_id
)
ORDER BY
    p.customer_id,
    p.amount DESC;
