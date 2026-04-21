-- =========================================================
-- File: 03_partitioning_demo.sql
-- Goal: Demonstrate declarative range partitioning with rental dates.
-- Dataset: dvdrental
-- Grain: one row per staged rental event.
-- Notes: This creates portfolio-owned demo tables only.
-- =========================================================

CREATE SCHEMA IF NOT EXISTS portfolio;

DROP TABLE IF EXISTS portfolio.rental_events_partitioned CASCADE;

CREATE TABLE portfolio.rental_events_partitioned (
    rental_id integer NOT NULL,
    rental_date timestamp NOT NULL,
    customer_id integer NOT NULL,
    inventory_id integer NOT NULL,
    PRIMARY KEY (rental_id, rental_date)
) PARTITION BY RANGE (rental_date);

CREATE TABLE portfolio.rental_events_2005
    PARTITION OF portfolio.rental_events_partitioned
    FOR VALUES FROM ('2005-01-01') TO ('2006-01-01');

CREATE TABLE portfolio.rental_events_2006
    PARTITION OF portfolio.rental_events_partitioned
    FOR VALUES FROM ('2006-01-01') TO ('2007-01-01');

INSERT INTO portfolio.rental_events_partitioned (
    rental_id,
    rental_date,
    customer_id,
    inventory_id
)
SELECT
    rental_id,
    rental_date,
    customer_id,
    inventory_id
FROM rental
WHERE rental_date >= TIMESTAMP '2005-01-01'
  AND rental_date < TIMESTAMP '2007-01-01';

SELECT
    tableoid::regclass AS partition_name,
    COUNT(*) AS row_count
FROM portfolio.rental_events_partitioned
GROUP BY tableoid::regclass
ORDER BY partition_name;

EXPLAIN
SELECT
    COUNT(*) AS rentals_2005
FROM portfolio.rental_events_partitioned
WHERE rental_date >= TIMESTAMP '2005-01-01'
  AND rental_date < TIMESTAMP '2006-01-01';
