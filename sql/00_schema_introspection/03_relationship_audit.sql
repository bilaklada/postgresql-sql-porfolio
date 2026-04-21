-- =========================================================
-- File: 03_relationship_audit.sql
-- Goal: Check important relationship coverage in dvdrental.
-- Dataset: dvdrental
-- Grain: one row per relationship check.
-- Notes: These checks are useful even when foreign keys exist.
-- =========================================================

-- Confirm each rental points to a known customer and inventory item.
SELECT
    'rental_customer' AS check_name,
    COUNT(*) FILTER (WHERE c.customer_id IS NULL) AS missing_parent_rows
FROM rental AS r
LEFT JOIN customer AS c
    ON c.customer_id = r.customer_id
UNION ALL
SELECT
    'rental_inventory' AS check_name,
    COUNT(*) FILTER (WHERE i.inventory_id IS NULL) AS missing_parent_rows
FROM rental AS r
LEFT JOIN inventory AS i
    ON i.inventory_id = r.inventory_id;

-- Check payment to rental coverage. A payment should point to a valid rental.
SELECT
    COUNT(*) AS payment_rows,
    COUNT(*) FILTER (WHERE r.rental_id IS NULL) AS payments_without_rental,
    COUNT(DISTINCT p.rental_id) AS distinct_paid_rentals
FROM payment AS p
LEFT JOIN rental AS r
    ON r.rental_id = p.rental_id;

-- Identify films with no inventory copies. This is a valid business state,
-- but it matters for rental-demand analysis.
SELECT
    f.film_id,
    f.title
FROM film AS f
WHERE NOT EXISTS (
    SELECT 1
    FROM inventory AS i
    WHERE i.film_id = f.film_id
)
ORDER BY f.title;
