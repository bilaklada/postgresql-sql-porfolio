-- =========================================================
-- Project: Rental Retention and Cohorts
-- Goal: Build a customer rental cohort retention table.
-- Dataset: dvdrental
-- Grain: one row per cohort month and month offset.
-- =========================================================

WITH first_rental AS (
    SELECT
        r.customer_id,
        DATE_TRUNC('month', MIN(r.rental_date))::date AS cohort_month
    FROM rental AS r
    GROUP BY r.customer_id
),
customer_activity AS (
    SELECT DISTINCT
        r.customer_id,
        DATE_TRUNC('month', r.rental_date)::date AS activity_month
    FROM rental AS r
),
cohort_activity AS (
    SELECT
        fr.cohort_month,
        ca.activity_month,
        (
            EXTRACT(YEAR FROM AGE(ca.activity_month, fr.cohort_month)) * 12
            + EXTRACT(MONTH FROM AGE(ca.activity_month, fr.cohort_month))
        )::integer AS months_since_first_rental,
        ca.customer_id
    FROM first_rental AS fr
    INNER JOIN customer_activity AS ca
        ON ca.customer_id = fr.customer_id
       AND ca.activity_month >= fr.cohort_month
),
cohort_sizes AS (
    SELECT
        cohort_month,
        COUNT(*) AS cohort_size
    FROM first_rental
    GROUP BY cohort_month
),
retention AS (
    SELECT
        ca.cohort_month,
        ca.months_since_first_rental,
        COUNT(DISTINCT ca.customer_id) AS active_customers
    FROM cohort_activity AS ca
    GROUP BY
        ca.cohort_month,
        ca.months_since_first_rental
)
SELECT
    r.cohort_month,
    r.months_since_first_rental,
    cs.cohort_size,
    r.active_customers,
    ROUND(r.active_customers::numeric / NULLIF(cs.cohort_size, 0), 4) AS retention_rate
FROM retention AS r
INNER JOIN cohort_sizes AS cs
    ON cs.cohort_month = r.cohort_month
ORDER BY
    r.cohort_month,
    r.months_since_first_rental;
