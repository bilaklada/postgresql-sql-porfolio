-- =========================================================
-- File: 04_group_by.sql
-- Database: PostgreSQL / dvdrental
-- Topic: GROUP BY
-- Purpose: Practice grouped aggregation using COUNT, SUM,
--          AVG, MIN, and MAX across single-column and
--          multi-column groupings, including filtering
--          grouped results with HAVING.
-- Author: Lada Bilak
-- =========================================================

-- =========================================================
-- Section 1: Foundational GROUP BY queries
-- =========================================================

-- ---------------------------------------------------------
-- 1. Count films by rating
-- Goal: Measure how many film records exist within each
--       rating category.
-- ---------------------------------------------------------
SELECT rating,
       COUNT(*) AS number_of_films
FROM film
GROUP BY rating;

-- ---------------------------------------------------------
-- 2. Count films by rental rate
-- Goal: Measure how many films exist for each rental rate.
-- ---------------------------------------------------------
SELECT rental_rate,
       COUNT(*) AS number_of_films
FROM film
GROUP BY rental_rate;

-- ---------------------------------------------------------
-- 3. Calculate average film length by rating
-- Goal: Measure the average runtime for each rating group.
-- ---------------------------------------------------------
SELECT rating,
       AVG(length) AS average_length
FROM film
GROUP BY rating;

-- ---------------------------------------------------------
-- 4. Calculate maximum film length by rating
-- Goal: Identify the longest film within each rating group.
-- ---------------------------------------------------------
SELECT rating,
       MAX(length) AS max_length
FROM film
GROUP BY rating;

-- ---------------------------------------------------------
-- 5. Calculate minimum film length by rating
-- Goal: Identify the shortest film within each rating group.
-- ---------------------------------------------------------
SELECT rating,
       MIN(length) AS min_length
FROM film
GROUP BY rating;

-- ---------------------------------------------------------
-- 6. Calculate total amount paid by each customer
-- Goal: Measure total payment volume at the customer level.
-- ---------------------------------------------------------
SELECT customer_id,
       SUM(amount) AS total_paid
FROM payment
GROUP BY customer_id;

-- ---------------------------------------------------------
-- 7. Calculate average payment amount by customer
-- Goal: Measure mean payment value for each customer and
--       sort output by customer identifier.
-- ---------------------------------------------------------
SELECT customer_id,
       AVG(amount) AS avg_payment
FROM payment
GROUP BY customer_id
ORDER BY customer_id ASC;

-- ---------------------------------------------------------
-- 8. Count films by rating and sort by group size
-- Goal: Rank rating categories by number of films from
--       largest to smallest.
-- ---------------------------------------------------------
SELECT rating,
       COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC;

-- ---------------------------------------------------------
-- 9. Identify customers with the largest total payments
-- Goal: Rank customers by cumulative payment amount and
--       return the top 10.
-- ---------------------------------------------------------
SELECT customer_id,
       SUM(amount) AS total_paid
FROM payment
GROUP BY customer_id
ORDER BY total_paid DESC
LIMIT 10;

-- =========================================================
-- Section 2: Extended GROUP BY practice
-- =========================================================

-- ---------------------------------------------------------
-- 10. Count customers by store
-- Goal: Measure customer distribution across stores.
-- ---------------------------------------------------------
SELECT store_id,
       COUNT(*) AS number_of_customers
FROM customer
GROUP BY store_id;

-- ---------------------------------------------------------
-- 11. Calculate average replacement cost by rating
-- Goal: Measure average replacement cost within each film
--       rating group.
-- ---------------------------------------------------------
SELECT rating,
       AVG(replacement_cost) AS avg_replacement_cost
FROM film
GROUP BY rating;

-- ---------------------------------------------------------
-- 12. Calculate total rental duration by rating
-- Goal: Measure the cumulative rental duration for films
--       within each rating group.
-- ---------------------------------------------------------
SELECT rating,
       SUM(rental_duration) AS total_rental_duration
FROM film
GROUP BY rating;

-- ---------------------------------------------------------
-- 13. Count films by exact length
-- Goal: Measure how many films exist for each runtime value
--       and rank the results by frequency.
-- ---------------------------------------------------------
SELECT length,
       COUNT(*) AS number_of_films
FROM film
GROUP BY length
ORDER BY number_of_films DESC;

-- ---------------------------------------------------------
-- 14. Calculate highest payment by customer
-- Goal: Identify the maximum single payment made by each
--       customer and rank results from highest to lowest.
-- ---------------------------------------------------------
SELECT customer_id,
       MAX(amount) AS highest_payment
