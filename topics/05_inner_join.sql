-- show customer first name, last name, and payment amount (customer + payment), limit 10
SELECT c.first_name, c.last_name, p.amount
FROM customer c
JOIN payment p
ON c.customer_id = p.customer_id
LIMIT 10;

-- show film title and language name (film + language), limit 10
SELECT f.title, l.name
FROM film f
JOIN language l
ON f.language_id = l.language_id 
LIMIT 10;

-- show payment_id, amount, and rental_date (payment + rental), limit 10
SELECT p.payment_id, p.amount, r.rental_date
FROM payment p
JOIN rental r
ON p.rental_id = r.rental_id
LIMIT 10;

-- show customer first name, last name, payment_id, amount (customer + payment), order by amount desc, limit 10
SELECT c.first_name, c.last_name, p.payment_id, p.amount
FROM customer c
JOIN payment p
ON c.customer_id = p.customer_id 
ORDER BY p.amount DESC 
LIMIT 10;

-- show customer first name, last name, and total payment amount (customer + payment)
SELECT c.first_name, c.last_name, sum(p.amount) AS total_payment
FROM customer c
JOIN payment p 
ON c.customer_id = p.customer_id
GROUP BY c.first_name, c.last_name;

-- show film title and category name (film + film_category + category), limit 10
SELECT f.title, c.name
FROM film f 
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category c
ON fc.category_id = c.category_id 
LIMIT 10;

-- show actor first name, last name, and film title (actor + film_actor + film), limit 10
SELECT a.first_name, a.last_name, f.title
FROM actor a
JOIN film_actor fa
ON a.actor_id = fa.actor_id
JOIN film f
ON fa.film_id =f.film_id
LIMIT 10;

-- show customer first name, last name, and rental_date (customer + rental), limit 10
SELECT c.first_name, c.last_name, r.rental_date
FROM customer c
JOIN rental r
ON c.customer_id = r.customer_id
LIMIT 10;

-- show film title and number of times it was rented (film + inventory + rental)
SELECT f.title, count(r.*) AS num_of_times_rented
FROM film f
JOIN inventory i
ON f.film_id = i.film_id 
JOIN rental r
ON  i.inventory_id = r.inventory_id
GROUP BY f.title;

-- show customer first name, last name, and number of payments made (customer + payment)
SELECT c.first_name, c.last_name, count(p.*) AS num_of_payments_made
FROM customer c
JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY c.first_name, c.last_name;

-- show film title and language name, sorted by title alphabetically
SELECT f.title, l.name
FROM film f
JOIN "language" l 
ON f.language_id = l.language_id
ORDER BY f.title;

-- show payment_id, amount, and customer full name (customer + payment), order by amount desc, limit 5
SELECT p.payment_id, p.amount, c.first_name, c.last_name
FROM payment p
JOIN customer c
ON p.customer_id = c.customer_id
ORDER BY p.amount DESC
LIMIT 5;


-- JOIN + GROUP BY + HAVING PRACTICE 


-- 1) Show each customer's total amount paid.
-- Tables: customer, payment
-- Show: customer_id, first_name, last_name, total_paid
-- Sort by total_paid descending

SELECT c.customer_id, c.first_name, c.last_name, sum(p.amount) AS total_paid
FROM customer c 
JOIN payment p
ON c.customer_id = p.customer_id 
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_paid DESC;

-- 2) Show the top 10 customers who spent the most money.
-- Tables: customer, payment
-- Show: customer_id, first_name, last_name, total_paid
-- Sort by total_paid descending
-- Return 10 rows
SELECT c.customer_id, c.first_name, c.last_name, sum(p.amount) AS total_paid
FROM customer c 
JOIN payment p
ON c.customer_id = p.customer_id 
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_paid DESC
LIMIT 10;

-- 3) Show how many payments each customer made.
-- Tables: customer, payment
-- Show: customer_id, first_name, last_name, number_of_payments
-- Sort by number_of_payments descending
SELECT c.customer_id, c.first_name, c.last_name, count(p.payment_id) AS number_of_payments
FROM customer c 
JOIN payment p
ON c.customer_id = p.customer_id 
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY number_of_payments DESC;


