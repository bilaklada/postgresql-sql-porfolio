-- =========================================================
-- File: 07_common_patterns.sql
-- Goal: Collect reusable analytical SQL patterns.
-- Dataset: dvdrental
-- Grain: stated per pattern.
-- Notes: These patterns appear again in the project folder.
-- =========================================================

-- Pattern: aggregate facts before joining descriptive dimensions.
WITH revenue_by_customer AS (
    SELECT
        p.customer_id,
        SUM(p.amount) AS total_revenue
    FROM payment AS p
    GROUP BY p.customer_id
)
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    rbc.total_revenue
FROM revenue_by_customer AS rbc
INNER JOIN customer AS c
    ON c.customer_id = rbc.customer_id
ORDER BY rbc.total_revenue DESC;

-- Pattern: build flags with EXISTS instead of joining detail rows.
SELECT
    f.film_id,
    f.title,
    EXISTS (
        SELECT 1
        FROM inventory AS i
        INNER JOIN rental AS r
            ON r.inventory_id = i.inventory_id
        WHERE i.film_id = f.film_id
    ) AS has_been_rented
FROM film AS f
ORDER BY
    has_been_rented,
    f.title;

-- Pattern: reconcile detail and summary totals.
WITH detail_total AS (
    SELECT SUM(amount) AS total_revenue
    FROM payment
),
summary_total AS (
    SELECT SUM(customer_revenue) AS total_revenue
    FROM (
        SELECT
            customer_id,
            SUM(amount) AS customer_revenue
        FROM payment
        GROUP BY customer_id
    ) AS customer_summary
)
SELECT
    detail_total.total_revenue AS detail_revenue,
    summary_total.total_revenue AS summary_revenue,
    detail_total.total_revenue - summary_total.total_revenue AS difference
FROM detail_total
CROSS JOIN summary_total;
