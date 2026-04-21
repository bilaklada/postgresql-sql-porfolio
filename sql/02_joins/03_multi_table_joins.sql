-- =========================================================
-- File: 03_multi_table_joins.sql
-- Goal: Join multiple related tables while preserving analytical grain.
-- Dataset: dvdrental
-- Grain: one row per rental or aggregated business entity.
-- Notes: Multi-table joins should follow the relationship path explicitly.
-- =========================================================

-- Grain: one row per rental with customer, film, store, and staff context.
SELECT
    r.rental_id,
    r.rental_date,
    c.customer_id,
    c.first_name AS customer_first_name,
    c.last_name AS customer_last_name,
    f.film_id,
    f.title,
    i.store_id,
    s.staff_id,
    s.first_name AS staff_first_name,
    s.last_name AS staff_last_name
FROM rental AS r
INNER JOIN customer AS c
    ON c.customer_id = r.customer_id
INNER JOIN inventory AS i
    ON i.inventory_id = r.inventory_id
INNER JOIN film AS f
    ON f.film_id = i.film_id
INNER JOIN staff AS s
    ON s.staff_id = r.staff_id
ORDER BY r.rental_date DESC
LIMIT 30;

-- Grain: one row per category and store.
SELECT
    i.store_id,
    cat.category_id,
    cat.name AS category_name,
    COUNT(r.rental_id) AS rental_count,
    SUM(p.amount) AS revenue
FROM rental AS r
INNER JOIN inventory AS i
    ON i.inventory_id = r.inventory_id
INNER JOIN film_category AS fc
    ON fc.film_id = i.film_id
INNER JOIN category AS cat
    ON cat.category_id = fc.category_id
LEFT JOIN payment AS p
    ON p.rental_id = r.rental_id
GROUP BY
    i.store_id,
    cat.category_id,
    cat.name
ORDER BY
    i.store_id,
    revenue DESC NULLS LAST;

-- Grain validation: rental_id should remain unique after joining to film.
SELECT
    COUNT(*) AS joined_rows,
    COUNT(DISTINCT r.rental_id) AS distinct_rentals,
    COUNT(*) - COUNT(DISTINCT r.rental_id) AS duplicate_rows
FROM rental AS r
INNER JOIN inventory AS i
    ON i.inventory_id = r.inventory_id
INNER JOIN film AS f
    ON f.film_id = i.film_id;
