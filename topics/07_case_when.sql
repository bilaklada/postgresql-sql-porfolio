-- CASE WHEN PRACTICE
-- Use dvdrental
-- Write your query under each task

-- 1) Show each film title, length, and a new column called length_group:
--    'short' if length < 60
--    'medium' if length is between 60 and 120
--    'long' if length > 120
-- Show: title, length, length_group
SELECT title, length,
CASE
	WHEN length < 60 THEN 'short'
	WHEN length <= 120 THEN 'medium'
	ELSE 'long'
END AS length_group
FROM film;


-- 2) Show each film title, rental_rate, and a new column called price_group:
--    'cheap' if rental_rate = 0.99
--    'standard' if rental_rate = 2.99
--    'premium' if rental_rate = 4.99
-- Show: title, rental_rate, price_group
SELECT title, rental_rate,
CASE
	WHEN rental_rate = 0.99 THEN 'cheap'
	WHEN rental_rate = 2.99 THEN 'standard'
	WHEN rental_rate = 4.99 THEN 'premium'
	ELSE 'other'
END AS price_group
FROM film;


-- 3) Show each customer first_name, last_name, activebool, and a new column called customer_status:
--    'active' for true
--    'inactive' for false
-- Show: first_name, last_name, activebool, customer_status
SELECT first_name, last_name, activebool,
CASE 
	WHEN activebool = TRUE THEN 'active'
	ELSE 'inactive'
END AS customer_status
FROM customer;


-- 4) Show each payment_id, amount, and a new column called payment_level:
--    'low' if amount < 3
--    'medium' if amount is between 3 and 7
--    'high' if amount > 7
-- Show: payment_id, amount, payment_level
-- Order by amount descending
SELECT payment_id, amount,
CASE 
	WHEN amount < 3 THEN 'low'
	WHEN amount <= 7 THEN 'medium'
	ELSE 'high'
END AS payment_level
FROM payment
ORDER BY amount DESC;



-- 5) Show each film title, rating, and a new column called audience_group:
--    'family' for G and PG
--    'teen' for PG-13
--    'adult' for R and NC-17
-- Show: title, rating, audience_group
SELECT title, rating,
CASE
	WHEN rating = 'G' OR rating = 'PG' THEN 'family'
	WHEN rating = 'PG-13' THEN 'teen'
	WHEN rating = 'R' OR rating = 'NC-17' THEN 'adult'
	ELSE 'other'
END AS audience_group
FROM film;


-- 6) Show each film title, replacement_cost, and a new column called replacement_cost_group:
--    'low' if replacement_cost < 15
--    'medium' if replacement_cost is between 15 and 20
--    'high' if replacement_cost > 20
-- Show: title, replacement_cost, replacement_cost_group
SELECT title, replacement_cost,
CASE 
	WHEN replacement_cost < 15 THEN 'low'
	WHEN replacement_cost <= 20 THEN 'medium'
	ELSE 'high'
END AS replacement_cost_group
FROM film;

-- 7) Show each payment_id, amount, and a new column called payment_flag:
--    'big_payment' if amount > 5
--    otherwise 'normal_payment'
-- Show: payment_id, amount, payment_flag
SELECT payment_id, amount,
CASE 
	WHEN amount > 5 THEN 'big_payment'
	ELSE 'normal_payment'
END AS payment_flag
FROM payment;

-- 8) Show each film title, length, rental_rate, and a new column called film_type:
--    'short_cheap' if length < 60 and rental_rate = 0.99
--    'long_expensive' if length > 120 and rental_rate = 4.99
--    otherwise 'other'
-- Show: title, length, rental_rate, film_type
SELECT title, length, rental_rate, 
CASE
	WHEN length < 60 AND rental_rate = 0.99 THEN 'short_cheap'
	WHEN length > 120 AND rental_rate = 4.99 THEN 'long_expensive'
	ELSE 'other'
END AS film_type
FROM film;

-- 9) Show each customer_id and total amount paid.
-- Also show a new column called customer_segment:
--    'VIP' if total amount paid > 200
--    otherwise 'regular'
-- Show: customer_id, total_paid, customer_segment
SELECT customer_id, sum(amount) AS total_paid,
CASE
	WHEN sum(amount) > 200 THEN 'VIP'
	ELSE 'regular'
END AS customer_segment
FROM payment
GROUP BY customer_id;

