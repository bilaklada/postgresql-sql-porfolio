# Glossary

## Anti-join

A query pattern that returns rows in one table that do not have a matching row
in another table. In this repository I usually write it with `NOT EXISTS` or a
`LEFT JOIN ... IS NULL` check.

## Bridge table

A table that represents a many-to-many relationship, such as `film_actor` or
`film_category`.

## CTE

Common table expression. I use CTEs to break a query into named steps.

## Grain

The meaning of one row in a result set. Examples: one row per customer, one row
per film, one row per store and month.

## Materialized view

A stored query result that can be refreshed. Useful when an analytical summary
is expensive and reused.

## Semi-join

A query pattern that returns rows from one table when a matching row exists in
another table, without returning columns from the second table. `EXISTS` is a
common semi-join pattern.

## Window function

A function that calculates across a set of related rows while keeping row-level
detail. Examples include `ROW_NUMBER`, `RANK`, `SUM(...) OVER`, `LAG`, and
`LEAD`.

## Validation query

A supporting query that checks whether the main output is trustworthy. Examples
include duplicate checks, row-count checks, null checks, and reconciliation
queries.
