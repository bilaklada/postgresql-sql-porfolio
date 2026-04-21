-- =========================================================
-- Project: Top Films, Categories, and Rankings
-- Goal: Rank films within categories by rental activity and revenue.
-- Dataset: dvdrental
-- Grain: one row per film and category.
-- =========================================================

WITH film_category_metrics AS (
    SELECT
        c.category_id,
        c.name AS category_name,
        f.film_id,
        f.title,
        f.rating,
        COUNT(r.rental_id) AS rental_count,
        COALESCE(SUM(p.amount), 0) AS revenue,
        ROUND(AVG(p.amount), 2) AS avg_payment_amount
    FROM category AS c
    INNER JOIN film_category AS fc
        ON fc.category_id = c.category_id
    INNER JOIN film AS f
        ON f.film_id = fc.film_id
    LEFT JOIN inventory AS i
        ON i.film_id = f.film_id
    LEFT JOIN rental AS r
        ON r.inventory_id = i.inventory_id
    LEFT JOIN payment AS p
        ON p.rental_id = r.rental_id
    GROUP BY
        c.category_id,
        c.name,
        f.film_id,
        f.title,
        f.rating
),
ranked AS (
    SELECT
        film_category_metrics.*,
        DENSE_RANK() OVER (
            PARTITION BY category_id
            ORDER BY revenue DESC
        ) AS category_revenue_rank,
        DENSE_RANK() OVER (
            PARTITION BY category_id
            ORDER BY rental_count DESC
        ) AS category_rental_rank
    FROM film_category_metrics
)
SELECT
    category_name,
    film_id,
    title,
    rating,
    rental_count,
    revenue,
    avg_payment_amount,
    category_revenue_rank,
    category_rental_rank
FROM ranked
WHERE category_revenue_rank <= 5
   OR category_rental_rank <= 5
ORDER BY
    category_name,
    category_revenue_rank,
    category_rental_rank,
    title;
