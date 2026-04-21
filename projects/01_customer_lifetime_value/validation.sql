-- =========================================================
-- Project: Customer Lifetime Value
-- Goal: Validate row grain and revenue reconciliation.
-- Dataset: dvdrental
-- =========================================================

-- Validation 1: customer-level output should have one row per customer.
WITH output AS (
    SELECT
        c.customer_id
    FROM customer AS c
    LEFT JOIN payment AS p
        ON p.customer_id = c.customer_id
    GROUP BY c.customer_id
)
SELECT
    (SELECT COUNT(*) FROM customer) AS expected_customer_rows,
    COUNT(*) AS actual_output_rows,
    COUNT(DISTINCT customer_id) AS distinct_customer_count
FROM output;

-- Validation 2: summed customer revenue should reconcile to payment detail.
WITH customer_revenue AS (
    SELECT
        customer_id,
        SUM(amount) AS lifetime_revenue
    FROM payment
    GROUP BY customer_id
)
SELECT
    (SELECT SUM(amount) FROM payment) AS payment_detail_total,
    SUM(lifetime_revenue) AS customer_summary_total,
    (SELECT SUM(amount) FROM payment) - SUM(lifetime_revenue) AS difference
FROM customer_revenue;

-- Validation 3: rental counts by customer should reconcile to rental detail.
WITH customer_rentals AS (
    SELECT
        customer_id,
        COUNT(*) AS rental_count
    FROM rental
    GROUP BY customer_id
)
SELECT
    (SELECT COUNT(*) FROM rental) AS rental_detail_count,
    SUM(rental_count) AS customer_rental_count,
    (SELECT COUNT(*) FROM rental) - SUM(rental_count) AS difference
FROM customer_rentals;
