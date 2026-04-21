# Portfolio Summary

I built this repository as a focused PostgreSQL SQL portfolio using the
`dvdrental` sample database. It shows how I move from schema inspection to
foundational SQL, joins, advanced query patterns, analytical SQL, PostgreSQL
features, validation checks, and business-style portfolio projects.

## Short interview summary

I use this portfolio to show that I can write SQL that is readable,
relationship-aware, and validated. The work is based on `dvdrental`, so the
business domain is simple, but the relational patterns are realistic: customers,
rentals, payments, inventory, films, categories, stores, and staff.

The strongest part of the portfolio is that each project includes both a SQL
solution and validation queries. I want to show that I do not treat a query as
finished until I have checked row counts, duplicates, nulls, and reconciliations
where they matter.

## Skills I can discuss

- choosing the correct grain for an analysis
- joining one-to-many and many-to-many relationships safely
- using CTEs to structure multi-step SQL
- using window functions for rankings, running totals, and cohort analysis
- using `EXISTS`, `NOT EXISTS`, anti-joins, set operations, and `LATERAL`
- creating views and materialized views for reusable logic
- reading `EXPLAIN` and thinking about indexes
- using JSONB, full-text search, and PostgreSQL metadata queries
- validating analytical outputs before interpreting them

## Best projects to lead with

1. Customer Lifetime Value
2. Rental Retention and Cohorts
3. Inventory and Demand Analysis
4. Late Returns Operational Risk

These projects give me the clearest way to talk about grain, joins, windows,
date logic, and validation.
