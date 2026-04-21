-- =========================================================
-- File: 01_window_ranking.sql
-- Goal: Use ranking window functions for analytical ordering.
-- Dataset: dvdrental
-- Grain: one row per ranked entity.
-- Notes: Ranking functions keep detail rows while adding relative position.
-- =========================================================

-- Rank customers by total revenue.
WITH customer_revenue AS (
    SELECT
        p.customer_id,
        SUM(p.amount) AS total_revenue
    FROM payment AS p
    GROUP BY p.customer_id
)
SELECT
    cr.customer_id,
    c.first_name,
    c.last_name,
    cr.total_revenue,
    ROW_NUMBER() OVER (ORDER BY cr.total_revenue DESC, cr.customer_id) AS row_number_rank,
    RANK() OVER (ORDER BY cr.total_revenue DESC) AS rank_with_gaps,
    DENSE_RANK() OVER (ORDER BY cr.total_revenue DESC) AS dense_rank_no_gaps
FROM customer_revenue AS cr
INNER JOIN customer AS c
    ON c.customer_id = cr.customer_id
ORDER BY row_number_rank
LIMIT 50;

-- Rank films within each category by rental count.
WITH film_category_rentals AS (
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
)
SELECT
    category_name,
    film_id,
    title,
    rental_count,
    DENSE_RANK() OVER (
        PARTITION BY category_id
        ORDER BY rental_count DESC
    ) AS category_rental_rank
FROM film_category_rentals
ORDER BY
    category_name,
    category_rental_rank,
    title;
