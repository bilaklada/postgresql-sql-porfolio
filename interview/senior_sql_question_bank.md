# SQL Question Bank

These are interview questions I can answer using examples from this repository.

## Relational Modeling And Joins

**How do you decide the grain of a query?**

I define what one output row should represent before joining or aggregating. For
example, the customer lifetime value project is one row per customer, while the
cohort project is one row per cohort month and month offset.

**How can joins create wrong results even when the SQL runs?**

One-to-many joins can multiply rows. Joining `film` to `film_actor` changes the
grain from film to film-actor. I use row-count checks and `COUNT(DISTINCT ...)`
carefully to confirm whether duplication is expected.

**When would you use EXISTS instead of JOIN?**

I use `EXISTS` when I only need to test whether a related row exists. It avoids
returning columns from the child table and avoids accidental row multiplication.

**How do you find records in one table that do not exist in another?**

I use an anti-join pattern, usually `NOT EXISTS`. For example, I find films with
no inventory or inventory copies that were never rented.

## Aggregation And Validation

**How do you validate an aggregated result?**

I reconcile the summary back to the source detail. If I summarize revenue by
customer, the sum of customer revenue should match `SUM(payment.amount)`.

**What is the difference between WHERE and HAVING?**

`WHERE` filters rows before aggregation. `HAVING` filters groups after
aggregation.

**Why can COUNT(*) and COUNT(column) return different results?**

`COUNT(*)` counts rows. `COUNT(column)` counts non-null values in that column.
This matters in left joins and null checks.

## Window Functions

**When would you use a window function instead of GROUP BY?**

I use a window function when I need a calculation across related rows while
keeping row-level detail. Ranking films within categories is a good example.

**What is the difference between ROW_NUMBER, RANK, and DENSE_RANK?**

`ROW_NUMBER` gives a unique sequence. `RANK` allows ties and leaves gaps.
`DENSE_RANK` allows ties without gaps.

**How do you calculate running totals?**

I aggregate to the correct period first, then use `SUM(metric) OVER (ORDER BY
period ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)`.

## CTEs And Query Structure

**Why use CTEs?**

I use CTEs to name logical steps, especially when a query includes multiple
aggregations or validation points. They make SQL easier to review and explain.

**Can CTEs hurt performance?**

They can depending on PostgreSQL version and query shape. I use `EXPLAIN` when
performance matters and avoid using CTEs only for decoration.

## PostgreSQL-Specific Features

**How do you inspect a PostgreSQL schema?**

I use `information_schema` for portable metadata and `pg_catalog` for
PostgreSQL-specific details like table sizes, index definitions, and statistics.

**What is a materialized view?**

A materialized view stores the result of a query. It can speed up repeated
analytical reads, but it must be refreshed when source data changes.

**When would you add an index?**

I add an index for a clear query pattern: selective filters, joins, ordering, or
search. I check the plan with `EXPLAIN` and avoid adding indexes without a
reason.

**What is JSONB useful for in PostgreSQL?**

JSONB is useful for flexible attributes or document-style payloads. I still keep
relational data relational when relationships and constraints matter.

## Project Discussion

**Which project best shows your SQL process?**

Customer lifetime value is a strong example because it starts with a clear
customer grain, aggregates payments and rentals separately, joins them back to
customers, creates segments, and validates revenue and row counts.

**What would you improve next?**

I would add curated sample outputs and saved explain plans from a local
PostgreSQL run. I would keep the scope focused rather than adding unrelated
datasets.
