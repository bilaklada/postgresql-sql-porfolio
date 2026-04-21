# Load dvdrental

The primary dataset for this portfolio is `dvdrental`.

## Download

The sample database is commonly distributed as `dvdrental.tar`. I do not commit
the dump file to this repository because it is a generated data artifact, not
portfolio source code.

## Restore

From the directory where `dvdrental.tar` is stored:

```bash
pg_restore --dbname=dvdrental --verbose dvdrental.tar
```

If the database does not exist yet:

```bash
createdb dvdrental
pg_restore --dbname=dvdrental --verbose dvdrental.tar
```

## Confirm the load

```sql
SELECT
    schemaname,
    tablename
FROM pg_catalog.pg_tables
WHERE schemaname = 'public'
ORDER BY tablename;
```

Expected core tables include `actor`, `film`, `inventory`, `rental`,
`payment`, `customer`, `staff`, and `store`.

I use the introspection scripts in `sql/00_schema_introspection/` as the next
step after loading data. They help me confirm table counts, keys, and basic
data quality before writing analysis queries.
