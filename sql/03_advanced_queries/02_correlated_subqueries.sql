-- =========================================================
-- File: 02_correlated_subqueries.sql
-- Goal: Use correlated subqueries when logic depends on the outer row.
-- Dataset: dvdrental
-- Grain: one row per outer entity.
-- Notes: Correlation can be clear, but performance should be reviewed.
-- =========================================================

-- Most recent rental per customer using a correlated subquery.
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    (
        SELECT MAX(r.rental_date)
        FROM rental AS r
        WHERE r.customer_id = c.customer_id
    ) AS last_rental_at
FROM customer AS c
ORDER BY last_rental_at DESC NULLS LAST;

-- Films with rental count above the average rental count in their category.
SELECT
    f.film_id,
    f.title,
    cat.name AS category_name,
    (
        SELECT COUNT(*)
        FROM inventory AS i
        INNER JOIN rental AS r
            ON r.inventory_id = i.inventory_id
        WHERE i.film_id = f.film_id
    ) AS film_rental_count
FROM film AS f
INNER JOIN film_category AS fc
    ON fc.film_id = f.film_id
INNER JOIN category AS cat
    ON cat.category_id = fc.category_id
WHERE (
    SELECT COUNT(*)
    FROM inventory AS i
    INNER JOIN rental AS r
        ON r.inventory_id = i.inventory_id
    WHERE i.film_id = f.film_id
) > (
    SELECT AVG(category_film_counts.rental_count)
    FROM (
        SELECT
            fc2.film_id,
            COUNT(r2.rental_id) AS rental_count
        FROM film_category AS fc2
        LEFT JOIN inventory AS i2
            ON i2.film_id = fc2.film_id
        LEFT JOIN rental AS r2
            ON r2.inventory_id = i2.inventory_id
        WHERE fc2.category_id = fc.category_id
        GROUP BY fc2.film_id
    ) AS category_film_counts
)
ORDER BY
    cat.name,
    film_rental_count DESC;

-- Customers whose last payment is later than their last rental start.
SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM customer AS c
WHERE (
    SELECT MAX(p.payment_date)
    FROM payment AS p
    WHERE p.customer_id = c.customer_id
) > (
    SELECT MAX(r.rental_date)
    FROM rental AS r
    WHERE r.customer_id = c.customer_id
);
