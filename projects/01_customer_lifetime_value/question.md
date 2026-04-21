# Business Question

Which customers have generated the highest lifetime rental revenue, and how can
I segment them by value and rental recency?

## Stakeholder Perspective

I frame this for a retention or customer analytics stakeholder who wants a clear
customer list for follow-up, not only a revenue total.

## Tables Used

- `customer`
- `payment`
- `rental`

## Grain

One row per customer.

## Metric Definitions

- `lifetime_revenue`: total `payment.amount` by customer
- `payment_count`: number of payment records by customer
- `rental_count`: number of rentals by customer
- `first_rental_date`: first rental date for the customer
- `last_rental_date`: most recent rental date for the customer
- `days_since_last_rental`: difference between the dataset's latest rental date and the customer's latest rental date

## Assumptions

- Payments represent gross customer revenue.
- The sample dataset is historical and static, so recency is calculated relative
  to the latest rental date in the data, not today's date.
- Customers with no payments should remain in the output with zero revenue.
