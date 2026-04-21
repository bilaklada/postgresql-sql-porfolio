-- =========================================================
-- File: 06_join_pitfalls.sql
-- Goal: Show common join mistakes and validation patterns.
-- Dataset: dvdrental
-- Grain: one row per validation check or corrected result.
-- Notes: A correct-looking join can still change the intended grain.
-- =========================================================

-- Pitfall: joining films to actors changes grain from film to film-actor.
SELECT
    COUNT(*) AS joined_rows,
    COUNT(DISTINCT f.film_id) AS distinct_films,
    COUNT(*) - COUNT(DISTINCT f.film_id) AS extra_rows_from_actor_bridge
FROM film AS f
INNER JOIN film_actor AS fa
    ON fa.film_id = f.film_id
INNER JOIN actor AS a
    ON a.actor_id = fa.actor_id;

-- Correct category film counts should count distinct films after a bridge join.
SELECT
    cat.category_id,
    cat.name AS category_name,
    COUNT(fc.film_id) AS bridge_rows,
    COUNT(DISTINCT fc.film_id) AS distinct_films
FROM category AS cat
LEFT JOIN film_category AS fc
    ON fc.category_id = cat.category_id
GROUP BY
    cat.category_id,
    cat.name
ORDER BY cat.name;

-- Payment to rental should be one payment row per payment_id after joining.
SELECT
    COUNT(*) AS joined_rows,
    COUNT(DISTINCT p.payment_id) AS distinct_payments,
    COUNT(*) - COUNT(DISTINCT p.payment_id) AS duplicate_payment_rows
FROM payment AS p
INNER JOIN rental AS r
    ON r.rental_id = p.rental_id;

-- Safer pattern: aggregate at the intended grain before joining dimensions.
WITH revenue_by_film AS (
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
    f.film_id,
    f.title,
    COALESCE(rbf.revenue, 0) AS revenue
FROM film AS f
LEFT JOIN revenue_by_film AS rbf
    ON rbf.film_id = f.film_id
ORDER BY revenue DESC
LIMIT 25;
