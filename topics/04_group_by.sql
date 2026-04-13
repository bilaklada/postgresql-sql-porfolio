-- count how many films exist for each rating. Show: rating, number_of_films
SELECT rating, count(*) AS number_of_films
FROM film
GROUP BY rating;


-- Count how many films exist for each rental_rate. Show: rental_rate, number_of_films
SELECT rental_rate, count(*) AS number_of_films
FROM film
GROUP BY rental_rate;

-- Find the average film length for each rating. Show: rating, average_length
SELECT rating, avg(length) AS average_length
FROM film
GROUP BY rating;

-- Find the longest film length for each rating. Show: rating, max_length
SELECT rating, max(length) AS max_length
FROM film
GROUP BY rating;

-- Find the shortest film for each rating. Show:rating, min_length
SELECT rating, min(length) AS min_length
FROM film
GROUP BY rating;

-- Find the total amount of money collected for each customer. Table: payment. Show: customer_id, total_paid
SELECT customer_id, sum(amount) AS total_paid
FROM payment
GROUP BY customer_id;

-- Find the average payment amount for each customer. Show: customer_id, avg_payment. Show in asc order
SELECT customer_id, avg(amount) AS avg_payment
FROM payment
GROUP BY customer_id
ORDER BY customer_id;

-- Show: rating, number_of_films. Sort ratings by number_of_films (largest first).
SELECT rating, count(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY count(*) DESC;

-- Which customers made the largest total payments? Show: customer_id, total_paid. Sort by largest total first. Return 10 rows.
SELECT customer_id, sum(amount) AS total_paid
FROM payment
GROUP BY customer_id
ORDER BY sum(amount) DESC
LIMIT 10;


-- GROUP BY PRACTICE — LEVEL 2


-- 1) Count how many customers belong to each store.
-- Table: customer
-- Show: store_id, number_of_customers
SELECT store_id, count(*) AS number_of_customers
FROM customer
GROUP BY store_id;



-- 2) Find the average replacement cost for each rating.
-- Table: film
-- Show: rating, avg_replacement_cost
SELECT rating, avg(replacement_cost) AS avg_replacement_cost
FROM film
GROUP BY rating;


-- 3) Find the total rental duration for each rating.
-- Table: film
-- Show: rating, total_rental_duration
SELECT rating, sum(rental_duration) AS total_rental_duration
FROM film
GROUP BY rating;


-- 4) Count how many films there are for each length.
-- Table: film
-- Show: length, number_of_films
-- Sort by number_of_films descending
SELECT length, count(*) AS number_of_films
FROM film
GROUP BY length 
ORDER BY number_of_films DESC;


-- 5) Find the highest payment made by each customer.
-- Table: payment
-- Show: customer_id, highest_payment
-- Sort by highest_payment descending
SELECT customer_id, max(amount) AS  highest_payment
FROM payment
GROUP BY customer_id
ORDER BY highest_payment DESC;


-- 6) Find the lowest payment made by each customer.
-- Table: payment
-- Show: customer_id, lowest_payment
-- Sort by customer_id ascending
SELECT customer_id, min(amount) AS  lowest_payment
FROM payment
GROUP BY customer_id
ORDER BY customer_id ASC;


-- 7) Count how many payments were made by each customer.
-- Table: payment
-- Show: customer_id, number_of_payments
-- Sort by number_of_payments descending
SELECT customer_id, count(*) AS number_of_payments
FROM payment
GROUP BY customer_id
ORDER BY number_of_payments DESC;


-- 8) Find the total amount paid by each staff member.
-- Table: payment
-- Show: staff_id, total_amount_paid
SELECT staff_id, sum(amount) AS total_amount_paid
FROM payment
GROUP BY staff_id;


-- 9) Find the average payment amount handled by each staff member.
-- Table: payment
-- Show: staff_id, avg_payment_amount
SELECT staff_id, avg(amount) AS avg_payment_amount
FROM payment
GROUP BY staff_id;



-- 10) Count how many rentals were processed by each staff member.
-- Table: rental
-- Show: staff_id, number_of_rentals
SELECT staff_id, count(*) AS number_of_rentals
FROM rental
GROUP BY staff_id;


-- 11) Count how many films belong to each rating and rental_rate combination.
-- Table: film
-- Show: rating, rental_rate, number_of_films
-- Sort by rating, then rental_rate
SELECT rating, rental_rate, count(*) AS number_of_films
FROM film 
GROUP BY rating, rental_rate
ORDER BY rating, rental_rate;


-- 12) Find the average film length for each rating and rental_rate combination.
-- Table: film
-- Show: rating, rental_rate, avg_length
SELECT rating, rental_rate, avg(length) AS avg_length
FROM film
GROUP BY rating, rental_rate;


-- 13) Count how many films belong to each rating and language_id combination.
-- Table: film
-- Show: rating, language_id, number_of_films
SELECT rating, language_id, count(*) AS number_of_films
FROM film
GROUP BY rating, language_id;



