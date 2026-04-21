# Learning Roadmap

I use this roadmap to keep the repository disciplined. The goal is not to collect
random SQL snippets. The goal is to show steady growth from foundations toward
analysis, validation, and PostgreSQL-specific work.

## 1. Understand the schema first

Before writing analysis queries, I inspect:

- tables and columns
- primary keys and foreign keys
- bridge tables
- date columns
- nullable columns
- row counts by table

This protects me from writing joins before I understand the grain of each table.

## 2. Build SQL fundamentals

The foundation scripts cover filtering, sorting, grouping, `HAVING`, `CASE`,
NULL logic, date handling, and basic aggregations. I keep these files because
good advanced SQL still depends on clean basics.

## 3. Practice joins with grain in mind

The join scripts focus on more than syntax. I practice:

- preserving the expected row count
- recognizing one-to-many joins
- using bridge tables correctly
- choosing `EXISTS` when I only need to test presence
- using anti-joins for missing relationship checks

## 4. Structure multi-step logic

The advanced query scripts use subqueries, CTEs, recursive CTEs, set operations,
and `LATERAL`. I use these tools when they make the logic easier to review or
when they express a pattern better than one large nested query.

## 5. Add analytical SQL

The analytics scripts use window functions for ranking, running totals, period
comparison, top-N logic, percentiles, and segmentation. These are the patterns I
expect to discuss in analytics engineering and SQL interviews.

## 6. Show PostgreSQL depth

The database object and PostgreSQL-specific folders show that I understand SQL
inside a database system, not only as a reporting language. I include examples
for views, materialized views, constraints, indexes, transactions, explain
plans, JSONB, full-text search, partitioning, and catalog metadata.

## 7. Validate results

I treat validation as a normal part of query development. The quality checks
folder contains reusable patterns for row counts, duplicates, null checks, and
foreign-key consistency.

## 8. Communicate through projects

The projects turn technical SQL into interview-ready analysis. Each project has
a question, assumptions, SQL solution, validation, findings, and a short note on
why the project matters.
