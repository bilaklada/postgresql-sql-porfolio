-- =========================================================
-- File: 02_where.sql
-- Database: PostgreSQL / dvdrental
-- Topic: WHERE
-- Purpose: Practice row-level filtering using comparison
--          operators, logical conditions, pattern matching,
--          and range-based predicates.
-- Author: Lada Bilak
-- =========================================================

-- ---------------------------------------------------------
-- 1. Filter films by rating
-- Goal: Retrieve films classified with the PG rating.
-- ---------------------------------------------------------
SELECT title,
       rating
FROM film
WHERE rating = 'PG';

-- ---------------------------------------------------------
-- 2. Filter films by rental rate threshold
-- Goal: Retrieve films with a rental rate greater than 4.
-- ---------------------------------------------------------
SELECT title,
       rental_rate
FROM film
WHERE rental_rate > 4;

-- ---------------------------------------------------------
-- 3. Combine filtering conditions with AND
-- Goal: Retrieve PG-rated films longer than 120 minutes.
-- ---------------------------------------------------------
SELECT title,
       length,
       rating
FROM film
WHERE rating = 'PG'
  AND length > 120;

-- ---------------------------------------------------------
-- 4. Filter films by multiple rating values using OR
-- Goal: Retrieve films rated either PG or R.
-- ---------------------------------------------------------
SELECT title,
       rating
FROM film
WHERE rating = 'PG'
   OR rating = 'R';

-- ---------------------------------------------------------
-- 5. Filter films by multiple rating values using IN
-- Goal: Retrieve films rated either PG or R using a more
--       compact predicate form.
-- ---------------------------------------------------------
SELECT title,
       rating
FROM film
WHERE rating IN ('PG', 'R');

-- ---------------------------------------------------------
-- 6. Filter films by length range
-- Goal: Retrieve films whose duration falls between
--       90 and 120 minutes, inclusive.
-- ---------------------------------------------------------
SELECT title,
       length
FROM film
WHERE length BETWEEN 90 AND 120;

-- ---------------------------------------------------------
-- 7. Filter actors by first-name prefix
-- Goal: Retrieve actors whose first name starts with A.
-- ---------------------------------------------------------
SELECT first_name,
       last_name
FROM actor
WHERE first_name LIKE 'A%';

-- ---------------------------------------------------------
-- 8. Filter actors by last-name substring
-- Goal: Retrieve actors whose last name contains 'son'.
-- ---------------------------------------------------------
SELECT first_name,
       last_name
FROM actor
WHERE last_name LIKE '%son%';

-- ---------------------------------------------------------
-- 9. Filter payments by amount threshold
-- Goal: Retrieve payment records with an amount greater
--       than 7.
-- ---------------------------------------------------------
SELECT payment_id,
       amount
FROM payment
WHERE amount > 7;

-- ---------------------------------------------------------
-- 10. Combine rating and pricing conditions
-- Goal: Retrieve PG-rated films with a rental rate
--       greater than 4.
-- ---------------------------------------------------------
SELECT title,
       rating,
       rental_rate
FROM film
WHERE rating = 'PG'
  AND rental_rate > 4;
