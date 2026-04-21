-- =========================================================
-- Project: Inventory and Demand Analysis
-- Goal: Compare film inventory coverage with rental demand.
-- Dataset: dvdrental
-- Grain: one row per film.
-- =========================================================

WITH inventory_summary AS (
    SELECT
        i.film_id,
        COUNT(*) AS inventory_copy_count,
        COUNT(DISTINCT i.store_id) AS store_count
    FROM inventory AS i
    GROUP BY i.film_id
),
rental_summary AS (
    SELECT
        i.film_id,
        COUNT(r.rental_id) AS rental_count,
        SUM(p.amount) AS revenue
    FROM inventory AS i
    LEFT JOIN rental AS r
        ON r.inventory_id = i.inventory_id
    LEFT JOIN payment AS p
        ON p.rental_id = r.rental_id
    GROUP BY i.film_id
),
film_category_labels AS (
    SELECT
        fc.film_id,
        STRING_AGG(c.name, ', ' ORDER BY c.name) AS categories
    FROM film_category AS fc
    INNER JOIN category AS c
        ON c.category_id = fc.category_id
    GROUP BY fc.film_id
),
film_inventory_demand AS (
    SELECT
        f.film_id,
        f.title,
        f.rating,
        f.rental_rate,
        COALESCE(fcl.categories, 'uncategorized') AS categories,
        COALESCE(inv.inventory_copy_count, 0) AS inventory_copy_count,
        COALESCE(inv.store_count, 0) AS store_count,
        COALESCE(rs.rental_count, 0) AS rental_count,
        COALESCE(rs.revenue, 0) AS revenue,
        ROUND(
            COALESCE(rs.rental_count, 0)::numeric
            / NULLIF(inv.inventory_copy_count, 0),
            2
        ) AS rentals_per_copy
    FROM film AS f
    LEFT JOIN inventory_summary AS inv
        ON inv.film_id = f.film_id
    LEFT JOIN rental_summary AS rs
        ON rs.film_id = f.film_id
    LEFT JOIN film_category_labels AS fcl
        ON fcl.film_id = f.film_id
)
SELECT
    film_id,
    title,
    rating,
    rental_rate,
    categories,
    inventory_copy_count,
    store_count,
    rental_count,
    revenue,
    rentals_per_copy,
    CASE
        WHEN inventory_copy_count = 0 THEN 'no_inventory'
        WHEN rental_count = 0 THEN 'stock_not_rented'
        WHEN rentals_per_copy >= 5 THEN 'high_demand_per_copy'
        WHEN rentals_per_copy <= 2 THEN 'low_demand_per_copy'
        ELSE 'balanced'
    END AS inventory_status
FROM film_inventory_demand
ORDER BY
    inventory_status,
    rentals_per_copy DESC NULLS LAST,
    revenue DESC,
    title;
