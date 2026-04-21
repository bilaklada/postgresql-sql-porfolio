-- =========================================================
-- Project: Store Revenue and Staff Performance
-- Goal: Summarize revenue by inventory store and payment staff.
-- Dataset: dvdrental
-- Grain: one row per store and staff member.
-- =========================================================

WITH payment_detail AS (
    SELECT
        p.payment_id,
        p.amount,
        p.payment_date,
        p.staff_id,
        r.rental_id,
        i.store_id AS rental_store_id
    FROM payment AS p
    INNER JOIN rental AS r
        ON r.rental_id = p.rental_id
    INNER JOIN inventory AS i
        ON i.inventory_id = r.inventory_id
),
staff_store_summary AS (
    SELECT
        pd.rental_store_id,
        pd.staff_id,
        COUNT(pd.payment_id) AS payment_count,
        COUNT(DISTINCT pd.rental_id) AS paid_rental_count,
        SUM(pd.amount) AS total_revenue,
        ROUND(AVG(pd.amount), 2) AS avg_payment_amount,
        MIN(pd.payment_date)::date AS first_payment_date,
        MAX(pd.payment_date)::date AS last_payment_date
    FROM payment_detail AS pd
    GROUP BY
        pd.rental_store_id,
        pd.staff_id
)
SELECT
    sss.rental_store_id AS store_id,
    s.staff_id,
    s.first_name,
    s.last_name,
    sss.payment_count,
    sss.paid_rental_count,
    sss.total_revenue,
    sss.avg_payment_amount,
    sss.first_payment_date,
    sss.last_payment_date,
    DENSE_RANK() OVER (
        PARTITION BY sss.rental_store_id
        ORDER BY sss.total_revenue DESC
    ) AS staff_rank_in_store
FROM staff_store_summary AS sss
INNER JOIN staff AS s
    ON s.staff_id = sss.staff_id
ORDER BY
    store_id,
    staff_rank_in_store,
    s.staff_id;
