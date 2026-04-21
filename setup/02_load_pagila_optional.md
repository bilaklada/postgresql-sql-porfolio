# Optional Pagila Notes

I keep `dvdrental` as the main dataset. Pagila is optional and is not required
to run the portfolio projects.

Pagila can be useful when I want a version of the same business domain with
more PostgreSQL-oriented schema features. I would only add it to a local
environment for deeper practice with database objects, not as a second main
portfolio dataset.

## Suggested approach

1. Create a separate database, for example `pagila`.
2. Load Pagila schema and data from its official project files.
3. Keep comparisons separate from the main `dvdrental` work.

```bash
createdb pagila
psql -d pagila -f pagila-schema.sql
psql -d pagila -f pagila-data.sql
```

## Why it is optional

The core portfolio already demonstrates relational querying, validation,
analytics, and PostgreSQL-specific syntax using `dvdrental`. Adding another
dataset should improve the work, not make the repository look larger without a
clear reason.
