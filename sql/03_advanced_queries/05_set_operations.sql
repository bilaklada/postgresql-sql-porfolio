-- =========================================================
-- File: 05_set_operations.sql
-- Goal: Use UNION, INTERSECT, and EXCEPT for comparison logic.
-- Dataset: dvdrental
-- Grain: one row per entity identifier.
-- Notes: Set operations require compatible column lists and data types.
-- =========================================================

-- Customers who either paid more than 9 once or rented more than 35 times.
SELECT customer_id
FROM payment
WHERE amount > 9
UNION
SELECT customer_id
FROM rental
GROUP BY customer_id
HAVING COUNT(*) > 35
ORDER BY customer_id;

-- Customers who both paid more than 9 once and rented more than 35 times.
SELECT customer_id
FROM payment
WHERE amount > 9
INTERSECT
SELECT customer_id
FROM rental
GROUP BY customer_id
HAVING COUNT(*) > 35
ORDER BY customer_id;

-- Films with inventory copies except films that have ever been rented.
SELECT i.film_id
FROM inventory AS i
EXCEPT
SELECT i.film_id
FROM inventory AS i
INNER JOIN rental AS r
    ON r.inventory_id = i.inventory_id
ORDER BY film_id;

-- UNION ALL keeps duplicates and can be useful for labeled metric stacks.
SELECT
    'payment_rows' AS metric_name,
    COUNT(*) AS metric_value
FROM payment
UNION ALL
SELECT
    'rental_rows' AS metric_name,
    COUNT(*) AS metric_value
FROM rental;
