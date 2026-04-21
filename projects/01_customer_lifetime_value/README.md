# Customer Lifetime Value

I use this project to show how I build a customer-level analytical dataset from
payments and rentals, then validate that the output still has one row per
customer.

The project is intentionally direct: `dvdrental` does not contain customer
acquisition cost or margin, so I treat lifetime value as gross rental revenue
captured in the `payment` table.

## Files

- `question.md`: business question, tables, metrics, assumptions, and grain
- `solution.sql`: customer-level SQL solution
- `validation.sql`: row count, revenue reconciliation, and grain checks
- `findings.md`: concise interpretation and interview value

## Main SQL patterns

- CTEs
- aggregation at customer grain
- date recency calculation
- segmentation with `CASE`
- validation against source totals
