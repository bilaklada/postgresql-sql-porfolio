-- =========================================================
-- File: 01_select.sql
-- Database: PostgreSQL / dvdrental
-- Topic: SELECT
-- Purpose: Practice fundamental data retrieval, column selection,
--          row limiting, and basic row counting.
-- Author: Lada Bilak
-- =========================================================

-- ---------------------------------------------------------
-- 1. Preview actor records
-- Goal: Retrieve all columns from the actor table and inspect
--       a limited sample of rows.
-- ---------------------------------------------------------
SELECT *
FROM actor
LIMIT 10;

-- ---------------------------------------------------------
-- 2. Select specific film attributes
-- Goal: Retrieve selected business-relevant columns from the
--       film table and limit the output size.
-- ---------------------------------------------------------
SELECT title,
       release_year,
       rental_rate
FROM film
LIMIT 8;

-- ---------------------------------------------------------
-- 3. Preview customer records
-- Goal: Retrieve all columns from the customer table and
--       inspect a small sample of rows.
-- ---------------------------------------------------------
SELECT *
FROM customer
LIMIT 5;

-- ---------------------------------------------------------
-- 4. Count total number of films
-- Goal: Measure the total number of film records stored in
--       the database.
-- ---------------------------------------------------------
SELECT COUNT(*) AS total_films
FROM film;

-- ---------------------------------------------------------
-- 5. Count total number of customers
-- Goal: Measure the total number of customer records stored
--       in the database.
-- ---------------------------------------------------------
SELECT COUNT(*) AS total_customers
FROM customer;

-- ---------------------------------------------------------
-- 6. Count total number of rentals
-- Goal: Measure the total number of rental transactions
--       recorded in the system.
-- ---------------------------------------------------------
SELECT COUNT(*) AS total_rentals
FROM rental;

-- ---------------------------------------------------------
-- 7. Preview payment transactions
-- Goal: Retrieve all columns from the payment table and
--       inspect a limited sample of rows.
-- ---------------------------------------------------------
SELECT *
FROM payment
LIMIT 10;

-- ---------------------------------------------------------
-- 8. Select core film characteristics
-- Goal: Retrieve key descriptive attributes from the film
--       table for a limited number of rows.
-- ---------------------------------------------------------
SELECT title,
       length,
       rating
FROM film
LIMIT 15;
