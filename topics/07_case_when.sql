-- =========================================================
-- File: 07_case_when.sql
-- Database: PostgreSQL / dvdrental
-- Topic: CASE WHEN
-- Purpose: Practice conditional logic for classification,
--          segmentation, derived business labels, and
--          conditional categorization in both row-level and
--          aggregated queries.
-- Author: Lada Bilak
-- =========================================================

-- =========================================================
-- Section 1: Row-level categorization
-- =========================================================

-- ---------------------------------------------------------
-- 1. Classify films by runtime
-- Goal: Derive a length_group label from film duration.
-- ---------------------------------------------------------
SELECT title,
       length,
       CASE
           WHEN length < 60 THEN 'short'
           WHEN length <= 120 THEN 'medium'
           ELSE 'long'
       END AS length_group
FROM film;

-- ---------------------------------------------------------
-- 2. Classify films by rental price tier
-- Goal: Derive a price_group label from rental_rate.
-- ---------------------------------------------------------
SELECT title,
       rental_rate,
       CASE
           WHEN rental_rate = 0.99 THEN 'cheap'
           WHEN rental_rate = 2.99 THEN 'standard'
           WHEN rental_rate = 4.99 THEN 'premium'
           ELSE 'other'
       END AS price_group
FROM film;

-- ---------------------------------------------------------
-- 3. Classify customers by active status
-- Goal: Convert boolean customer activity into a readable
--       business label.
-- ---------------------------------------------------------
SELECT first_name,
       last_name,
       activebool,
       CASE
           WHEN activebool = TRUE THEN 'active'
           ELSE 'inactive'
       END AS customer_status
FROM customer;

-- ---------------------------------------------------------
-- 4. Classify payments by amount level
-- Goal: Derive a payment_level label from payment amount.
-- ---------------------------------------------------------
SELECT payment_id,
       amount,
       CASE
           WHEN amount < 3 THEN 'low'
           WHEN amount <= 7 THEN 'medium'
           ELSE 'high'
       END AS payment_level
FROM payment
ORDER BY amount DESC;

-- ---------------------------------------------------------
-- 5. Classify films by target audience group
-- Goal: Map MPAA ratings into broader audience categories.
-- ---------------------------------------------------------
SELECT title,
       rating,
       CASE
           WHEN rating IN ('G', 'PG') THEN 'family'
           WHEN rating = 'PG-13' THEN 'teen'
           WHEN rating IN ('R', 'NC-17') THEN 'adult'
           ELSE 'other'
       END AS audience_group
FROM film;

-- ---------------------------------------------------------
-- 6. Classify films by replacement cost tier
-- Goal: Derive a replacement_cost_group label.
-- ---------------------------------------------------------
SELECT title,
       replacement_cost,
       CASE
           WHEN replacement_cost < 15 THEN 'low'
           WHEN replacement_cost <= 20 THEN 'medium'
           ELSE 'high'
       END AS replacement_cost_group
FROM film;

-- ---------------------------------------------------------
-- 7. Flag high-value payments
-- Goal: Mark payments above 5 as big payments.
-- ---------------------------------------------------------
SELECT payment_id,
       amount,
       CASE
           WHEN amount > 5 THEN 'big_payment'
           ELSE 'normal_payment'
       END AS payment_flag
FROM payment;

-- ---------------------------------------------------------
-- 8. Classify films by combined duration and pricing logic
-- Goal: Derive a film_type label using multiple conditions.
-- ---------------------------------------------------------
SELECT title,
       length,
       rental_rate,
       CASE
           WHEN length < 60 AND rental_rate = 0.99 THEN 'short_cheap'
           WHEN length > 120 AND rental_rate = 4.99 THEN 'long_expensive'
           ELSE 'other'
       END AS film_type
FROM film;

-- =========================================================
-- Section 2: CASE WHEN with grouped aggregations
-- =========================================================

-- ---------------------------------------------------------
-- 9. Segment customers by total payment amount
-- Goal: Classify customers as VIP or regular based on total
--       spending.
-- ---------------------------------------------------------
SELECT customer_id,
       SUM(amount) AS total_paid,
       CASE
           WHEN SUM(amount) > 200 THEN 'VIP'
           ELSE 'regular'
       END AS customer_segment
FROM payment
GROUP BY customer_id
ORDER BY total_paid DESC;

