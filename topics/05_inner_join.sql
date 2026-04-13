-- =========================================================
-- File: 05_inner_join.sql
-- Database: PostgreSQL / dvdrental
-- Topic: INNER JOIN
-- Purpose: Practice joining related tables to combine
--          transactional and reference data, including
--          many-to-many bridge tables, grouped analysis,
--          and filtered aggregate reporting.
-- Author: Lada Bilak
-- =========================================================

-- =========================================================
-- Section 1: Foundational INNER JOIN queries
-- =========================================================

-- ---------------------------------------------------------
-- 1. Join customers with payments
-- Goal: Retrieve customer names together with payment
--       amounts and preview a limited sample.
-- ---------------------------------------------------------
SELECT c.first_name,
       c.last_name,
       p.amount
FROM customer AS c
JOIN payment AS p
  ON c.customer_id = p.customer_id
LIMIT 10;

-- ---------------------------------------------------------
-- 2. Join films with languages
-- Goal: Retrieve film titles together with their language.
-- ---------------------------------------------------------
SELECT f.title,
       l.name AS language_name
FROM film AS f
JOIN language AS l
  ON f.language_id = l.language_id
LIMIT 10;

-- ---------------------------------------------------------
-- 3. Join payments with rentals
-- Goal: Retrieve payment transactions together with the
--       associated rental date.
-- ---------------------------------------------------------
SELECT p.payment_id,
       p.amount,
       r.rental_date
FROM payment AS p
JOIN rental AS r
  ON p.rental_id = r.rental_id
LIMIT 10;

-- ---------------------------------------------------------
-- 4. Rank payment records by amount
-- Goal: Retrieve customer identity together with payment
--       details and sort by payment amount descending.
-- ---------------------------------------------------------
SELECT c.first_name,
       c.last_name,
       p.payment_id,
       p.amount
FROM customer AS c
JOIN payment AS p
  ON c.customer_id = p.customer_id
ORDER BY p.amount DESC
LIMIT 10;

-- ---------------------------------------------------------
-- 5. Calculate total payment amount by customer
-- Goal: Aggregate payment volume per customer.
-- ---------------------------------------------------------
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       SUM(p.amount) AS total_payment
FROM customer AS c
JOIN payment AS p
  ON c.customer_id = p.customer_id
GROUP BY c.customer_id,
         c.first_name,
         c.last_name
ORDER BY total_payment DESC;

-- ---------------------------------------------------------
-- 6. Join films with categories
-- Goal: Retrieve film titles together with category names
--       using the film_category bridge table.
-- ---------------------------------------------------------
SELECT f.title,
       c.name AS category_name
FROM film AS f
JOIN film_category AS fc
  ON f.film_id = fc.film_id
JOIN category AS c
  ON fc.category_id = c.category_id
LIMIT 10;

-- ---------------------------------------------------------
-- 7. Join actors with films
-- Goal: Retrieve actor names together with film titles
--       through the film_actor bridge table.
-- ---------------------------------------------------------
SELECT a.first_name,
       a.last_name,
       f.title
FROM actor AS a
JOIN film_actor AS fa
  ON a.actor_id = fa.actor_id
JOIN film AS f
  ON fa.film_id = f.film_id
LIMIT 10;

-- ---------------------------------------------------------
-- 8. Join customers with rentals
-- Goal: Retrieve customer names together with rental dates.
-- ---------------------------------------------------------
SELECT c.first_name,
       c.last_name,
       r.rental_date
FROM customer AS c
JOIN rental AS r
  ON c.customer_id = r.customer_id
LIMIT 10;

-- ---------------------------------------------------------
-- 9. Count rentals by film
-- Goal: Measure how many times each film was rented using
--       the film -> inventory -> rental relationship chain.
-- ---------------------------------------------------------
SELECT f.film_id,
       f.title,
       COUNT(r.rental_id) AS number_of_rentals
FROM film AS f
JOIN inventory AS i
  ON f.film_id = i.film_id
JOIN rental AS r
  ON i.inventory_id = r.inventory_id
GROUP BY f.film_id,
         f.title
ORDER BY number_of_rentals DESC;

