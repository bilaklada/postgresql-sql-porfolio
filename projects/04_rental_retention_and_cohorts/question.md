# Business Question

How do customer rental cohorts behave after their first rental month?

## Stakeholder Perspective

I frame this for a customer retention stakeholder who wants to understand repeat
rental behavior by acquisition cohort.

## Tables Used

- `customer`
- `rental`

## Grain

One row per cohort month and activity month offset.

## Metric Definitions

- `cohort_month`: month of a customer's first rental
- `activity_month`: month of a customer's rental activity
- `months_since_first_rental`: number of months between activity month and cohort month
- `active_customers`: distinct customers active in that cohort/month offset
- `cohort_size`: distinct customers in the cohort
- `retention_rate`: active customers divided by cohort size

## Assumptions

- First rental month is used as the cohort assignment.
- Retention means at least one rental in the activity month.
- The dataset is historical and limited, so later cohorts have less observable follow-up time.
