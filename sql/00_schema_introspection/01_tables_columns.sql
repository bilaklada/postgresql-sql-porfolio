-- =========================================================
-- File: 01_tables_columns.sql
-- Goal: Inspect tables and columns before writing analysis.
-- Dataset: dvdrental
-- Grain: one row per table or one row per column, depending on query.
-- Notes: I use this to understand structure before joining tables.
-- =========================================================

-- Tables in the public schema with estimated row counts from PostgreSQL stats.
SELECT
    schemaname,
    relname AS table_name,
    n_live_tup AS estimated_live_rows,
    n_dead_tup AS estimated_dead_rows,
    last_analyze,
    last_autoanalyze
FROM pg_catalog.pg_stat_user_tables
WHERE schemaname = 'public'
ORDER BY relname;

-- Column inventory with PostgreSQL data types and nullability.
SELECT
    c.table_schema,
    c.table_name,
    c.ordinal_position,
    c.column_name,
    c.data_type,
    c.udt_name,
    c.is_nullable,
    c.column_default
FROM information_schema.columns AS c
WHERE c.table_schema = 'public'
ORDER BY
    c.table_name,
    c.ordinal_position;

-- Date and timestamp columns are important for cohort and operational analysis.
SELECT
    c.table_name,
    c.column_name,
    c.data_type
FROM information_schema.columns AS c
WHERE c.table_schema = 'public'
  AND (
      c.data_type LIKE '%date%'
      OR c.data_type LIKE '%time%'
  )
ORDER BY
    c.table_name,
    c.column_name;