-- ---------------------------------------------------------
-- 10. Count payments by customer
-- Goal: Measure how many payments each customer made.
-- ---------------------------------------------------------
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       COUNT(p.payment_id) AS number_of_payments
FROM customer AS c
JOIN payment AS p
  ON c.customer_id = p.customer_id
GROUP BY c.customer_id,
         c.first_name,
         c.last_name
ORDER BY number_of_payments DESC;

-- ---------------------------------------------------------
-- 11. Sort films with language names alphabetically
-- Goal: Retrieve film titles and language names ordered by
--       film title.
-- ---------------------------------------------------------
SELECT f.title,
       l.name AS language_name
FROM film AS f
JOIN language AS l
  ON f.language_id = l.language_id
ORDER BY f.title ASC;

-- ---------------------------------------------------------
-- 12. Retrieve largest payment records with customer names
-- Goal: Show payment details together with customer identity
--       for the highest-value payment rows.
-- ---------------------------------------------------------
SELECT p.payment_id,
       p.amount,
       c.first_name,
       c.last_name
FROM payment AS p
JOIN customer AS c
  ON p.customer_id = c.customer_id
ORDER BY p.amount DESC
LIMIT 5;

-- =========================================================
-- Section 2: INNER JOIN with GROUP BY and HAVING
-- =========================================================

-- ---------------------------------------------------------
-- 13. Calculate total amount paid by each customer
-- Goal: Aggregate customer payment totals and sort them from
--       highest to lowest.
-- ---------------------------------------------------------
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       SUM(p.amount) AS total_paid
FROM customer AS c
JOIN payment AS p
  ON c.customer_id = p.customer_id
GROUP BY c.customer_id,
         c.first_name,
         c.last_name
ORDER BY total_paid DESC;

-- ---------------------------------------------------------
-- 14. Return the top 10 customers by total spending
-- Goal: Rank customers by cumulative payment amount.
-- ---------------------------------------------------------
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       SUM(p.amount) AS total_paid
FROM customer AS c
JOIN payment AS p
  ON c.customer_id = p.customer_id
GROUP BY c.customer_id,
         c.first_name,
         c.last_name
ORDER BY total_paid DESC
LIMIT 10;

-- ---------------------------------------------------------
-- 15. Count payments per customer
-- Goal: Measure payment frequency for each customer.
-- ---------------------------------------------------------
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       COUNT(p.payment_id) AS number_of_payments
FROM customer AS c
JOIN payment AS p
  ON c.customer_id = p.customer_id
GROUP BY c.customer_id,
         c.first_name,
         c.last_name
ORDER BY number_of_payments DESC;

-- ---------------------------------------------------------
-- 16. Return customers with more than 30 payments
-- Goal: Filter grouped customer payment counts using HAVING.
-- ---------------------------------------------------------
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       COUNT(p.payment_id) AS number_of_payments
FROM customer AS c
JOIN payment AS p
  ON c.customer_id = p.customer_id
GROUP BY c.customer_id,
         c.first_name,
         c.last_name
HAVING COUNT(p.payment_id) > 30
ORDER BY number_of_payments DESC;

-- ---------------------------------------------------------
-- 17. Count rentals by film
-- Goal: Measure rental volume for each film and rank films
--       by number of rentals.
-- ---------------------------------------------------------
SELECT f.film_id,
       f.title,
       COUNT(r.rental_id) AS number_of_rentals
FROM film AS f
JOIN inventory AS i
  ON f.film_id = i.film_id
JOIN rental AS r
  ON i.inventory_id = r.inventory_id
GROUP BY f.film_id,
         f.title
ORDER BY number_of_rentals DESC;

-- ---------------------------------------------------------
-- 18. Return the top 10 most rented films
-- Goal: Rank films by rental volume and keep the top 10.
-- ---------------------------------------------------------
SELECT f.film_id,
       f.title,
       COUNT(r.rental_id) AS number_of_rentals
FROM film AS f
JOIN inventory AS i
  ON f.film_id = i.film_id
JOIN rental AS r
  ON i.inventory_id = r.inventory_id
GROUP BY f.film_id,
         f.title
ORDER BY number_of_rentals DESC
LIMIT 10;

