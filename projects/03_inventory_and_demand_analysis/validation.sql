-- =========================================================
-- Project: Inventory and Demand Analysis
-- Goal: Validate inventory and rental demand metrics.
-- Dataset: dvdrental
-- =========================================================

-- Validation 1: film-level output should contain every film once.
WITH output AS (
    SELECT f.film_id
    FROM film AS f
    LEFT JOIN inventory AS i
        ON i.film_id = f.film_id
    GROUP BY f.film_id
)
SELECT
    (SELECT COUNT(*) FROM film) AS expected_films,
    COUNT(*) AS actual_rows,
    COUNT(DISTINCT film_id) AS distinct_films
FROM output;

-- Validation 2: rental counts summarized by film reconcile to rental detail.
WITH rental_summary AS (
    SELECT
        i.film_id,
        COUNT(r.rental_id) AS rental_count
    FROM inventory AS i
    LEFT JOIN rental AS r
        ON r.inventory_id = i.inventory_id
    GROUP BY i.film_id
)
SELECT
    (SELECT COUNT(*) FROM rental) AS rental_detail_count,
    SUM(rental_count) AS film_summary_rental_count,
    (SELECT COUNT(*) FROM rental) - SUM(rental_count) AS difference
FROM rental_summary;

-- Validation 3: inventory copies that have never been rented.
SELECT
    COUNT(*) AS inventory_copies_never_rented
FROM inventory AS i
WHERE NOT EXISTS (
    SELECT 1
    FROM rental AS r
    WHERE r.inventory_id = i.inventory_id
);
