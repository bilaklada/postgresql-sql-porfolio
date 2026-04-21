-- =========================================================
-- File: 06_transactions.sql
-- Goal: Demonstrate transaction control and savepoints.
-- Dataset: dvdrental
-- Grain: one row per demo result.
-- Notes: Source-table changes are rolled back.
-- =========================================================

-- Transaction demo against a source table, rolled back.
BEGIN;

UPDATE customer
SET last_update = CURRENT_TIMESTAMP
WHERE customer_id = 1;

SELECT
    customer_id,
    first_name,
    last_name,
    last_update
FROM customer
WHERE customer_id = 1;

ROLLBACK;

-- Savepoint demo in a temporary table.
BEGIN;

CREATE TEMP TABLE temp_payment_review (
    payment_id integer PRIMARY KEY,
    amount numeric(5, 2) NOT NULL
) ON COMMIT DROP;

INSERT INTO temp_payment_review (payment_id, amount)
SELECT
    payment_id,
    amount
FROM payment
ORDER BY payment_id
LIMIT 5;

SAVEPOINT before_review_update;

UPDATE temp_payment_review
SET amount = amount + 1;

ROLLBACK TO SAVEPOINT before_review_update;

SELECT
    payment_id,
    amount
FROM temp_payment_review
ORDER BY payment_id;

COMMIT;
