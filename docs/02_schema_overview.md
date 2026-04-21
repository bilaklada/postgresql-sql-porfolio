# Schema Overview

I use `dvdrental` because it has a clear business domain and enough relational
structure to practice realistic SQL.

## Core business flow

At a high level:

1. A `customer` rents an `inventory` item.
2. An `inventory` item belongs to a `film` and a `store`.
3. A `rental` can have a `payment`.
4. A `staff` member handles rentals and payments.
5. A `film` can belong to categories and have actors through bridge tables.

## Important tables

| Table | Grain | Notes |
| --- | --- | --- |
| `customer` | one row per customer | customer profile, store assignment, active flag |
| `rental` | one row per rental transaction | rental date, return date, customer, staff, inventory |
| `payment` | one row per payment | amount, payment date, customer, staff, rental |
| `inventory` | one row per physical inventory item | film copy available at a store |
| `film` | one row per film title | rental duration, rate, length, rating, replacement cost |
| `film_category` | one row per film-category link | bridge table between films and categories |
| `film_actor` | one row per film-actor link | bridge table between films and actors |
| `store` | one row per store | store address and manager |
| `staff` | one row per staff member | staff profile and store assignment |
| `address`, `city`, `country` | geographic dimensions | location context |

## Relationship patterns

- `customer` to `rental` is one-to-many.
- `customer` to `payment` is one-to-many.
- `film` to `inventory` is one-to-many because each film can have multiple copies.
- `inventory` to `rental` is one-to-many because a copy can be rented many times.
- `film` to `category` is many-to-many through `film_category`.
- `film` to `actor` is many-to-many through `film_actor`.

## Grain risks I watch for

- Joining `film` to `film_actor` multiplies film rows by actor count.
- Joining `film` to `inventory` multiplies film rows by physical copies.
- Joining `inventory` to `rental` multiplies inventory rows by rental history.
- Joining `customer` to both `rental` and `payment` can duplicate facts if the
  join does not use the correct transaction key.

When I write portfolio queries, I try to state the intended grain in comments
before the main query.
