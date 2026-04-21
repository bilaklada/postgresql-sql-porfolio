-- =========================================================
-- File: 05_top_n_per_group.sql
-- Goal: Return top-N records within each group.
-- Dataset: dvdrental
-- Grain: one row per ranked item within group.
-- Notes: ROW_NUMBER is useful when I need exactly N rows per group.
-- =========================================================

-- Top 3 films by rental count in each category.
WITH film_rentals AS (
    SELECT
        cat.category_id,
        cat.name AS category_name,
        f.film_id,
        f.title,
        COUNT(r.rental_id) AS rental_count
    FROM category AS cat
    INNER JOIN film_category AS fc
        ON fc.category_id = cat.category_id
    INNER JOIN film AS f
        ON f.film_id = fc.film_id
    LEFT JOIN inventory AS i
        ON i.film_id = f.film_id
    LEFT JOIN rental AS r
        ON r.inventory_id = i.inventory_id
    GROUP BY
        cat.category_id,
        cat.name,
        f.film_id,
        f.title
),
ranked AS (
    SELECT
        film_rentals.*,
        ROW_NUMBER() OVER (
            PARTITION BY category_id
            ORDER BY rental_count DESC, title
        ) AS category_row_number
    FROM film_rentals
)
SELECT
    category_name,
    film_id,
    title,
    rental_count,
    category_row_number
FROM ranked
WHERE category_row_number <= 3
ORDER BY
    category_name,
    category_row_number;

-- Top 5 customers by revenue within each store.
WITH customer_store_revenue AS (
    SELECT
        c.store_id,
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(p.amount) AS total_revenue
    FROM customer AS c
    INNER JOIN payment AS p
        ON p.customer_id = c.customer_id
    GROUP BY
        c.store_id,
        c.customer_id,
        c.first_name,
        c.last_name
)
SELECT
    store_id,
    customer_id,
    first_name,
    last_name,
    total_revenue,
    ROW_NUMBER() OVER (
        PARTITION BY store_id
        ORDER BY total_revenue DESC, customer_id
    ) AS store_customer_rank
FROM customer_store_revenue
ORDER BY
    store_id,
    store_customer_rank
LIMIT 10;
