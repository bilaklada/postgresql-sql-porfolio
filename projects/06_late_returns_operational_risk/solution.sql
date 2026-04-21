-- =========================================================
-- Project: Late Returns Operational Risk
-- Goal: Analyze late return patterns by store and category.
-- Dataset: dvdrental
-- Grain: one row per store and category in final output.
-- =========================================================

WITH rental_detail AS (
    SELECT
        r.rental_id,
        r.customer_id,
        i.store_id,
        f.film_id,
        f.title,
        f.rental_duration,
        c.category_id,
        c.name AS category_name,
        r.rental_date,
        r.return_date,
        r.rental_date + (f.rental_duration * INTERVAL '1 day') AS expected_return_at,
        CASE
            WHEN r.return_date IS NULL THEN FALSE
            WHEN r.return_date > r.rental_date + (f.rental_duration * INTERVAL '1 day') THEN TRUE
            ELSE FALSE
        END AS is_late_return,
        CASE
            WHEN r.return_date IS NULL THEN TRUE
            ELSE FALSE
        END AS is_open_rental
    FROM rental AS r
    INNER JOIN inventory AS i
        ON i.inventory_id = r.inventory_id
    INNER JOIN film AS f
        ON f.film_id = i.film_id
    INNER JOIN film_category AS fc
        ON fc.film_id = f.film_id
    INNER JOIN category AS c
        ON c.category_id = fc.category_id
),
store_category_risk AS (
    SELECT
        store_id,
        category_id,
        category_name,
        COUNT(*) AS rental_count,
        COUNT(*) FILTER (WHERE return_date IS NOT NULL) AS returned_rental_count,
        COUNT(*) FILTER (WHERE is_open_rental) AS open_rental_count,
        COUNT(*) FILTER (WHERE is_late_return) AS late_return_count,
        ROUND(
            COUNT(*) FILTER (WHERE is_late_return)::numeric
            / NULLIF(COUNT(*) FILTER (WHERE return_date IS NOT NULL), 0),
            4
        ) AS late_return_rate,
        ROUND(
            AVG(
                CASE
                    WHEN is_late_return
                        THEN EXTRACT(EPOCH FROM (return_date - expected_return_at)) / 86400.0
                END
            ),
            2
        ) AS avg_days_late
    FROM rental_detail
    GROUP BY
        store_id,
        category_id,
        category_name
)
SELECT
    store_id,
    category_name,
    rental_count,
    returned_rental_count,
    open_rental_count,
    late_return_count,
    late_return_rate,
    avg_days_late,
    DENSE_RANK() OVER (
        PARTITION BY store_id
        ORDER BY late_return_rate DESC NULLS LAST, late_return_count DESC
    ) AS risk_rank_in_store
FROM store_category_risk
ORDER BY
    store_id,
    risk_rank_in_store,
    category_name;
