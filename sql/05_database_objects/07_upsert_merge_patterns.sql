-- =========================================================
-- File: 07_upsert_merge_patterns.sql
-- Goal: Demonstrate ON CONFLICT and MERGE patterns.
-- Dataset: dvdrental
-- Grain: one row per customer snapshot.
-- Notes: MERGE requires PostgreSQL 15 or newer.
-- =========================================================

CREATE SCHEMA IF NOT EXISTS portfolio;

DROP TABLE IF EXISTS portfolio.customer_contact_snapshot;

CREATE TABLE portfolio.customer_contact_snapshot (
    customer_id integer PRIMARY KEY,
    full_name text NOT NULL,
    email text,
    source_updated_at timestamp NOT NULL,
    loaded_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Upsert customer contact records.
INSERT INTO portfolio.customer_contact_snapshot (
    customer_id,
    full_name,
    email,
    source_updated_at
)
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS full_name,
    c.email,
    c.last_update
FROM customer AS c
WHERE c.customer_id <= 10
ON CONFLICT (customer_id)
DO UPDATE SET
    full_name = EXCLUDED.full_name,
    email = EXCLUDED.email,
    source_updated_at = EXCLUDED.source_updated_at,
    loaded_at = CURRENT_TIMESTAMP;

-- MERGE pattern for PostgreSQL 15+.
MERGE INTO portfolio.customer_contact_snapshot AS target
USING (
    SELECT
        c.customer_id,
        c.first_name || ' ' || c.last_name AS full_name,
        c.email,
        c.last_update AS source_updated_at
    FROM customer AS c
    WHERE c.customer_id BETWEEN 8 AND 15
) AS source
ON source.customer_id = target.customer_id
WHEN MATCHED THEN
    UPDATE SET
        full_name = source.full_name,
        email = source.email,
        source_updated_at = source.source_updated_at,
        loaded_at = CURRENT_TIMESTAMP
WHEN NOT MATCHED THEN
    INSERT (customer_id, full_name, email, source_updated_at)
    VALUES (source.customer_id, source.full_name, source.email, source.source_updated_at);

SELECT
    customer_id,
    full_name,
    email,
    source_updated_at
FROM portfolio.customer_contact_snapshot
ORDER BY customer_id;
