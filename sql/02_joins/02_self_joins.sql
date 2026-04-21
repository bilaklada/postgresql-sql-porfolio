-- =========================================================
-- File: 02_self_joins.sql
-- Goal: Use self joins for comparisons within the same table.
-- Dataset: dvdrental
-- Grain: one row per matched pair.
-- Notes: Self joins require careful inequality predicates to avoid duplicates.
-- =========================================================

-- Films with the same length and rating, returned as unique pairs.
SELECT
    f1.film_id AS film_id_1,
    f1.title AS title_1,
    f2.film_id AS film_id_2,
    f2.title AS title_2,
    f1.rating,
    f1.length
FROM film AS f1
INNER JOIN film AS f2
    ON f2.rating = f1.rating
   AND f2.length = f1.length
   AND f2.film_id > f1.film_id
ORDER BY
    f1.rating,
    f1.length,
    f1.title
LIMIT 50;

-- Customers in the same store and city, represented as unique customer pairs.
SELECT
    c1.customer_id AS customer_id_1,
    c1.first_name AS first_name_1,
    c1.last_name AS last_name_1,
    c2.customer_id AS customer_id_2,
    c2.first_name AS first_name_2,
    c2.last_name AS last_name_2,
    city.city
FROM customer AS c1
INNER JOIN customer AS c2
    ON c2.store_id = c1.store_id
   AND c2.customer_id > c1.customer_id
INNER JOIN address AS a1
    ON a1.address_id = c1.address_id
INNER JOIN address AS a2
    ON a2.address_id = c2.address_id
   AND a2.city_id = a1.city_id
INNER JOIN city
    ON city.city_id = a1.city_id
ORDER BY city.city
LIMIT 50;

-- Staff members compared with other staff in the same store.
SELECT
    s1.store_id,
    s1.staff_id AS staff_id_1,
    s1.first_name AS staff_first_name_1,
    s2.staff_id AS staff_id_2,
    s2.first_name AS staff_first_name_2
FROM staff AS s1
INNER JOIN staff AS s2
    ON s2.store_id = s1.store_id
   AND s2.staff_id > s1.staff_id
ORDER BY
    s1.store_id,
    s1.staff_id;
