-- =========================================================
-- File: 04_fk_consistency_checks.sql
-- Goal: Check parent-child consistency for important relationships.
-- Dataset: dvdrental
-- Grain: one row per consistency check.
-- Notes: I use these checks even when constraints exist.
-- =========================================================

SELECT
    'rental_customer' AS check_name,
    COUNT(*) FILTER (WHERE c.customer_id IS NULL) AS orphan_rows
FROM rental AS r
LEFT JOIN customer AS c
    ON c.customer_id = r.customer_id
UNION ALL
SELECT
    'rental_inventory' AS check_name,
    COUNT(*) FILTER (WHERE i.inventory_id IS NULL) AS orphan_rows
FROM rental AS r
LEFT JOIN inventory AS i
    ON i.inventory_id = r.inventory_id
UNION ALL
SELECT
    'payment_customer' AS check_name,
    COUNT(*) FILTER (WHERE c.customer_id IS NULL) AS orphan_rows
FROM payment AS p
LEFT JOIN customer AS c
    ON c.customer_id = p.customer_id
UNION ALL
SELECT
    'payment_rental' AS check_name,
    COUNT(*) FILTER (WHERE r.rental_id IS NULL) AS orphan_rows
FROM payment AS p
LEFT JOIN rental AS r
    ON r.rental_id = p.rental_id
UNION ALL
SELECT
    'inventory_film' AS check_name,
    COUNT(*) FILTER (WHERE f.film_id IS NULL) AS orphan_rows
FROM inventory AS i
LEFT JOIN film AS f
    ON f.film_id = i.film_id;

-- Bridge-table consistency for films and categories.
SELECT
    COUNT(*) FILTER (WHERE f.film_id IS NULL) AS film_category_missing_films,
    COUNT(*) FILTER (WHERE c.category_id IS NULL) AS film_category_missing_categories
FROM film_category AS fc
LEFT JOIN film AS f
    ON f.film_id = fc.film_id
LEFT JOIN category AS c
    ON c.category_id = fc.category_id;
