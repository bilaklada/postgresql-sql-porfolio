# Relational Model Notes

This repository is built around relational thinking. I want the SQL to show that
I understand how tables connect, where duplication can enter, and why key choice
matters.

## Primary keys

Most core tables have single-column primary keys:

- `customer.customer_id`
- `rental.rental_id`
- `payment.payment_id`
- `inventory.inventory_id`
- `film.film_id`
- `staff.staff_id`
- `store.store_id`

Bridge tables use composite keys or unique relationship pairs:

- `film_actor`: film and actor relationship
- `film_category`: film and category relationship

## Foreign keys

Foreign keys encode business relationships. For example:

- `rental.customer_id` references `customer.customer_id`
- `rental.inventory_id` references `inventory.inventory_id`
- `payment.rental_id` references `rental.rental_id`
- `inventory.film_id` references `film.film_id`

I still write consistency checks because analytical SQL often runs in
environments where constraints may be missing, disabled, or not trusted.

## Fact and dimension thinking

For analytical work, I treat these as fact-like tables:

- `rental`: activity fact
- `payment`: revenue fact

I treat these as dimension-like tables:

- `customer`
- `film`
- `category`
- `staff`
- `store`
- `address`, `city`, `country`

This helps me decide where metrics should be calculated and where descriptive
attributes should be joined.

## Bridge tables

Bridge tables are useful but easy to misuse. If I count films after joining to
actors, I use `COUNT(DISTINCT f.film_id)` unless the intended grain is one row
per film-actor pair.

That is why several SQL files include duplicate checks and grain comments.