-- 10) Show each customer_id and number of payments made.
-- Also show a new column called payment_activity:
--    'frequent' if number of payments > 30
--    otherwise 'not_frequent'
-- Tables: payment
-- Show: customer_id, number_of_payments, payment_activity
SELECT customer_id, count(payment_id) AS number_of_payments, 
CASE 
	WHEN count(payment_id) > 30 THEN 'frequent'
	ELSE 'not_frequent'
END AS payment_activity
FROM payment
GROUP BY customer_id
ORDER BY customer_id;

-- 11) Show each rating and average film length.
-- Also show a new column called rating_length_group:
--    'long_avg' if average length > 110
--    otherwise 'normal_avg'
-- Table: film
-- Show: rating, avg_length, rating_length_group
SELECT rating, avg(length) AS avg_length,
CASE 
	WHEN avg(length) > 110 THEN 'long_avg'
	ELSE 'normal_avg'
END AS rating_length_group
FROM film
GROUP BY rating;


-- 12) Show each customer_id and total amount paid,
-- but return only customers whose total amount paid is greater than 180.
-- Also show:
--    'VIP' if total amount paid > 200
--    otherwise 'regular'
-- Table: payment
-- Show: customer_id, total_paid, customer_segment
SELECT customer_id, sum(amount) AS total_paid,
CASE 
	WHEN sum(amount) > 200 THEN 'VIP'
	ELSE 'regular'
END AS customer_segment
FROM payment
GROUP BY customer_id
HAVING sum(amount) > 180;

-- 13) Show each category name and number of films in that category.
-- Also show a new column called category_size:
--    'large' if number_of_films > 70
--    otherwise 'small'
-- Show: category_name, number_of_films, category_size
SELECT c.name, count(fc.film_id) AS number_of_films, 
CASE
	WHEN count(fc.film_id) > 70 THEN 'large'
	ELSE 'small'
END AS category_size
FROM category c 
JOIN film_category fc ON c.category_id = fc.category_id 
GROUP BY c.category_id, c.name;

-- 14) Show each staff member and total amount of payments they handled.
-- Also show:
--    'top_staff' if total amount handled > 33000
--    otherwise 'standard_staff'
-- Tables: staff, payment
-- Show: staff_id, first_name, last_name, total_amount_handled, staff_group
SELECT s.staff_id, s.first_name, s.last_name, sum(p.amount) AS total_amount_handled,
CASE
	WHEN sum(p.amount) > 33000 THEN 'top_staff'
	ELSE  'standard_staff'
END AS staff_group
FROM staff s
JOIN payment p ON s.staff_id  = p.staff_id 
GROUP BY s.staff_id, s.first_name, s.last_name;

-- 15) Show each film title and number of times it was rented.
-- Also show:
--    'popular' if number_of_rentals > 30
--    otherwise 'less_popular'
-- Show: title, number_of_rentals, popularity_group
-- Order by number_of_rentals descending
SELECT f.title, count(r.rental_id) AS number_of_rentals,
CASE 
	WHEN count(r.rental_id) > 30 THEN 'popular'
	ELSE 'less_popular'
END AS popularity_group
FROM film f
JOIN inventory i ON f.film_id = i.film_id 
JOIN rental r ON i.inventory_id = r.inventory_id 
GROUP BY f.film_id, f.title 
ORDER BY number_of_rentals DESC;

-- 16) Show each customer and the date of their first rental.
-- Also show a new column called first_rental_period:
--    'early' if the first rental date is before 2005-06-15
--    otherwise 'late'
-- Show: customer_id, first_name, last_name, first_rental_date, first_rental_period
SELECT c.customer_id, c.first_name, c.last_name, min(r.rental_date) AS first_rental_date,
CASE 
	WHEN min(r.rental_date) < date '2005-06-15' THEN 'early'
	ELSE 'late'
END AS first_rental_period
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id 
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY c.customer_id, c.first_name, c.last_name;

-- 17) Show each payment_id, payment_date, and a new column called payment_month_part:
--    'first_half' if payment day of month is 1 to 15
--    'second_half' if payment day of month is 16 to 31
-- Show: payment_id, payment_date, payment_month_part
SELECT payment_id, payment_date,
CASE 
	WHEN extract(DAY FROM payment_date) BETWEEN 1 AND 15 THEN 'first_half'
	WHEN extract(DAY FROM payment_date) BETWEEN 16 AND 31 THEN 'second_half'
	ELSE 'other'
END AS payment_month_part
FROM payment
ORDER BY payment_id ASC;

