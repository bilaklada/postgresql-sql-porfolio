-- =========================================================
-- File: 01_inner_left_right_full.sql
-- Goal: Demonstrate join types with practical dvdrental questions.
-- Dataset: dvdrental
-- Grain: varies by query; stated before each example.
-- Notes: I use RIGHT/FULL joins sparingly because LEFT joins are usually clearer.
-- =========================================================

-- Grain: one row per payment with customer context.
SELECT
    p.payment_id,
    p.payment_date,
    p.amount,
    c.customer_id,
    c.first_name,
    c.last_name
FROM payment AS p
INNER JOIN customer AS c
    ON c.customer_id = p.customer_id
ORDER BY p.payment_date DESC
LIMIT 25;

-- Grain: one row per film, including films with no inventory copies.
SELECT
    f.film_id,
    f.title,
    COUNT(i.inventory_id) AS inventory_copy_count
FROM film AS f
LEFT JOIN inventory AS i
    ON i.film_id = f.film_id
GROUP BY
    f.film_id,
    f.title
ORDER BY
    inventory_copy_count,
    f.title
LIMIT 25;

-- RIGHT JOIN equivalent: keep every category even if no film exists.
SELECT
    c.category_id,
    c.name AS category_name,
    COUNT(fc.film_id) AS film_count
FROM film_category AS fc
RIGHT JOIN category AS c
    ON c.category_id = fc.category_id
GROUP BY
    c.category_id,
    c.name
ORDER BY c.name;

-- FULL JOIN demo with store assignment values from customers and staff.
SELECT
    COALESCE(customer_stores.store_id, staff_stores.store_id) AS store_id,
    customer_stores.customer_count,
    staff_stores.staff_count
FROM (
    SELECT store_id, COUNT(*) AS customer_count
    FROM customer
    GROUP BY store_id
) AS customer_stores
FULL JOIN (
    SELECT store_id, COUNT(*) AS staff_count
    FROM staff
    GROUP BY store_id
) AS staff_stores
    ON staff_stores.store_id = customer_stores.store_id
ORDER BY store_id;
