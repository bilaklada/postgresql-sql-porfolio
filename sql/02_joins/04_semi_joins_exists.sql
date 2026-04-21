-- =========================================================
-- File: 04_semi_joins_exists.sql
-- Goal: Use EXISTS when only relationship presence matters.
-- Dataset: dvdrental
-- Grain: one row per entity from the outer query.
-- Notes: EXISTS avoids unnecessary row multiplication.
-- =========================================================

-- Customers who have at least one payment greater than 9.
SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM customer AS c
WHERE EXISTS (
    SELECT 1
    FROM payment AS p
    WHERE p.customer_id = c.customer_id
      AND p.amount > 9
)
ORDER BY c.customer_id;

-- Films that have been rented at least once.
SELECT
    f.film_id,
    f.title
FROM film AS f
WHERE EXISTS (
    SELECT 1
    FROM inventory AS i
    INNER JOIN rental AS r
        ON r.inventory_id = i.inventory_id
    WHERE i.film_id = f.film_id
)
ORDER BY f.title;

-- Categories with at least one premium-priced film.
SELECT
    cat.category_id,
    cat.name AS category_name
FROM category AS cat
WHERE EXISTS (
    SELECT 1
    FROM film_category AS fc
    INNER JOIN film AS f
        ON f.film_id = fc.film_id
    WHERE fc.category_id = cat.category_id
      AND f.rental_rate = 4.99
)
ORDER BY cat.name;
