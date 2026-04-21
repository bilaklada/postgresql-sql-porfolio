-- =========================================================
-- Project: Top Films, Categories, and Rankings
-- Goal: Validate category bridge behavior and revenue totals.
-- Dataset: dvdrental
-- =========================================================

-- Validation 1: check how many category assignments each film has.
SELECT
    category_count,
    COUNT(*) AS film_count
FROM (
    SELECT
        f.film_id,
        COUNT(fc.category_id) AS category_count
    FROM film AS f
    LEFT JOIN film_category AS fc
        ON fc.film_id = f.film_id
    GROUP BY f.film_id
) AS film_category_counts
GROUP BY category_count
ORDER BY category_count;

-- Validation 2: rental count by film should reconcile to rental detail.
WITH film_rentals AS (
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
    SUM(rental_count) AS film_rental_count,
    (SELECT COUNT(*) FROM rental) - SUM(rental_count) AS difference
FROM film_rentals;

-- Validation 3: revenue by film should reconcile to payment detail.
WITH film_revenue AS (
    SELECT
        i.film_id,
        SUM(p.amount) AS revenue
    FROM payment AS p
    INNER JOIN rental AS r
        ON r.rental_id = p.rental_id
    INNER JOIN inventory AS i
        ON i.inventory_id = r.inventory_id
    GROUP BY i.film_id
)
SELECT
    (SELECT SUM(amount) FROM payment) AS payment_detail_total,
    SUM(revenue) AS film_revenue_total,
    (SELECT SUM(amount) FROM payment) - SUM(revenue) AS difference
FROM film_revenue;
