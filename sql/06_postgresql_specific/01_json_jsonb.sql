-- =========================================================
-- File: 01_json_jsonb.sql
-- Goal: Build and query JSONB documents from relational data.
-- Dataset: dvdrental
-- Grain: one row per customer document.
-- Notes: JSONB is useful for flexible attributes, not as a replacement for relational design.
-- =========================================================

CREATE SCHEMA IF NOT EXISTS portfolio;

DROP TABLE IF EXISTS portfolio.customer_profile_jsonb;

CREATE TABLE portfolio.customer_profile_jsonb AS
SELECT
    c.customer_id,
    JSONB_BUILD_OBJECT(
        'customer_id', c.customer_id,
        'name', c.first_name || ' ' || c.last_name,
        'email', c.email,
        'store_id', c.store_id,
        'active', c.activebool,
        'created_at', c.create_date
    ) AS profile_doc
FROM customer AS c;

CREATE INDEX customer_profile_jsonb_doc_gin_idx
    ON portfolio.customer_profile_jsonb
    USING gin (profile_doc);

-- Query JSONB attributes.
SELECT
    customer_id,
    profile_doc ->> 'name' AS customer_name,
    (profile_doc ->> 'store_id')::integer AS store_id
FROM portfolio.customer_profile_jsonb
WHERE profile_doc @> '{"active": true}'::jsonb
ORDER BY customer_id
LIMIT 25;

-- Aggregate from JSONB values.
SELECT
    (profile_doc ->> 'store_id')::integer AS store_id,
    COUNT(*) AS customer_count
FROM portfolio.customer_profile_jsonb
GROUP BY (profile_doc ->> 'store_id')::integer
ORDER BY store_id;
