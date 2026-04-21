-- =========================================================
-- File: 05_explain_analyze.sql
-- Goal: Read query plans for common analytical patterns.
-- Dataset: dvdrental
-- Grain: explain-plan output.
-- Notes: EXPLAIN ANALYZE executes the query.
-- =========================================================

-- Aggregation plan: customer revenue.
EXPLAIN ANALYZE
SELECT
    p.customer_id,
    SUM(p.amount) AS total_revenue
FROM payment AS p
GROUP BY p.customer_id
ORDER BY total_revenue DESC
LIMIT 20;

-- Join plan: rental to inventory to film.
EXPLAIN ANALYZE
SELECT
    f.film_id,
    f.title,
    COUNT(r.rental_id) AS rental_count
FROM film AS f
INNER JOIN inventory AS i
    ON i.film_id = f.film_id
INNER JOIN rental AS r
    ON r.inventory_id = i.inventory_id
GROUP BY
    f.film_id,
    f.title
ORDER BY rental_count DESC
LIMIT 20;

-- Selective lookup plan.
EXPLAIN ANALYZE
SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM customer AS c
WHERE c.email = 'MARY.SMITH@sakilacustomer.org';
