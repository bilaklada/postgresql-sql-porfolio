-- =========================================================
-- Project: Rental Retention and Cohorts
-- Goal: Validate cohort assignment and retention math.
-- Dataset: dvdrental
-- =========================================================

-- Validation 1: every renting customer has exactly one cohort month.
WITH first_rental AS (
    SELECT
        customer_id,
        DATE_TRUNC('month', MIN(rental_date))::date AS cohort_month
    FROM rental
    GROUP BY customer_id
)
SELECT
    (SELECT COUNT(DISTINCT customer_id) FROM rental) AS renting_customers,
    COUNT(*) AS cohort_rows,
    COUNT(DISTINCT customer_id) AS distinct_customers
FROM first_rental;

-- Validation 2: month zero active customers should equal cohort size.
WITH first_rental AS (
    SELECT
        customer_id,
        DATE_TRUNC('month', MIN(rental_date))::date AS cohort_month
    FROM rental
    GROUP BY customer_id
),
month_zero AS (
    SELECT
        fr.cohort_month,
        COUNT(DISTINCT fr.customer_id) AS month_zero_customers
    FROM first_rental AS fr
    INNER JOIN rental AS r
        ON r.customer_id = fr.customer_id
       AND DATE_TRUNC('month', r.rental_date)::date = fr.cohort_month
    GROUP BY fr.cohort_month
),
cohort_sizes AS (
    SELECT
        cohort_month,
        COUNT(*) AS cohort_size
    FROM first_rental
    GROUP BY cohort_month
)
SELECT
    cs.cohort_month,
    cs.cohort_size,
    mz.month_zero_customers,
    cs.cohort_size - mz.month_zero_customers AS difference
FROM cohort_sizes AS cs
INNER JOIN month_zero AS mz
    ON mz.cohort_month = cs.cohort_month
ORDER BY cs.cohort_month;

-- Validation 3: no activity month should be before cohort month.
WITH first_rental AS (
    SELECT
        customer_id,
        DATE_TRUNC('month', MIN(rental_date))::date AS cohort_month
    FROM rental
    GROUP BY customer_id
),
customer_activity AS (
    SELECT DISTINCT
        customer_id,
        DATE_TRUNC('month', rental_date)::date AS activity_month
    FROM rental
)
SELECT
    COUNT(*) AS invalid_activity_rows
FROM first_rental AS fr
INNER JOIN customer_activity AS ca
    ON ca.customer_id = fr.customer_id
WHERE ca.activity_month < fr.cohort_month;