-- 14) Find the total payment amount for each customer and staff combination.
-- Table: payment
-- Show: customer_id, staff_id, total_paid
SELECT customer_id, staff_id, sum(amount) AS total_paid
FROM payment
GROUP BY customer_id, staff_id;



-- 15) Count how many customers are active and inactive.
-- Table: customer
-- Show: activebool, number_of_customers
SELECT activebool, count(*) AS number_of_customers
FROM customer
GROUP BY activebool;


-- 16) Find the total amount paid on each payment date.
-- Table: payment
-- Show: payment_date, total_amount
-- Sort by payment_date ascending
SELECT payment_date::date, sum(amount) AS total_amount
FROM payment
GROUP BY payment_date::date 
ORDER BY payment_date::date ASC;


-- 17) Find the total amount paid by each customer, but only for customers with customer_id less than 10.
-- Table: payment
-- Show: customer_id, total_paid
SELECT customer_id, sum(amount) AS total_paid
FROM payment
WHERE customer_id <10
GROUP BY customer_id;


-- 18) Count how many films there are in each rating, but only for films longer than 120 minutes.
-- Table: film
-- Show: rating, number_of_films
SELECT rating, count(*) AS number_of_films
FROM film
WHERE length > 120
GROUP BY rating;



-- 19) Find the average payment amount for each customer, but only for payments greater than 5.00.
-- Table: payment
-- Show: customer_id, avg_payment
SELECT customer_id, avg(amount) AS avg_payment
FROM payment
WHERE amount > 5
GROUP BY customer_id;


-- 20) Find the total payment amount for each customer.
-- Table: payment
-- Show: customer_id, total_paid
-- Return only customers whose total_paid is greater than 200
SELECT customer_id, sum(amount) AS total_paid
FROM payment
GROUP BY customer_id
HAVING sum(amount) > 200;




-- 21) Count how many payments each customer made.
-- Table: payment
-- Show: customer_id, number_of_payments
-- Return only customers who made more than 30 payments

SELECT customer_id, count(*) AS number_of_payments
FROM payment
GROUP BY customer_id
HAVING count(*) > 30;

-- 22) Find the average film length for each rating.
-- Table: film
-- Show: rating, avg_length
-- Return only ratings where avg_length is greater than 110
SELECT rating, avg(length) AS avg_length
FROM film
GROUP BY rating 
HAVING avg(length) > 110;


-- 23) Count how many films exist for each rental_rate.
-- Table: film
-- Show: rental_rate, number_of_films
-- Return only rental_rate groups with more than 300 films
SELECT rental_rate, count(*) AS number_of_films
FROM film
GROUP BY rental_rate
HAVING count(*) > 300;


-- 24) Find the total amount paid by each customer and each staff member.
-- Table: payment
-- Show: customer_id, staff_id, total_paid
-- Return only combinations where total_paid is greater than 50
SELECT customer_id, staff_id, sum(amount) AS total_paid
FROM payment
GROUP BY customer_id, staff_id
HAVING sum(amount) >50;


-- 25) Count how many films exist for each rating.
-- Table: film
-- Show: rating, number_of_films
-- Sort by number_of_films descending
-- Return only the top 3 groups
SELECT rating, count(*) AS number_of_films
FROM film
GROUP BY rating
ORDER BY count(*) DESC
LIMIT 3;


-- 26) Find the average payment amount for each customer.
-- Table: payment
-- Show: customer_id, avg_payment
-- Sort by avg_payment descending
-- Return only 5 rows
SELECT customer_id, avg(amount) AS avg_payment
FROM payment
GROUP BY customer_id
ORDER BY avg_payment DESC
LIMIT 5;



-- 27) Find the maximum and minimum film length for each rating.
-- Table: film
-- Show: rating, max_length, min_length
SELECT rating, max(length) AS max_length, min(length) AS min_length
FROM film
GROUP BY rating;



-- 28) Find the total, average, minimum, and maximum payment amount for each customer.
-- Table: payment
-- Show: customer_id, total_paid, avg_payment, min_payment, max_payment
SELECT customer_id, sum(amount) AS total_paid, avg(amount) AS avg_payment, min(amount) AS min_payment, max(amount) AS max_payment
FROM payment
GROUP BY customer_id;



-- 29) Count how many films exist for each rating and replacement_cost combination.
-- Table: film
-- Show: rating, replacement_cost, number_of_films
-- Sort by rating, then number_of_films descending
SELECT rating, replacement_cost, count(*) AS number_of_films
FROM film
GROUP BY rating, replacement_cost
ORDER BY rating, number_of_films DESC;


-- 30) Find which rating has the largest average film length.
-- Table: film
-- Show: rating, avg_length
-- Sort properly and return 1 row
SELECT rating, avg(length) AS avg_length
FROM film
GROUP BY rating
ORDER BY avg(length) DESC
LIMIT 1;