# Business Question

Which stores, categories, and customers show higher late-return risk?

## Stakeholder Perspective

I frame this for an operations stakeholder who wants to understand where follow
up or policy review may be needed.

## Tables Used

- `rental`
- `inventory`
- `film`
- `film_category`
- `category`
- `customer`
- `payment`

## Grain

The main output is one row per store and category. Supporting detail is one row
per rental.

## Metric Definitions

- `expected_return_at`: rental date plus the film's rental duration
- `is_late_return`: returned after expected return timestamp
- `is_open_rental`: return date is null
- `late_return_rate`: late returned rentals divided by returned rentals
- `avg_days_late`: average days late among late returned rentals

## Assumptions

- `film.rental_duration` is measured in days.
- A rental is late only if it has a return date after the expected return time.
- Open rentals are tracked separately from late returned rentals.
