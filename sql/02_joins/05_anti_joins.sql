-- =========================================================
-- File: 05_anti_joins.sql
-- Goal: Find missing relationships with NOT EXISTS and LEFT JOIN.
-- Dataset: dvdrental
-- Grain: one row per missing entity.
-- Notes: Anti-joins are useful for data quality and operational checks.
-- =========================================================

-- Films that have no inventory copies.
SELECT
    f.film_id,
    f.title
FROM film AS f
WHERE NOT EXISTS (
    SELECT 1
    FROM inventory AS i
    WHERE i.film_id = f.film_id
)
ORDER BY f.title;

-- Inventory copies that have never been rented.
SELECT
    i.inventory_id,
    i.store_id,
    f.film_id,
    f.title
FROM inventory AS i
INNER JOIN film AS f
    ON f.film_id = i.film_id
WHERE NOT EXISTS (
    SELECT 1
    FROM rental AS r
    WHERE r.inventory_id = i.inventory_id
)
ORDER BY
    i.store_id,
    f.title,
    i.inventory_id;

-- Equivalent anti-join pattern using LEFT JOIN ... IS NULL.
SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM customer AS c
LEFT JOIN rental AS r
    ON r.customer_id = c.customer_id
WHERE r.rental_id IS NULL
ORDER BY c.customer_id;