-- ---------------------------------------------------------
-- 10. Classify customers by payment frequency
-- Goal: Label customers based on number of payments made.
-- ---------------------------------------------------------
SELECT customer_id,
       COUNT(payment_id) AS number_of_payments,
       CASE
           WHEN COUNT(payment_id) > 30 THEN 'frequent'
           ELSE 'not_frequent'
       END AS payment_activity
FROM payment
GROUP BY customer_id
ORDER BY customer_id ASC;

-- ---------------------------------------------------------
-- 11. Classify ratings by average film length
-- Goal: Label rating groups according to average runtime.
-- ---------------------------------------------------------
SELECT rating,
       AVG(length) AS avg_length,
       CASE
           WHEN AVG(length) > 110 THEN 'long_avg'
           ELSE 'normal_avg'
       END AS rating_length_group
FROM film
GROUP BY rating;

-- ---------------------------------------------------------
-- 12. Segment higher-value customers after HAVING filter
-- Goal: Return only customers with total spending above 180
--       and classify them by spending segment.
-- ---------------------------------------------------------
SELECT customer_id,
       SUM(amount) AS total_paid,
       CASE
           WHEN SUM(amount) > 200 THEN 'VIP'
           ELSE 'regular'
       END AS customer_segment
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 180
ORDER BY total_paid DESC;

-- ---------------------------------------------------------
-- 13. Classify categories by film count
-- Goal: Label categories as large or small based on number
--       of films assigned to them.
-- ---------------------------------------------------------
SELECT c.name AS category_name,
       COUNT(fc.film_id) AS number_of_films,
       CASE
           WHEN COUNT(fc.film_id) > 70 THEN 'large'
           ELSE 'small'
       END AS category_size
FROM category AS c
JOIN film_category AS fc
  ON c.category_id = fc.category_id
GROUP BY c.category_id,
         c.name
ORDER BY number_of_films DESC;

-- ---------------------------------------------------------
-- 14. Classify staff by handled payment volume
-- Goal: Label staff members by total payment amount handled.
-- ---------------------------------------------------------
SELECT s.staff_id,
       s.first_name,
       s.last_name,
       SUM(p.amount) AS total_amount_handled,
       CASE
           WHEN SUM(p.amount) > 33000 THEN 'top_staff'
           ELSE 'standard_staff'
       END AS staff_group
FROM staff AS s
JOIN payment AS p
  ON s.staff_id = p.staff_id
GROUP BY s.staff_id,
         s.first_name,
         s.last_name
ORDER BY total_amount_handled DESC;

-- ---------------------------------------------------------
-- 15. Classify films by rental popularity
-- Goal: Label films as popular or less_popular according to
--       rental count.
-- ---------------------------------------------------------
SELECT f.title,
       COUNT(r.rental_id) AS number_of_rentals,
       CASE
           WHEN COUNT(r.rental_id) > 30 THEN 'popular'
           ELSE 'less_popular'
       END AS popularity_group
FROM film AS f
JOIN inventory AS i
  ON f.film_id = i.film_id
JOIN rental AS r
  ON i.inventory_id = r.inventory_id
GROUP BY f.film_id,
         f.title
ORDER BY number_of_rentals DESC;

-- =========================================================
-- Section 3: CASE WHEN with date and time logic
-- =========================================================

-- ---------------------------------------------------------
-- 16. Classify customers by first rental period
-- Goal: Label customers based on whether their first rental
--       occurred before or after 2005-06-15.
-- ---------------------------------------------------------
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       MIN(r.rental_date)::date AS first_rental_date,
       CASE
           WHEN MIN(r.rental_date)::date < DATE '2005-06-15' THEN 'early'
           ELSE 'late'
       END AS first_rental_period
FROM customer AS c
JOIN rental AS r
  ON c.customer_id = r.customer_id
GROUP BY c.customer_id,
         c.first_name,
         c.last_name
ORDER BY c.customer_id ASC;

-- ---------------------------------------------------------
-- 17. Split payments into first-half and second-half
--     of the month
-- Goal: Derive a month-part classification from payment day.
-- ---------------------------------------------------------
SELECT payment_id,
       payment_date,
       CASE
           WHEN EXTRACT(DAY FROM payment_date) BETWEEN 1 AND 15 THEN 'first_half'
           WHEN EXTRACT(DAY FROM payment_date) BETWEEN 16 AND 31 THEN 'second_half'
           ELSE 'other'
       END AS payment_month_part
