-- =========================================================
-- File: 06_lateral.sql
-- Goal: Use LATERAL for top-N and per-row dependent subqueries.
-- Dataset: dvdrental
-- Grain: one row per outer entity and selected related row.
-- Notes: LATERAL is useful when the inner query depends on each outer row.
-- =========================================================

-- Most recent rental per customer using LEFT JOIN LATERAL.
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    latest_rental.rental_id,
    latest_rental.rental_date
FROM customer AS c
LEFT JOIN LATERAL (
    SELECT
        r.rental_id,
        r.rental_date
    FROM rental AS r
    WHERE r.customer_id = c.customer_id
    ORDER BY r.rental_date DESC
    LIMIT 1
) AS latest_rental
    ON TRUE
ORDER BY latest_rental.rental_date DESC NULLS LAST
LIMIT 50;

-- Top 3 films by revenue within each category.
SELECT
    cat.category_id,
    cat.name AS category_name,
    top_films.film_id,
    top_films.title,
    top_films.revenue
FROM category AS cat
CROSS JOIN LATERAL (
    SELECT
        f.film_id,
        f.title,
        SUM(p.amount) AS revenue
    FROM film_category AS fc
    INNER JOIN film AS f
        ON f.film_id = fc.film_id
    INNER JOIN inventory AS i
        ON i.film_id = f.film_id
    INNER JOIN rental AS r
        ON r.inventory_id = i.inventory_id
    INNER JOIN payment AS p
        ON p.rental_id = r.rental_id
    WHERE fc.category_id = cat.category_id
    GROUP BY
        f.film_id,
        f.title
    ORDER BY revenue DESC
    LIMIT 3
) AS top_films
ORDER BY
    cat.name,
    top_films.revenue DESC;

-- Per-film first and last rental dates from inventory/rental history.
SELECT
    f.film_id,
    f.title,
    rental_span.first_rental_at,
    rental_span.last_rental_at
FROM film AS f
LEFT JOIN LATERAL (
    SELECT
        MIN(r.rental_date) AS first_rental_at,
        MAX(r.rental_date) AS last_rental_at
    FROM inventory AS i
    INNER JOIN rental AS r
        ON r.inventory_id = i.inventory_id
    WHERE i.film_id = f.film_id
) AS rental_span
    ON TRUE
ORDER BY rental_span.last_rental_at DESC NULLS LAST;
