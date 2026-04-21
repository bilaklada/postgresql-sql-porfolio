# Business Question

Which films and categories perform best by rental count and revenue?

## Stakeholder Perspective

I frame this for a merchandising or catalog stakeholder who wants to know which
titles and categories are strongest in the historical rental data.

## Tables Used

- `film`
- `film_category`
- `category`
- `inventory`
- `rental`
- `payment`

## Grain

One row per film and category.

## Metric Definitions

- `rental_count`: number of rentals tied to the film
- `revenue`: sum of payments tied to the film's rentals
- `category_revenue_rank`: rank of films within category by revenue
- `category_rental_rank`: rank of films within category by rental count

## Assumptions

- Revenue is gross payment amount.
- Category assignment comes from `film_category`.
- In `dvdrental`, films are typically assigned to one category, but I still
  validate bridge-table behavior.
