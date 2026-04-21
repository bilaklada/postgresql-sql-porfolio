# PostgreSQL Features Used

I include PostgreSQL-specific examples because I want the repository to show
database awareness beyond generic SQL syntax.

## Query language features

- CTEs and recursive CTEs
- window functions
- `FILTER` on aggregate functions
- `LATERAL` joins
- set operations
- `EXISTS` and `NOT EXISTS`
- `RETURNING`
- `ON CONFLICT`
- `MERGE` for PostgreSQL 15 and newer

## Database objects

- views
- materialized views
- schemas
- constraints
- indexes
- transaction blocks

## PostgreSQL data and search features

- JSONB construction and querying
- GIN indexes for JSONB and full-text search
- `to_tsvector`, `plainto_tsquery`, and `ts_rank`
- range-style date logic with intervals
- declarative partitioning demos

## Metadata and introspection

The schema introspection scripts use PostgreSQL catalog and information schema
views, including:

- `information_schema.columns`
- `information_schema.table_constraints`
- `information_schema.key_column_usage`
- `pg_catalog.pg_indexes`
- `pg_catalog.pg_class`
- `pg_catalog.pg_namespace`
- `pg_catalog.pg_stat_user_tables`

I use these queries to inspect structure before writing analysis, and to make
database assumptions visible.