-- 18) Show each payment month and total revenue for that month.
-- Also show:
--    'strong_month' if total revenue > 10000
--    otherwise 'normal_month'
-- Show: payment_month, total_revenue, month_group
-- Group by month from payment_date
SELECT extract(MONTH FROM payment_date) AS payment_month, sum(amount) AS total_revenue,
CASE
	WHEN sum(amount) > 10000 THEN 'strong_month'
	ELSE 'normal_month'
END AS month_group 
FROM payment
GROUP BY extract(MONTH FROM payment_date)
ORDER BY payment_month;


-- 19) Show each customer and how many distinct films they rented.
-- Also show:
--    'broad_viewer' if number_of_distinct_films > 30
--    otherwise 'narrow_viewer'
-- Show: customer_id, first_name, last_name, number_of_distinct_films, viewer_type
-- Order by number_of_distinct_films descending
SELECT c.customer_id, c.first_name, c.last_name, count(DISTINCT f.film_id) AS number_of_distinct_films,
CASE 
	WHEN count(DISTINCT f.film_id) > 30 THEN 'broad_viewer'
	ELSE 'narrow_viewer'
END AS viewer_type
FROM customer c 
JOIN rental r ON c.customer_id  = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id 
JOIN film f ON i.film_id = f.film_id 
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY number_of_distinct_films DESC;

-- 20) Show each category and the average film rental_rate in that category.
-- Also show:
--    'premium_category' if average rental_rate > 2.5
--    otherwise 'standard_category'
-- Show: category_name, avg_rental_rate, category_type
SELECT c.name, avg(f.rental_rate) AS avg_rental_rate,
CASE 
	WHEN avg(f.rental_rate) > 2.5 THEN 'premium category'
	ELSE 'standard_category'
END AS category_type
FROM category c 
JOIN film_category fc ON c.category_id = fc.category_id 
JOIN film f ON fc.film_id = f.film_id 
GROUP BY c.name;

-- 21) Show each payment_id, amount, and a new column called amount_band:
--    'A' if amount >= 8
--    'B' if amount >= 5 and amount < 8
--    'C' if amount < 5
-- Show: payment_id, amount, amount_band
-- Order by amount descending
SELECT payment_id, amount,
CASE 
	WHEN amount >= 8 THEN 'A'
	WHEN amount >= 5 THEN 'B'
	ELSE 'C'
END AS amount_band
FROM payment
ORDER BY amount DESC;

-- 22) Show each film title, rating, length, and a new column called recommendation_group:
--    'kids_pick' for G films shorter than 90 minutes
--    'family_night' for PG films
--    'mature' for R and NC-17 films
--    otherwise 'general'
-- Show: title, rating, length, recommendation_group
SELECT title, rating, length, 
CASE 
	WHEN rating = 'G' AND length < 90 THEN 'kids_pick'
	WHEN rating = 'PG' THEN 'family_night'
	WHEN rating = 'R' OR rating = 'NC-17' THEN 'mature'
	ELSE 'general'
END AS recommendation_group
FROM film;

-- 23) Show each store_id and number of customers in that store.
-- Also show:
--    'bigger_store' if number_of_customers > 300
--    otherwise 'smaller_store'
-- Show: store_id, number_of_customers, store_group
SELECT store_id, count(customer_id) AS number_of_customers,
CASE 
	WHEN count(DISTINCT customer_id) > 300 THEN 'bigger_store'
	ELSE 'smaller_store'
END AS store_group
FROM customer
GROUP BY store_id;

-- 24) Show each language name and number of films in that language.
-- Also show:
--    'common_language' if number_of_films > 900
--    otherwise 'rare_language'
-- Show: language_name, number_of_films, language_group
SELECT l.name, count(f.film_id) AS number_of_films,
CASE 
	WHEN count(f.film_id) > 900 THEN 'common_language'
	ELSE 'rare_language'
END AS language_group
FROM "language" l 
JOIN film f ON l.language_id = f.language_id 
GROUP BY l.language_id, l.name;

-- 25) Show each customer_id and total amount paid.
-- Return only customers whose total amount paid is greater than 180.
-- Also show:
--    'VIP' if total_paid > 220
--    'strong' if total_paid is between 190 and 220
--    'regular' otherwise
-- Show: customer_id, total_paid, customer_segment
-- Order by total_paid descending
SELECT customer_id, sum(amount) AS total_paid,
CASE 
	WHEN sum(amount) > 220 THEN 'VIP'
	WHEN sum(amount) > 190 THEN 'strong'
	ELSE 'regular'
END AS customer_segment
FROM payment
GROUP BY customer_id
HAVING sum(amount) > 180
ORDER BY total_paid DESC;
