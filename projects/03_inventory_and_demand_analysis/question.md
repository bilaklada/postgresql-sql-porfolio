# Business Question

Which films appear overstocked, understocked, or inactive when inventory copies
are compared with rental demand?

## Stakeholder Perspective

I frame this for an inventory or store operations stakeholder who wants to
understand whether physical stock matches observed rental activity.

## Tables Used

- `film`
- `inventory`
- `rental`
- `payment`
- `film_category`
- `category`

## Grain

One row per film.

## Metric Definitions

- `inventory_copy_count`: number of physical inventory rows for the film
- `rental_count`: number of rentals for all copies of the film
- `revenue`: sum of payments tied to rentals of the film
- `rentals_per_copy`: rentals divided by inventory copies
- `inventory_status`: simple rule-based label for demand versus stock

## Assumptions

- Inventory rows represent available physical copies in stores.
- Rental demand is historical rental count, not forecasted demand.
- Films with no inventory are included because their lack of stock matters.
