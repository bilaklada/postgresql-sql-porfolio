-- =========================================================
-- File: 03_extensions.sql
-- Goal: Enable PostgreSQL extensions used by selected examples.
-- Dataset: dvdrental
-- Notes: Run as a role with permission to create extensions.
-- =========================================================

CREATE EXTENSION IF NOT EXISTS pg_trgm;
CREATE EXTENSION IF NOT EXISTS unaccent;

-- Confirm installed extensions used by this repository.
SELECT
    extname AS extension_name,
    extversion AS extension_version
FROM pg_catalog.pg_extension
WHERE extname IN ('pg_trgm', 'unaccent')
ORDER BY extname;