-- ---------------------------------------------------------
-- 19. Count films by category
-- Goal: Measure how many films belong to each category.
-- ---------------------------------------------------------
SELECT c.category_id,
       c.name AS category_name,
       COUNT(fc.film_id) AS number_of_films
FROM category AS c
JOIN film_category AS fc
  ON c.category_id = fc.category_id
GROUP BY c.category_id,
         c.name
ORDER BY number_of_films DESC;

-- ---------------------------------------------------------
-- 20. Calculate average film length by category
-- Goal: Measure average runtime for films within each
--       category.
-- ---------------------------------------------------------
SELECT c.category_id,
       c.name AS category_name,
       AVG(f.length) AS avg_length
FROM category AS c
JOIN film_category AS fc
  ON c.category_id = fc.category_id
JOIN film AS f
  ON fc.film_id = f.film_id
GROUP BY c.category_id,
         c.name
ORDER BY avg_length DESC;

-- ---------------------------------------------------------
-- 21. Return categories with average film length above 110
-- Goal: Filter grouped category averages using HAVING.
-- ---------------------------------------------------------
SELECT c.category_id,
       c.name AS category_name,
       AVG(f.length) AS avg_length
FROM category AS c
JOIN film_category AS fc
  ON c.category_id = fc.category_id
JOIN film AS f
  ON fc.film_id = f.film_id
GROUP BY c.category_id,
         c.name
HAVING AVG(f.length) > 110
ORDER BY avg_length DESC;

-- ---------------------------------------------------------
-- 22. Calculate total payment amount handled by staff
-- Goal: Measure total payment volume processed by each staff
--       member.
-- ---------------------------------------------------------
SELECT s.staff_id,
       s.first_name,
       s.last_name,
       SUM(p.amount) AS total_amount_handled
FROM staff AS s
JOIN payment AS p
  ON s.staff_id = p.staff_id
GROUP BY s.staff_id,
         s.first_name,
         s.last_name
ORDER BY total_amount_handled DESC;

-- ---------------------------------------------------------
-- 23. Count customers by store
-- Goal: Measure how many customers belong to each store.
-- ---------------------------------------------------------
SELECT s.store_id,
       COUNT(c.customer_id) AS number_of_customers
FROM store AS s
JOIN customer AS c
  ON s.store_id = c.store_id
GROUP BY s.store_id
ORDER BY s.store_id ASC;

-- ---------------------------------------------------------
-- 24. Count staff members by store
-- Goal: Measure how many staff members work in each store.
-- ---------------------------------------------------------
SELECT s.store_id,
       COUNT(st.staff_id) AS number_of_staff
FROM store AS s
JOIN staff AS st
  ON s.store_id = st.store_id
GROUP BY s.store_id
ORDER BY s.store_id ASC;

-- ---------------------------------------------------------
-- 25. Count films by language
-- Goal: Measure how many films are stored for each language.
-- ---------------------------------------------------------
SELECT l.language_id,
       l.name AS language_name,
       COUNT(f.film_id) AS number_of_films
FROM language AS l
JOIN film AS f
  ON l.language_id = f.language_id
GROUP BY l.language_id,
         l.name
ORDER BY number_of_films DESC;

-- ---------------------------------------------------------
-- 26. Count rentals by film rating
-- Goal: Measure rental volume across film rating groups.
-- ---------------------------------------------------------
SELECT f.rating,
       COUNT(r.rental_id) AS number_of_rentals
FROM film AS f
JOIN inventory AS i
  ON f.film_id = i.film_id
JOIN rental AS r
  ON i.inventory_id = r.inventory_id
GROUP BY f.rating
ORDER BY number_of_rentals DESC;

-- ---------------------------------------------------------
-- 27. Calculate revenue by film rating
-- Goal: Measure total revenue generated by films within each
--       rating group.
-- ---------------------------------------------------------
SELECT f.rating,
       SUM(p.amount) AS total_revenue
FROM film AS f
JOIN inventory AS i
  ON f.film_id = i.film_id
JOIN rental AS r
  ON i.inventory_id = r.inventory_id
JOIN payment AS p
  ON p.rental_id = r.rental_id
GROUP BY f.rating
ORDER BY total_revenue DESC;

