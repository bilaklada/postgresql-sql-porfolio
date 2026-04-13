-- Show all columns from the actor table, but only first 10 rows.
SELECT *
FROM actor
LIMIT 10;

-- Show only these columns from the film table: title, release_year, rental_rate. Return only 8 films.
SELECT title, release_year, rental_rate
FROM film
LIMIT 8;

-- Show all columns from the customer table, but only first 5 rows.
SELECT *
FROM customer
LIMIT 5;

-- How many films are in the database?
SELECT COUNT(*)
FROM film;

-- How many customers are in the database?
SELECT COUNT(*)
FROM customer;

-- How many rentals exist in the system?
SELECT COUNT(*)
FROM rental;

-- Show the first 10 rows from the payment table.
SELECT *
FROM payment
LIMIT 10;

-- From table film, show: title, length, rating. Return 15 rows.
SELECT title, length, rating
FROM film
LIMIT 15;