-- 4) Show only customers who made more than 30 payments.
-- Tables: customer, payment
-- Show: customer_id, first_name, last_name, number_of_payments
-- Use HAVING
SELECT c.customer_id, c.first_name, c.last_name, count(p.payment_id) AS number_of_payments
FROM customer c 
JOIN payment p
ON c.customer_id = p.customer_id 
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING count(p.payment_id) > 30;


-- 5) Show each film and how many times it was rented.
-- Tables: film, inventory, rental
-- Show: film_id, title, number_of_rentals
-- Sort by number_of_rentals descending
SELECT f.film_id, f.title, count(r.rental_id) AS number_of_rentals
FROM film f 
JOIN inventory i
ON f.film_id = i.film_id 
JOIN rental r
ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY number_of_rentals DESC;


-- 6) Show the top 10 most rented films.
-- Tables: film, inventory, rental
-- Show: film_id, title, number_of_rentals
-- Sort by number_of_rentals descending
-- Return 10 rows
SELECT f.film_id, f.title, count(r.rental_id) AS number_of_rentals
FROM film f 
JOIN inventory i
ON f.film_id = i.film_id 
JOIN rental r
ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY number_of_rentals DESC
LIMIT 10;


-- 7) Show each category and how many films belong to it.
-- Tables: category, film_category
-- Show: category_id, category_name, number_of_films
-- Sort by number_of_films descending
SELECT c.category_id, c.name, count(fc.film_id) AS number_of_films
FROM category c
JOIN film_category fc
ON c.category_id = fc.category_id
GROUP BY c.category_id, c.name
ORDER BY number_of_films DESC;

-- 8) Show each category and the average film length in that category.
-- Tables: category, film_category, film
-- Show: category_id, category_name, avg_length
-- Sort by avg_length descending
SELECT c.category_id, c.name, avg(f.length) AS avg_length
FROM category c
JOIN film_category fc
ON c.category_id = fc.category_id 
JOIN film f
ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name
ORDER BY avg_length DESC;


-- 9) Show only categories where the average film length is greater than 110 minutes.
-- Tables: category, film_category, film
-- Show: category_id, category_name, avg_length
-- Use HAVING
SELECT c.category_id, c.name, avg(f.length) AS avg_length
FROM category c
JOIN film_category fc
ON c.category_id = fc.category_id
JOIN film f 
ON fc.film_id = f.film_id 
GROUP BY c.category_id, c.name
HAVING avg(f.length) > 110;


-- 10) Show each staff member and the total amount of payments they handled.
-- Tables: staff, payment
-- Show: staff_id, first_name, last_name, total_amount_handled
-- Sort by total_amount_handled descending
SELECT s.staff_id, s.first_name, s.last_name, sum(p.amount) AS total_amount_handled
FROM staff s 
JOIN payment p
ON s.staff_id = p.staff_id
GROUP BY s.staff_id, s.first_name, s.last_name
ORDER BY total_amount_handled DESC;


-- 11) Show each store and how many customers belong to it.
-- Tables: store, customer
-- Show: store_id, number_of_customers
SELECT s.store_id, count(c.customer_id) AS number_of_customers
FROM store s
JOIN customer c 
ON s.store_id = c.store_id 
GROUP BY s.store_id;


-- 12) Show each store and how many staff members work there.
-- Tables: store, staff
-- Show: store_id, number_of_staff
SELECT s1.store_id, count(s2.staff_id) AS number_of_staff
FROM store s1
JOIN staff s2
ON s1.store_id = s2.store_id 
GROUP BY s1.store_id;



-- 13) Show each language and how many films use that language.
-- Tables: language, film
-- Show: language_id, language_name, number_of_films
-- Sort by number_of_films descending
SELECT l.language_id, l.name AS language_name, count(f.film_id) AS number_of_films
FROM language l
JOIN film f
ON l.language_id = f.language_id 
GROUP BY l.language_id, l.name
ORDER BY number_of_films DESC;

