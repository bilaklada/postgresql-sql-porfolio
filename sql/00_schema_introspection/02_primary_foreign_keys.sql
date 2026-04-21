-- =========================================================
-- File: 02_primary_foreign_keys.sql
-- Goal: Inspect primary keys and foreign keys in dvdrental.
-- Dataset: dvdrental
-- Grain: one row per constrained column relationship.
-- Notes: This helps confirm join paths before writing analysis.
-- =========================================================

-- Primary keys by table.
SELECT
    tc.table_schema,
    tc.table_name,
    kcu.column_name,
    tc.constraint_name
FROM information_schema.table_constraints AS tc
INNER JOIN information_schema.key_column_usage AS kcu
    ON kcu.constraint_schema = tc.constraint_schema
   AND kcu.constraint_name = tc.constraint_name
   AND kcu.table_schema = tc.table_schema
   AND kcu.table_name = tc.table_name
WHERE tc.table_schema = 'public'
  AND tc.constraint_type = 'PRIMARY KEY'
ORDER BY
    tc.table_name,
    kcu.ordinal_position;

-- Foreign-key relationships, including referenced table and column.
SELECT
    tc.table_name AS source_table,
    kcu.column_name AS source_column,
    ccu.table_name AS referenced_table,
    ccu.column_name AS referenced_column,
    tc.constraint_name
FROM information_schema.table_constraints AS tc
INNER JOIN information_schema.key_column_usage AS kcu
    ON kcu.constraint_schema = tc.constraint_schema
   AND kcu.constraint_name = tc.constraint_name
INNER JOIN information_schema.constraint_column_usage AS ccu
    ON ccu.constraint_schema = tc.constraint_schema
   AND ccu.constraint_name = tc.constraint_name
WHERE tc.table_schema = 'public'
  AND tc.constraint_type = 'FOREIGN KEY'
ORDER BY
    source_table,
    source_column;

-- Tables without declared foreign keys still deserve review before analysis.
SELECT
    t.table_name
FROM information_schema.tables AS t
LEFT JOIN information_schema.table_constraints AS tc
    ON tc.table_schema = t.table_schema
   AND tc.table_name = t.table_name
   AND tc.constraint_type = 'FOREIGN KEY'
WHERE t.table_schema = 'public'
  AND t.table_type = 'BASE TABLE'
GROUP BY t.table_name
HAVING COUNT(tc.constraint_name) = 0
ORDER BY t.table_name;
