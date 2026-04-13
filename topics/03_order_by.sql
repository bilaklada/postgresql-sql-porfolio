--Show: title, length from film. Sort films by length (longest first).
SELECT title, length
FROM film
ORDER BY length DESC;

--Show: title, rental_rate. Sort films by rental_rate (highest first).
SELECT title, rental_rate
FROM film
ORDER BY rental_rate DESC;

--Show 10 shortest films. Columns: title, length
SELECT title, length
FROM film
ORDER BY length
LIMIT 10;

--Show 5 most expensive rentals. Columns: title, rental_rate
SELECT title, rental_rate
FROM film
ORDER BY rental_rate DESC
LIMIT 5;

--Show films rated PG. Sort them by length (longest first). Columns: title, rating, length
SELECT title, rating, length
FROM film
WHERE rating = 'PG'
ORDER BY length DESC;

--Show 10 payments with the largest amount. Columns: payment_id, amount
SELECT payment_id, amount
FROM payment
ORDER BY amount DESC 
LIMIT 10;

--Show actors sorted alphabetically by last name. Columns: first_name, last_name. Return only 15 actors.
SELECT first_name, last_name
FROM actor
ORDER BY last_name
LIMIT 15;

--Show films where: rating = 'PG' Sort by: rental_rate (highest first). Return 10 rows. Columns: title, rating, rental_rate
SELECT title, rating, rental_rate
FROM film
WHERE rating = 'PG'
ORDER BY rental_rate DESC
LIMIT 10;

--Show films sorted by: rating and then by length (longest first). Columns: title, rating, length. Return 20 rows.
SELECT title, rating, length
FROM film
ORDER BY rating, length DESC 
LIMIT 20;