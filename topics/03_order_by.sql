-- =========================================================
-- File: 03_order_by.sql
-- Database: PostgreSQL / dvdrental
-- Topic: ORDER BY
-- Purpose: Practice result set ordering using single-column
--          and multi-column sorting, including ranking-style
--          queries combined with LIMIT.
-- Author: Lada Bilak
-- =========================================================

-- ---------------------------------------------------------
-- 1. Sort films by duration in descending order
-- Goal: Retrieve film titles and lengths, ordered from the
--       longest film to the shortest.
-- ---------------------------------------------------------
SELECT title,
       length
FROM film
ORDER BY length DESC;

-- ---------------------------------------------------------
-- 2. Sort films by rental rate in descending order
-- Goal: Retrieve film titles and rental rates, ordered from
--       the highest rental rate to the lowest.
-- ---------------------------------------------------------
SELECT title,
       rental_rate
FROM film
ORDER BY rental_rate DESC;

-- ---------------------------------------------------------
-- 3. Retrieve the shortest films
-- Goal: Return the 10 shortest films by ordering film
--       duration in ascending order.
-- ---------------------------------------------------------
SELECT title,
       length
FROM film
ORDER BY length ASC
LIMIT 10;

-- ---------------------------------------------------------
-- 4. Retrieve the highest-priced rentals
-- Goal: Return the 5 films with the highest rental rates.
-- ---------------------------------------------------------
SELECT title,
       rental_rate
FROM film
ORDER BY rental_rate DESC
LIMIT 5;

-- ---------------------------------------------------------
-- 5. Sort PG-rated films by duration
-- Goal: Retrieve PG-rated films and order them from the
--       longest runtime to the shortest.
-- ---------------------------------------------------------
SELECT title,
       rating,
       length
FROM film
WHERE rating = 'PG'
ORDER BY length DESC;

-- ---------------------------------------------------------
-- 6. Retrieve the largest payment amounts
-- Goal: Return the 10 payment records with the highest
--       transaction amounts.
-- ---------------------------------------------------------
SELECT payment_id,
       amount
FROM payment
ORDER BY amount DESC
LIMIT 10;

-- ---------------------------------------------------------
-- 7. Sort actors alphabetically by last name
-- Goal: Retrieve actor names ordered alphabetically by
--       surname and limit the output to 15 rows.
-- ---------------------------------------------------------
SELECT first_name,
       last_name
FROM actor
ORDER BY last_name ASC
LIMIT 15;

-- ---------------------------------------------------------
-- 8. Sort PG-rated films by rental rate
-- Goal: Retrieve PG-rated films ordered by rental rate from
--       highest to lowest and limit the output to 10 rows.
-- ---------------------------------------------------------
SELECT title,
       rating,
       rental_rate
FROM film
WHERE rating = 'PG'
ORDER BY rental_rate DESC
LIMIT 10;

-- ---------------------------------------------------------
-- 9. Apply multi-column sorting
-- Goal: Retrieve films ordered first by rating and then by
--       film length in descending order within each rating.
-- ---------------------------------------------------------
SELECT title,
       rating,
       length
FROM film
ORDER BY rating ASC,
         length DESC
LIMIT 20;
