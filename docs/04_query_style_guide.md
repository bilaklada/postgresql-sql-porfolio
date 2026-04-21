# Query Style Guide

I write SQL in this repository as if another engineer will review it. The goal
is not only to get a correct result, but to make the logic readable,
maintainable, and defensible.

## Core principles

- Define the intended grain before the main query.
- Select explicit columns in portfolio queries.
- Use readable aliases, usually the first letter or short table name.
- Keep join predicates complete and visible.
- Prefer CTEs when they make multi-step logic easier to validate.
- Use `COUNT(DISTINCT ...)` deliberately, not as a shortcut for unclear joins.
- Add validation queries for important outputs.

## Formatting

```sql
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_amount
FROM customer AS c
INNER JOIN payment AS p
    ON p.customer_id = c.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_amount DESC;
```

## CTE structure

When a query has multiple steps, I name each CTE after its role:

- `base_*` for row-level source shaping
- `*_summary` for aggregated outputs
- `ranked_*` for windowed ranking
- `final` for the final selected result when useful

## Comments

I use comments to explain assumptions, grain, and validation intent. I avoid
comments that simply repeat the SQL keyword.

Useful comment:

```sql
-- Grain: one row per customer and rental month.
```

Weak comment:

```sql
-- Select columns from customer.
```

## Validation habit

For project queries, I expect at least one validation query. For larger outputs,
I usually check totals, row counts, nulls, or duplicate keys.