-- ---------------------------------------------------------
-- 28. Calculate revenue by category
-- Goal: Measure total revenue generated by each film
--       category.
-- ---------------------------------------------------------
SELECT c.category_id,
       c.name AS category_name,
       SUM(p.amount) AS total_revenue
FROM category AS c
JOIN film_category AS fc
  ON c.category_id = fc.category_id
JOIN film AS f
  ON fc.film_id = f.film_id
JOIN inventory AS i
  ON f.film_id = i.film_id
JOIN rental AS r
  ON i.inventory_id = r.inventory_id
JOIN payment AS p
  ON r.rental_id = p.rental_id
GROUP BY c.category_id,
         c.name
ORDER BY total_revenue DESC;

-- ---------------------------------------------------------
-- 29. Return categories with total revenue above 1000
-- Goal: Filter grouped category revenue using HAVING.
-- ---------------------------------------------------------
SELECT c.category_id,
       c.name AS category_name,
       SUM(p.amount) AS total_revenue
FROM category AS c
JOIN film_category AS fc
  ON c.category_id = fc.category_id
JOIN film AS f
  ON fc.film_id = f.film_id
JOIN inventory AS i
  ON f.film_id = i.film_id
JOIN rental AS r
  ON i.inventory_id = r.inventory_id
JOIN payment AS p
  ON r.rental_id = p.rental_id
GROUP BY c.category_id,
         c.name
HAVING SUM(p.amount) > 1000
ORDER BY total_revenue DESC;

-- ---------------------------------------------------------
-- 30. Count distinct films rented by customer
-- Goal: Measure how many unique films each customer rented.
-- ---------------------------------------------------------
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       COUNT(DISTINCT f.film_id) AS number_of_distinct_films
FROM customer AS c
JOIN rental AS r
  ON c.customer_id = r.customer_id
JOIN inventory AS i
  ON r.inventory_id = i.inventory_id
JOIN film AS f
  ON i.film_id = f.film_id
GROUP BY c.customer_id,
         c.first_name,
         c.last_name
ORDER BY number_of_distinct_films DESC;

-- ---------------------------------------------------------
-- 31. Return customers who rented more than 30 distinct films
-- Goal: Filter grouped distinct film counts using HAVING.
-- ---------------------------------------------------------
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       COUNT(DISTINCT f.film_id) AS number_of_distinct_films
FROM customer AS c
JOIN rental AS r
  ON c.customer_id = r.customer_id
JOIN inventory AS i
  ON r.inventory_id = i.inventory_id
JOIN film AS f
  ON i.film_id = f.film_id
GROUP BY c.customer_id,
         c.first_name,
         c.last_name
HAVING COUNT(DISTINCT f.film_id) > 30
ORDER BY number_of_distinct_films DESC;

-- ---------------------------------------------------------
-- 32. Find first rental date by customer
-- Goal: Retrieve the first calendar date on which each
--       customer made a rental.
-- ---------------------------------------------------------
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       MIN(r.rental_date)::date AS first_rental_date
FROM customer AS c
JOIN rental AS r
  ON c.customer_id = r.customer_id
GROUP BY c.customer_id,
         c.first_name,
         c.last_name
ORDER BY first_rental_date ASC;

-- ---------------------------------------------------------
-- 33. Find most recent rental date by customer
-- Goal: Retrieve the latest calendar date on which each
--       customer made a rental.
-- ---------------------------------------------------------
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       MAX(r.rental_date)::date AS last_rental_date
FROM customer AS c
JOIN rental AS r
  ON c.customer_id = r.customer_id
GROUP BY c.customer_id,
         c.first_name,
         c.last_name
ORDER BY last_rental_date DESC;

-- ---------------------------------------------------------
-- 34. Calculate revenue by film
-- Goal: Measure total revenue generated by each film.
-- ---------------------------------------------------------
SELECT f.film_id,
       f.title,
       SUM(p.amount) AS total_revenue
FROM film AS f
JOIN inventory AS i
  ON f.film_id = i.film_id
JOIN rental AS r
  ON i.inventory_id = r.inventory_id
JOIN payment AS p
  ON r.rental_id = p.rental_id
GROUP BY f.film_id,
         f.title
ORDER BY total_revenue DESC;

