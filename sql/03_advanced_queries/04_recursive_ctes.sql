-- =========================================================
-- File: 04_recursive_ctes.sql
-- Goal: Demonstrate recursive CTEs with PostgreSQL.
-- Dataset: dvdrental
-- Grain: one row per generated date or hierarchy step.
-- Notes: dvdrental has limited hierarchy, so date spine generation is useful.
-- =========================================================

-- Generate a daily date spine across the rental period.
WITH RECURSIVE date_spine AS (
    SELECT MIN(rental_date)::date AS rental_date
    FROM rental
    UNION ALL
    SELECT rental_date + 1
    FROM date_spine
    WHERE rental_date < (
        SELECT MAX(rental_date)::date
        FROM rental
    )
)
SELECT
    ds.rental_date::date AS rental_date,
    COUNT(r.rental_id) AS rental_count
FROM date_spine AS ds
LEFT JOIN rental AS r
    ON r.rental_date::date = ds.rental_date::date
GROUP BY ds.rental_date
ORDER BY ds.rental_date;

-- Generate a small number series for bucket labels used in analysis demos.
WITH RECURSIVE buckets AS (
    SELECT 1 AS bucket_number
    UNION ALL
    SELECT bucket_number + 1
    FROM buckets
    WHERE bucket_number < 5
)
SELECT
    bucket_number,
    CONCAT('bucket_', bucket_number) AS bucket_label
FROM buckets;

-- Recursive traversal of a small synthetic reporting chain using staff/store data.
WITH RECURSIVE staff_chain AS (
    SELECT
        s.staff_id,
        s.first_name,
        s.last_name,
        st.manager_staff_id,
        1 AS depth
    FROM staff AS s
    INNER JOIN store AS st
        ON st.manager_staff_id = s.staff_id
    UNION ALL
    SELECT
        s.staff_id,
        s.first_name,
        s.last_name,
        sc.manager_staff_id,
        sc.depth + 1 AS depth
    FROM staff AS s
    INNER JOIN staff_chain AS sc
        ON s.staff_id = sc.manager_staff_id
    WHERE sc.depth < 2
)
SELECT DISTINCT
    staff_id,
    first_name,
    last_name,
    depth
FROM staff_chain
ORDER BY
    depth,
    staff_id;
