# Business Question

How much revenue is associated with each store and staff member, and which staff
members handle the largest payment volume within their store?

## Stakeholder Perspective

I frame this for an operations manager who wants a store-level and staff-level
view of payment handling.

## Tables Used

- `payment`
- `rental`
- `inventory`
- `store`
- `staff`

## Grain

One row per rental store and staff member.

## Metric Definitions

- `payment_count`: number of payments handled
- `paid_rental_count`: distinct rentals with payments
- `total_revenue`: sum of payment amount
- `avg_payment_amount`: average payment amount
- `staff_rank_in_store`: rank by revenue within store

## Assumptions

- Revenue is measured from `payment.amount`.
- Store is assigned from `inventory.store_id`, which identifies where the rented
  inventory copy belongs.
- Staff performance here means payment handling in the sample data, not full
  employee performance.
