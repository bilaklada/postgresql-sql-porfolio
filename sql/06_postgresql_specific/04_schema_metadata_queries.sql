-- =========================================================
-- File: 04_schema_metadata_queries.sql
-- Goal: Query PostgreSQL metadata for tables, indexes, and sizes.
-- Dataset: dvdrental
-- Grain: one row per database object.
-- Notes: Metadata queries help me inspect a database without guessing.
-- =========================================================

-- Table sizes.
SELECT
    n.nspname AS schema_name,
    c.relname AS table_name,
    pg_size_pretty(pg_total_relation_size(c.oid)) AS total_size,
    pg_total_relation_size(c.oid) AS total_size_bytes
FROM pg_catalog.pg_class AS c
INNER JOIN pg_catalog.pg_namespace AS n
    ON n.oid = c.relnamespace
WHERE n.nspname = 'public'
  AND c.relkind = 'r'
ORDER BY total_size_bytes DESC;

-- Index inventory.
SELECT
    schemaname,
    tablename,
    indexname,
    indexdef
FROM pg_catalog.pg_indexes
WHERE schemaname = 'public'
ORDER BY
    tablename,
    indexname;

-- Column comments and table comments if present.
SELECT
    cols.table_name,
    cols.column_name,
    pg_catalog.col_description(cls.oid, cols.ordinal_position) AS column_comment
FROM information_schema.columns AS cols
INNER JOIN pg_catalog.pg_class AS cls
    ON cls.relname = cols.table_name
INNER JOIN pg_catalog.pg_namespace AS ns
    ON ns.oid = cls.relnamespace
   AND ns.nspname = cols.table_schema
WHERE cols.table_schema = 'public'
ORDER BY
    cols.table_name,
    cols.ordinal_position;