-- 14) Show each rating and the total number of rentals of films with that rating.
-- Tables: film, inventory, rental
-- Show: rating, number_of_rentals
-- Sort by number_of_rentals descending
SELECT f.rating, count(r.rental_id) AS number_of_rentals
FROM film f
JOIN inventory i 
ON f.film_id = i.film_id 
JOIN rental r
ON i.inventory_id = r.inventory_id
GROUP BY f.rating 
ORDER BY number_of_rentals DESC;

-- 15) Show each rating and the total revenue generated by films with that rating.
-- Tables: film, inventory, rental, payment
-- Show: rating, total_revenue
-- Sort by total_revenue descending
SELECT f.rating, sum(p.amount) AS total_revenue
FROM film f
JOIN inventory i
ON f.film_id = i.inventory_id
JOIN rental r
ON r.inventory_id = i.inventory_id 
JOIN payment p
ON p.rental_id = r.rental_id 
GROUP BY f.rating 
ORDER BY total_revenue DESC;


-- 16) Show each category and the total revenue generated by that category.
-- Tables: category, film_category, film, inventory, rental, payment
-- Show: category_id, category_name, total_revenue
-- Sort by total_revenue descending
SELECT c.category_id, c.name, sum(p.amount) AS total_revenue
FROM category c
JOIN film_category fc
ON c.category_id = fc.category_id 
JOIN film f
ON fc.film_id = f.film_id 
JOIN inventory i 
ON f.film_id = i.film_id 
JOIN rental r
ON i.inventory_id  = r.inventory_id 
JOIN payment p
ON r.rental_id = p.rental_id 
GROUP BY c.category_id, c.name
ORDER BY total_revenue DESC;




-- 17) Show only categories whose total revenue is greater than 1000.
-- Tables: category, film_category, film, inventory, rental, payment
-- Show: category_id, category_name, total_revenue
-- Use HAVING
SELECT c.category_id, c.name, sum(p.amount) AS total_revenue
FROM category c 
JOIN film_category fc 
ON c.category_id = fc.category_id 
JOIN film f 
ON fc.film_id = f.film_id 
JOIN inventory i 
ON f.film_id = i.film_id 
JOIN rental r
ON i.inventory_id = r.inventory_id 
JOIN payment p 
ON r.rental_id = p.rental_id 
GROUP BY c.category_id, c.name
HAVING sum(p.amount) > 1000;



-- 18) Show each customer and how many distinct films they rented.
-- Tables: customer, rental, inventory, film
-- Show: customer_id, first_name, last_name, number_of_distinct_films
-- Sort by number_of_distinct_films descending
SELECT c.customer_id, c.first_name, c.last_name, count(DISTINCT f.film_id) AS number_of_distinct_films
FROM customer c 
JOIN rental r ON c.customer_id = r.customer_id 
JOIN inventory i ON r.inventory_id = i.inventory_id 
JOIN  film f ON i.film_id = f.film_id 
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY number_of_distinct_films DESC;



-- 19) Show only customers who rented more than 30 distinct films.
-- Tables: customer, rental, inventory, film
-- Show: customer_id, first_name, last_name, number_of_distinct_films
-- Use HAVING
SELECT c.customer_id, c.first_name, c.last_name, count(DISTINCT f.film_id) AS number_of_distinct_films
FROM customer c 
JOIN rental r ON c.customer_id = r.customer_id  
JOIN inventory i ON r.inventory_id  = i.inventory_id
JOIN film f ON i.film_id = f.film_id 
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING count(DISTINCT f.film_id) > 30;


-- 20) Show each customer and the date (only date without time) of their first rental.
-- Tables: customer, rental
-- Show: customer_id, first_name, last_name, first_rental_date
SELECT c.customer_id, c.first_name, c.last_name, min(r.rental_date)::date AS first_rental_date
FROM customer c 
JOIN rental r ON c.customer_id = r.customer_id 
GROUP BY c.customer_id, c.first_name, c.last_name;


-- 21) Show each customer and the date (only date) of their most recent rental.
-- Tables: customer, rental
-- Show: customer_id, first_name, last_name, last_rental_date
SELECT c.customer_id, c.first_name, c.last_name, max(r.rental_date)::date AS last_rental_date
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id 
GROUP BY c.customer_id, c.first_name, c.last_name;