FROM payment
ORDER BY payment_id ASC;

-- ---------------------------------------------------------
-- 18. Classify months by total revenue strength
-- Goal: Aggregate monthly revenue and label stronger months.
-- ---------------------------------------------------------
SELECT EXTRACT(MONTH FROM payment_date) AS payment_month,
       SUM(amount) AS total_revenue,
       CASE
           WHEN SUM(amount) > 10000 THEN 'strong_month'
           ELSE 'normal_month'
       END AS month_group
FROM payment
GROUP BY EXTRACT(MONTH FROM payment_date)
ORDER BY payment_month ASC;

-- =========================================================
-- Section 4: Customer, category, and store segmentation
-- =========================================================

-- ---------------------------------------------------------
-- 19. Classify customers by breadth of viewing
-- Goal: Label customers based on how many distinct films
--       they rented.
-- ---------------------------------------------------------
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       COUNT(DISTINCT f.film_id) AS number_of_distinct_films,
       CASE
           WHEN COUNT(DISTINCT f.film_id) > 30 THEN 'broad_viewer'
           ELSE 'narrow_viewer'
       END AS viewer_type
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
-- 20. Classify categories by average rental rate
-- Goal: Label categories according to their average film
--       rental price.
-- ---------------------------------------------------------
SELECT c.name AS category_name,
       AVG(f.rental_rate) AS avg_rental_rate,
       CASE
           WHEN AVG(f.rental_rate) > 2.5 THEN 'premium_category'
           ELSE 'standard_category'
       END AS category_type
FROM category AS c
JOIN film_category AS fc
  ON c.category_id = fc.category_id
JOIN film AS f
  ON fc.film_id = f.film_id
GROUP BY c.category_id,
         c.name
ORDER BY avg_rental_rate DESC;

-- ---------------------------------------------------------
-- 21. Assign payment amount bands
-- Goal: Classify payments into A, B, and C value bands.
-- ---------------------------------------------------------
SELECT payment_id,
       amount,
       CASE
           WHEN amount >= 8 THEN 'A'
           WHEN amount >= 5 THEN 'B'
           ELSE 'C'
       END AS amount_band
FROM payment
ORDER BY amount DESC;

-- ---------------------------------------------------------
-- 22. Classify films into recommendation groups
-- Goal: Derive recommendation labels from rating and length.
-- ---------------------------------------------------------
SELECT title,
       rating,
       length,
       CASE
           WHEN rating = 'G' AND length < 90 THEN 'kids_pick'
           WHEN rating = 'PG' THEN 'family_night'
           WHEN rating IN ('R', 'NC-17') THEN 'mature'
           ELSE 'general'
       END AS recommendation_group
FROM film;

-- ---------------------------------------------------------
-- 23. Classify stores by customer volume
-- Goal: Label stores based on customer count.
-- ---------------------------------------------------------
SELECT store_id,
       COUNT(customer_id) AS number_of_customers,
       CASE
           WHEN COUNT(customer_id) > 300 THEN 'bigger_store'
           ELSE 'smaller_store'
       END AS store_group
FROM customer
GROUP BY store_id
ORDER BY store_id ASC;

-- ---------------------------------------------------------
-- 24. Classify languages by film count
-- Goal: Label languages according to the number of films
--       associated with them.
-- ---------------------------------------------------------
SELECT l.name AS language_name,
       COUNT(f.film_id) AS number_of_films,
       CASE
           WHEN COUNT(f.film_id) > 900 THEN 'common_language'
           ELSE 'rare_language'
       END AS language_group
FROM language AS l
JOIN film AS f
  ON l.language_id = f.language_id
GROUP BY l.language_id,
         l.name
ORDER BY number_of_films DESC;

-- ---------------------------------------------------------
-- 25. Segment higher-value customers into three tiers
-- Goal: Return customers with total spending above 180 and
--       classify them as VIP, strong, or regular.
-- ---------------------------------------------------------
SELECT customer_id,
       SUM(amount) AS total_paid,
       CASE
           WHEN SUM(amount) > 220 THEN 'VIP'
           WHEN SUM(amount) > 190 THEN 'strong'
           ELSE 'regular'
       END AS customer_segment
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 180
ORDER BY total_paid DESC;
