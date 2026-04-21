-- =========================================================
-- File: 02_where.sql
-- Goal: Filter rows with clear predicates.
-- Dataset: dvdrental
-- Grain: one row per filtered record.
-- Notes: WHERE filters rows before aggregation.
-- =========================================================

-- Films that are long and priced at the premium rental rate.
SELECT
    f.film_id,
    f.title,
    f.length,
    f.rental_rate,
    f.rating
FROM film AS f
WHERE f.length >= 150
  AND f.rental_rate = 4.99
ORDER BY
    f.length DESC,
    f.title;

-- Customers created during the first month represented in the customer table.
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.create_date
FROM customer AS c
WHERE c.create_date >= DATE '2006-02-01'
  AND c.create_date < DATE '2006-03-01'
ORDER BY c.create_date;

-- Rentals that have not been returned.
SELECT
    r.rental_id,
    r.customer_id,
    r.inventory_id,
    r.rental_date,
    r.return_date
FROM rental AS r
WHERE r.return_date IS NULL
ORDER BY r.rental_date;