-- ---------------------------------------------------------
-- 35. Return top 10 films by revenue
-- Goal: Rank films by total revenue and keep the top 10.
-- ---------------------------------------------------------
SELECT f.film_id,
       f.title,
       SUM(p.amount) AS total_revenue
FROM film AS f
JOIN inventory AS i
  ON f.film_id = i.film_id
JOIN rental AS r
  ON i.inventory_id = r.inventory_id
JOIN payment AS p
  ON r.rental_id = p.rental_id
GROUP BY f.film_id,
         f.title
ORDER BY total_revenue DESC
LIMIT 10;

-- ---------------------------------------------------------
-- 36. Calculate average payment amount by customer
-- Goal: Measure average payment value at the customer level.
-- ---------------------------------------------------------
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       AVG(p.amount) AS avg_payment
FROM customer AS c
JOIN payment AS p
  ON c.customer_id = p.customer_id
GROUP BY c.customer_id,
         c.first_name,
         c.last_name
ORDER BY avg_payment DESC;

-- ---------------------------------------------------------
-- 37. Return customers with average payment above 4.50
-- Goal: Filter grouped average payment values using HAVING.
-- ---------------------------------------------------------
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       AVG(p.amount) AS avg_payment
FROM customer AS c
JOIN payment AS p
  ON c.customer_id = p.customer_id
GROUP BY c.customer_id,
         c.first_name,
         c.last_name
HAVING AVG(p.amount) > 4.50
ORDER BY avg_payment DESC;

-- ---------------------------------------------------------
-- 38. Count distinct rented films by category
-- Goal: Measure how many unique films in each category were
--       rented at least once.
-- ---------------------------------------------------------
SELECT c.category_id,
       c.name AS category_name,
       COUNT(DISTINCT f.film_id) AS number_of_distinct_rented_films
FROM category AS c
JOIN film_category AS fc
  ON c.category_id = fc.category_id
JOIN film AS f
  ON fc.film_id = f.film_id
JOIN inventory AS i
  ON f.film_id = i.film_id
JOIN rental AS r
  ON i.inventory_id = r.inventory_id
GROUP BY c.category_id,
         c.name
ORDER BY number_of_distinct_rented_films DESC;

-- ---------------------------------------------------------
-- 39. Count distinct customers handled by staff
-- Goal: Measure how many unique customers each staff member
--       processed payments for.
-- ---------------------------------------------------------
SELECT s.staff_id,
       s.first_name,
       s.last_name,
       COUNT(DISTINCT p.customer_id) AS number_of_customers
FROM staff AS s
JOIN payment AS p
  ON s.staff_id = p.staff_id
GROUP BY s.staff_id,
         s.first_name,
         s.last_name
ORDER BY number_of_customers DESC,
         s.staff_id ASC;

-- ---------------------------------------------------------
-- 40. Calculate monthly revenue from payment_date
-- Goal: Aggregate revenue by calendar year and month.
-- ---------------------------------------------------------
SELECT EXTRACT(YEAR FROM p.payment_date) AS payment_year,
       EXTRACT(MONTH FROM p.payment_date) AS payment_month,
       SUM(p.amount) AS total_revenue
FROM payment AS p
GROUP BY EXTRACT(YEAR FROM p.payment_date),
         EXTRACT(MONTH FROM p.payment_date)
ORDER BY payment_year ASC,
         payment_month ASC;

-- ---------------------------------------------------------
-- 41. Count payments by calendar day
-- Goal: Measure the number of payments recorded on each day.
-- ---------------------------------------------------------
SELECT p.payment_date::date AS payment_day,
       COUNT(p.payment_id) AS number_of_payments
FROM payment AS p
GROUP BY p.payment_date::date
ORDER BY payment_day ASC;

-- ---------------------------------------------------------
-- 42. Return days with more than 100 payments
-- Goal: Filter grouped daily payment counts using HAVING.
-- ---------------------------------------------------------
SELECT p.payment_date::date AS payment_day,
       COUNT(p.payment_id) AS number_of_payments
FROM payment AS p
GROUP BY p.payment_date::date
HAVING COUNT(p.payment_id) > 100
ORDER BY payment_day ASC;
