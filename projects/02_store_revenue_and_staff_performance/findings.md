# Findings

This project shows how store revenue and staff handling can be summarized
without losing payment-level grain. The most important modeling point is that
store context comes from inventory, while staff context comes from the payment.

## What I would look for in the output

- whether revenue is balanced across stores
- which staff member ranks first within each store
- differences between payment volume and average payment amount
- date coverage for each staff member's payments

## Why this matters in an interview

This project is useful for discussing multi-table joins, grain preservation, and
why I validate revenue back to the payment table before interpreting staff or
store rankings.
