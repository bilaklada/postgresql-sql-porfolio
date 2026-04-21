# Project Talking Points

## Customer Lifetime Value

I would explain that the output is one row per customer. I aggregate payments
and rentals separately, then join those summaries back to `customer`. This keeps
the grain controlled and avoids accidentally multiplying revenue by rental rows.

Good discussion points:

- lifetime revenue is gross payment amount, not profit
- recency is calculated relative to the dataset's latest rental date
- validation reconciles customer revenue back to the payment table

## Store Revenue and Staff Performance

I would explain the difference between inventory store and payment staff. Store
comes from `inventory.store_id`; staff comes from `payment.staff_id`. Those
fields answer related but different operational questions.

Good discussion points:

- multi-table joins from payment to rental to inventory
- ranking staff within each store
- checking that payment rows are not duplicated

## Inventory and Demand Analysis

I would explain that inventory analysis needs left joins because films with no
inventory and copies with no rentals are both meaningful. I use `NULLIF` to keep
division safe when calculating rentals per copy.

Good discussion points:

- no inventory versus stock not rented
- historical demand is not the same as forecasted demand
- anti-join checks identify inventory copies never rented

## Rental Retention and Cohorts

I would explain how each customer is assigned to the month of their first rental,
then counted as active in later rental months. The result is one row per cohort
month and month offset.

Good discussion points:

- `DATE_TRUNC` for monthly buckets
- `COUNT(DISTINCT customer_id)` for active customers
- month zero validation should equal cohort size
- later cohorts have less observable follow-up time

## Top Films, Categories, and Rankings

I would explain that category analysis requires care because `film_category` is
a bridge table. I rank films within category by both revenue and rental count.

Good discussion points:

- `DENSE_RANK` versus `ROW_NUMBER`
- why top by revenue can differ from top by rental count
- validation of category assignment before trusting rankings

## Late Returns Operational Risk

I would explain that expected return time is calculated from rental date plus
the film's rental duration. I separate late returned rentals from open rentals
because they mean different operational actions.

Good discussion points:

- interval arithmetic
- `CASE` flags for late, open, and on-time rentals
- denominator choice for late return rate
- validation that return dates are not before rental dates