-- 22) Show each film and the total revenue it generated.
-- Tables: film, inventory, rental, payment
-- Show: film_id, title, total_revenue
-- Sort by total_revenue descending
SELECT f.film_id, f.title, sum(p.amount) AS total_revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id 
JOIN rental r ON i.inventory_id = r.inventory_id 
JOIN payment p ON r.rental_id = p.rental_id 
GROUP BY f.film_id, f.title
ORDER BY total_revenue DESC;



-- 23) Show the top 10 films by total revenue.
-- Tables: film, inventory, rental, payment
-- Show: film_id, title, total_revenue
-- Sort by total_revenue descending
-- Return 10 rows
SELECT f.film_id, f.title, sum(p.amount) AS total_revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id 
JOIN rental r ON i.inventory_id = r.inventory_id 
JOIN payment p ON r.rental_id = p.rental_id 
GROUP BY f.film_id, f.title
ORDER BY total_revenue DESC
LIMIT 10;


-- 24) Show each customer and their average payment amount.
-- Tables: customer, payment
-- Show: customer_id, first_name, last_name, avg_payment
-- Sort by avg_payment descending
SELECT c.customer_id, c.first_name, c.last_name, avg(p.amount) AS avg_payment
FROM customer c 
JOIN payment p ON c.customer_id = p.customer_id 
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY avg_payment DESC;


-- 25) Show only customers whose average payment amount is greater than 4.50.
-- Tables: customer, payment
-- Show: customer_id, first_name, last_name, avg_payment
-- Use HAVING
SELECT c.customer_id, c.first_name, c.last_name, avg(p.amount) AS avg_payment
FROM customer c 
JOIN payment p ON c.customer_id = p.customer_id 
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING avg(p.amount) > 4.5
ORDER BY avg_payment;


-- 26) Show each category and how many distinct films in that category were actually rented at least once.
-- Tables: category, film_category, film, inventory, rental
-- Show: category_id, category_name, number_of_distinct_rented_films
-- Sort by number_of_distinct_rented_films descending
SELECT c.category_id, c.name, count(DISTINCT f.film_id) AS number_of_distinct_rented_films
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id 
JOIN film f ON fc.film_id = f.film_id 
JOIN inventory i ON f.film_id = i.film_id 
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.category_id, c.name
ORDER BY number_of_distinct_rented_films DESC;


-- 27) Show each staff member and how many distinct customers they handled payments for.
-- Tables: staff, payment
-- Show: staff_id, first_name, last_name, number_of_customers
-- Sort by number_of_customers descending
SELECT s.staff_id, s.first_name, s.last_name, count(DISTINCT p.customer_id) AS number_of_customers
FROM staff s 
JOIN payment p ON s.staff_id = p.staff_id 
GROUP BY s.staff_id, s.first_name, s.last_name
ORDER BY number_of_customers DESC, s.staff_id ASC;


-- 28) Show each year and month (from payment_date) and the total revenue for that month.
SELECT extract(YEAR FROM p.payment_date) AS payment_year, extract(MONTH FROM p.payment_date) AS payment_month, sum(p.amount) AS total_revenue
FROM payment p 
GROUP BY extract(YEAR FROM p.payment_date), extract(MONTH FROM p.payment_date)
ORDER BY payment_year, payment_month;


-- 29) Show each calendar day (from payment_date) and the number of payments made on that day.
-- Table: payment
-- Show: payment_day, number_of_payments
-- Sort by payment_day ascending
SELECT p.payment_date::date AS payment_day, count(p.payment_id) AS number_of_payments
FROM payment p
GROUP BY p.payment_date::date
ORDER BY payment_day;


-- 30) Show only days where more than 100 payments were made.
-- Table: payment
-- Show: payment_day, number_of_payments
-- Use HAVING
SELECT p.payment_date::date AS payment_day, count(p.payment_id) AS number_of_payments
FROM payment p
GROUP BY p.payment_date::date
HAVING count(p.payment_id) > 100
ORDER BY payment_day;