-- =========================================================
-- Project: Store Revenue and Staff Performance
-- Goal: Validate payment joins and revenue totals.
-- Dataset: dvdrental
-- =========================================================

-- Validation 1: payment to rental to inventory should preserve payment grain.
SELECT
    COUNT(*) AS joined_rows,
    COUNT(DISTINCT p.payment_id) AS distinct_payments,
    COUNT(*) - COUNT(DISTINCT p.payment_id) AS duplicate_payment_rows
FROM payment AS p
INNER JOIN rental AS r
    ON r.rental_id = p.rental_id
INNER JOIN inventory AS i
    ON i.inventory_id = r.inventory_id;

-- Validation 2: store/staff summary should reconcile to payment detail revenue.
WITH payment_detail AS (
    SELECT
        p.payment_id,
        p.amount,
        p.staff_id,
        i.store_id AS rental_store_id
    FROM payment AS p
    INNER JOIN rental AS r
        ON r.rental_id = p.rental_id
    INNER JOIN inventory AS i
        ON i.inventory_id = r.inventory_id
),
summary AS (
    SELECT
        rental_store_id,
        staff_id,
        SUM(amount) AS total_revenue
    FROM payment_detail
    GROUP BY
        rental_store_id,
        staff_id
)
SELECT
    (SELECT SUM(amount) FROM payment) AS payment_detail_total,
    SUM(total_revenue) AS summary_total,
    (SELECT SUM(amount) FROM payment) - SUM(total_revenue) AS difference
FROM summary;

-- Validation 3: identify any payments whose staff id is missing from staff.
SELECT
    COUNT(*) FILTER (WHERE s.staff_id IS NULL) AS payments_with_missing_staff
FROM payment AS p
LEFT JOIN staff AS s
    ON s.staff_id = p.staff_id;
