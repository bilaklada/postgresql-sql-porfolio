# Query Style Guide

## Purpose

This style guide defines how SQL should be written across the repository.

The goal is not only to make queries work, but to make them:
- readable
- reviewable
- maintainable
- easier to validate
- easier to explain in an interview

This repository uses PostgreSQL syntax and should prefer clarity over cleverness.

---

## Core principles

### 1. Write for readability first

A query should be understandable by another engineer reading it later.

Good SQL is not only short SQL.  
Good SQL makes the logic easy to follow.

### 2. Prefer explicitness

Be explicit about:
- selected columns
- join conditions
- grouping logic
- sort order
- assumptions

Avoid hidden logic and ambiguous output.

### 3. Preserve result grain consciously

Every analytical query should have a clearly understood grain.

Examples:
- one row per customer
- one row per store and month
- one row per film category
- one row per rental

If the grain is unclear, the query is not ready.

### 4. Validate important outputs

Joins, aggregations, and window functions can all produce misleading results if the grain is wrong.

Queries should be supported by validation logic where appropriate.

---

## Formatting rules

### SQL keywords

Write SQL keywords in uppercase.

Example:
```sql
SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM customer AS c
WHERE c.active = 1
ORDER BY c.customer_id;