FROM payment
GROUP BY customer_id
ORDER BY highest_payment DESC;

-- ---------------------------------------------------------
-- 15. Calculate lowest payment by customer
-- Goal: Identify the minimum single payment made by each
--       customer and sort by customer identifier.
-- ---------------------------------------------------------
SELECT customer_id,
       MIN(amount) AS lowest_payment
FROM payment
GROUP BY customer_id
ORDER BY customer_id ASC;

-- ---------------------------------------------------------
-- 16. Count payments by customer
-- Goal: Measure payment frequency at the customer level and
--       rank customers by number of payments.
-- ---------------------------------------------------------
SELECT customer_id,
       COUNT(*) AS number_of_payments
FROM payment
GROUP BY customer_id
ORDER BY number_of_payments DESC;

-- ---------------------------------------------------------
-- 17. Calculate total amount handled by each staff member
-- Goal: Measure the total payment volume processed by each
--       staff member.
-- ---------------------------------------------------------
SELECT staff_id,
       SUM(amount) AS total_amount_paid
FROM payment
GROUP BY staff_id;

-- ---------------------------------------------------------
-- 18. Calculate average payment handled by each staff member
-- Goal: Measure the average payment amount processed by each
--       staff member.
-- ---------------------------------------------------------
SELECT staff_id,
       AVG(amount) AS avg_payment_amount
FROM payment
GROUP BY staff_id;

-- ---------------------------------------------------------
-- 19. Count rentals processed by staff member
-- Goal: Measure rental transaction volume by staff member.
-- ---------------------------------------------------------
SELECT staff_id,
       COUNT(*) AS number_of_rentals
FROM rental
GROUP BY staff_id;

-- =========================================================
-- Section 3: Multi-column grouping
-- =========================================================

-- ---------------------------------------------------------
-- 20. Count films by rating and rental rate
-- Goal: Measure film counts at the intersection of rating
--       and rental rate.
-- ---------------------------------------------------------
SELECT rating,
       rental_rate,
       COUNT(*) AS number_of_films
FROM film
GROUP BY rating,
         rental_rate
ORDER BY rating ASC,
         rental_rate ASC;

-- ---------------------------------------------------------
-- 21. Calculate average film length by rating and rental rate
-- Goal: Measure average runtime for each combined rating and
--       rental rate group.
-- ---------------------------------------------------------
SELECT rating,
       rental_rate,
       AVG(length) AS avg_length
FROM film
GROUP BY rating,
         rental_rate;

-- ---------------------------------------------------------
-- 22. Count films by rating and language
-- Goal: Measure film counts across rating and language_id
--       combinations.
-- ---------------------------------------------------------
SELECT rating,
       language_id,
       COUNT(*) AS number_of_films
FROM film
GROUP BY rating,
         language_id;

-- ---------------------------------------------------------
-- 23. Calculate total payment amount by customer and staff
-- Goal: Measure payment totals for each customer-staff
--       combination.
-- ---------------------------------------------------------
SELECT customer_id,
       staff_id,
       SUM(amount) AS total_paid
FROM payment
GROUP BY customer_id,
         staff_id;

-- ---------------------------------------------------------
-- 24. Count customers by active status
-- Goal: Measure the number of active and inactive customers.
-- ---------------------------------------------------------
SELECT activebool,
       COUNT(*) AS number_of_customers
FROM customer
GROUP BY activebool;

-- ---------------------------------------------------------
-- 25. Calculate total payment amount by payment date
-- Goal: Aggregate payments at the calendar-date level.
-- ---------------------------------------------------------
SELECT payment_date::date AS payment_day,
       SUM(amount) AS total_amount
FROM payment
GROUP BY payment_date::date
ORDER BY payment_day ASC;

-- =========================================================
-- Section 4: WHERE before GROUP BY
-- =========================================================

-- ---------------------------------------------------------
-- 26. Calculate total paid by customers with ID below 10
-- Goal: Filter rows before aggregation and then compute
--       total payments per qualifying customer.
-- ---------------------------------------------------------
SELECT customer_id,
       SUM(amount) AS total_paid
FROM payment
WHERE customer_id < 10
GROUP BY customer_id;

-- ---------------------------------------------------------
-- 27. Count long films by rating
-- Goal: Filter films longer than 120 minutes before grouping
--       and count how many remain in each rating category.
-- ---------------------------------------------------------
SELECT rating,
       COUNT(*) AS number_of_films
