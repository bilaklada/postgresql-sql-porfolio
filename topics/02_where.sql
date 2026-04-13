--Show all films that have rating PG. Columns you may want to see: title, rating
SELECT title, rating
FROM film 
WHERE rating = 'PG';


--Show films that have rental_rate greater than 4. Show: title, rental_rate
SELECT title, rental_rate 
FROM film 
WHERE rental_rate > 4;

--Show films that: have rating PG and are longer than 120 minutes. Show: title, length, rating
SELECT title, length, rating 
FROM film 
WHERE rating = 'PG' AND length > 120;

--Show films that are rated: PG,R. Show: title, rating
SELECT title, rating 
FROM film 
WHERE rating ='PG' OR rating ='R';

--Same task as above but use IN instead of OR.
SELECT title, rating 
FROM film 
WHERE rating IN ('PG','R');

--Show films whose length is between 90 and 120 minutes. Show: title, length
SELECT title, length 
FROM film 
WHERE length BETWEEN 90 AND 120;

--Show actors whose first name starts with "A". Table: actor. Show: first_name, last_name
SELECT first_name, last_name 
FROM actor 
WHERE first_name LIKE 'A%';

--Show actors whose last name contains "son". Show: first_name, last_name
SELECT first_name, last_name 
FROM actor 
WHERE last_name LIKE '%son%';

--Show payments where amount is greater than 7. Show: payment_id, amount
SELECT payment_id, amount 
FROM payment 
WHERE amount > 7;

--Show films that: have rating PG and rental_rate greater than 4. Show: title, rating, rental_rate
SELECT title, rating, rental_rate 
FROM film 
WHERE rating ='PG' AND rental_rate > 4;

