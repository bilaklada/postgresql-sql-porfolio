-- =========================================================
-- File: 03_constraints.sql
-- Goal: Demonstrate constraints in a portfolio-owned table.
-- Dataset: dvdrental
-- Grain: one row per staged quality rule.
-- Notes: I do not alter source dvdrental tables in this demo.
-- =========================================================

CREATE SCHEMA IF NOT EXISTS portfolio;

DROP TABLE IF EXISTS portfolio.rental_quality_demo;

CREATE TABLE portfolio.rental_quality_demo (
    rental_id integer PRIMARY KEY,
    customer_id integer NOT NULL,
    rental_date timestamp NOT NULL,
    return_date timestamp,
    rental_status text NOT NULL,
    CONSTRAINT rental_quality_demo_status_chk
        CHECK (rental_status IN ('open', 'returned')),
    CONSTRAINT rental_quality_demo_return_chk
        CHECK (return_date IS NULL OR return_date >= rental_date)
);

INSERT INTO portfolio.rental_quality_demo (
    rental_id,
    customer_id,
    rental_date,
    return_date,
    rental_status
)
SELECT
    r.rental_id,
    r.customer_id,
    r.rental_date,
    r.return_date,
    CASE
        WHEN r.return_date IS NULL THEN 'open'
        ELSE 'returned'
    END AS rental_status
FROM rental AS r
ORDER BY r.rental_id
LIMIT 100;

SELECT
    rental_status,
    COUNT(*) AS row_count
FROM portfolio.rental_quality_demo
GROUP BY rental_status
ORDER BY rental_status;
