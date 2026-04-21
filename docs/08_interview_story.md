# Interview Story

I use this repository to show how I approach SQL work from problem framing to
validation.

## Short version

I built a PostgreSQL portfolio around the `dvdrental` sample database. The repo
starts with schema inspection and foundations, then moves into joins, CTEs,
window functions, PostgreSQL-specific features, quality checks, and six
business-oriented analysis projects.

The main theme is reliable SQL. I try to make the grain of each query clear,
control join duplication, and validate outputs before treating them as useful.

## What I want a reviewer to notice

- I understand relational structure before joining tables.
- I use CTEs to make multi-step logic reviewable.
- I can use window functions for practical analytics.
- I know PostgreSQL features beyond basic SELECT queries.
- I include validation queries instead of assuming every result is correct.
- I keep business conclusions proportional to what the sample data supports.

## How I would explain the portfolio

I would start with the customer lifetime value project because it combines
customer-level grain, revenue aggregation, rental behavior, recency, and
validation. From there, I can point to the retention project for cohort logic,
the inventory project for join and anti-join thinking, and the PostgreSQL folder
for database-specific examples.

## What I do not claim

I do not present this as production experience or as a complete data warehouse.
It is a focused SQL portfolio that shows how I practice, structure, validate,
and explain PostgreSQL work.