FROM film
WHERE length > 120
GROUP BY rating;

-- ---------------------------------------------------------
-- 28. Calculate average payment by customer for payments
--     greater than 5.00
-- Goal: Filter high-value payments before computing customer-
--       level averages.
-- ---------------------------------------------------------
SELECT customer_id,
       AVG(amount) AS avg_payment
FROM payment
WHERE amount > 5
GROUP BY customer_id;

-- =========================================================
-- Section 5: HAVING after GROUP BY
-- =========================================================

-- ---------------------------------------------------------
-- 29. Return customers whose total payments exceed 200
-- Goal: Filter grouped customer totals using HAVING.
-- ---------------------------------------------------------
SELECT customer_id,
       SUM(amount) AS total_paid
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 200;

-- ---------------------------------------------------------
-- 30. Return customers with more than 30 payments
-- Goal: Filter grouped payment counts using HAVING.
-- ---------------------------------------------------------
SELECT customer_id,
       COUNT(*) AS number_of_payments
FROM payment
GROUP BY customer_id
HAVING COUNT(*) > 30;

-- ---------------------------------------------------------
-- 31. Return ratings with average film length above 110
-- Goal: Filter grouped average runtimes using HAVING.
-- ---------------------------------------------------------
SELECT rating,
       AVG(length) AS avg_length
FROM film
GROUP BY rating
HAVING AVG(length) > 110;

-- ---------------------------------------------------------
-- 32. Return rental rates with more than 300 films
-- Goal: Filter grouped film counts using HAVING.
-- ---------------------------------------------------------
SELECT rental_rate,
       COUNT(*) AS number_of_films
FROM film
GROUP BY rental_rate
HAVING COUNT(*) > 300;

-- ---------------------------------------------------------
-- 33. Return customer-staff combinations with total paid
--     greater than 50
-- Goal: Filter grouped payment totals for combined customer
--       and staff groupings.
-- ---------------------------------------------------------
SELECT customer_id,
       staff_id,
       SUM(amount) AS total_paid
FROM payment
GROUP BY customer_id,
         staff_id
HAVING SUM(amount) > 50;

-- =========================================================
-- Section 6: GROUP BY with ORDER BY and LIMIT
-- =========================================================

-- ---------------------------------------------------------
-- 34. Return the top 3 rating groups by film count
-- Goal: Rank rating groups by number of films and keep only
--       the largest three.
-- ---------------------------------------------------------
SELECT rating,
       COUNT(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC
LIMIT 3;

-- ---------------------------------------------------------
-- 35. Return the top 5 customers by average payment
-- Goal: Rank customers by average payment amount and keep
--       the top five results.
-- ---------------------------------------------------------
SELECT customer_id,
       AVG(amount) AS avg_payment
FROM payment
GROUP BY customer_id
ORDER BY avg_payment DESC
LIMIT 5;

-- =========================================================
-- Section 7: Combined aggregate analysis
-- =========================================================

-- ---------------------------------------------------------
-- 36. Calculate maximum and minimum film length by rating
-- Goal: Compare upper and lower runtime bounds within each
--       rating group.
-- ---------------------------------------------------------
SELECT rating,
       MAX(length) AS max_length,
       MIN(length) AS min_length
FROM film
GROUP BY rating;

-- ---------------------------------------------------------
-- 37. Calculate multiple payment aggregates by customer
-- Goal: Summarize total, average, minimum, and maximum
--       payment values at the customer level.
-- ---------------------------------------------------------
SELECT customer_id,
       SUM(amount) AS total_paid,
       AVG(amount) AS avg_payment,
       MIN(amount) AS min_payment,
       MAX(amount) AS max_payment
FROM payment
GROUP BY customer_id;

-- ---------------------------------------------------------
-- 38. Count films by rating and replacement cost
-- Goal: Measure film counts across rating and replacement
--       cost combinations and rank counts within rating.
-- ---------------------------------------------------------
SELECT rating,
       replacement_cost,
       COUNT(*) AS number_of_films
FROM film
GROUP BY rating,
         replacement_cost
ORDER BY rating ASC,
         number_of_films DESC;

-- ---------------------------------------------------------
-- 39. Identify the rating with the largest average runtime
-- Goal: Rank ratings by average film length and return the
--       highest one.
-- ---------------------------------------------------------
SELECT rating,
       AVG(length) AS avg_length
FROM film
GROUP BY rating
ORDER BY avg_length DESC
LIMIT 1;
