-- =========================================================
-- Project: Late Returns Operational Risk
-- Goal: Validate late-return logic and date assumptions.
-- Dataset: dvdrental
-- =========================================================

-- Validation 1: no returned rental should have return_date before rental_date.
SELECT
    COUNT(*) AS return_before_rental_count
FROM rental
WHERE return_date < rental_date;

-- Validation 2: late + on-time + open should reconcile to rental detail.
WITH rental_flags AS (
    SELECT
        r.rental_id,
        CASE
            WHEN r.return_date IS NULL THEN 'open'
            WHEN r.return_date > r.rental_date + (f.rental_duration * INTERVAL '1 day') THEN 'late'
            ELSE 'on_time'
        END AS return_status
    FROM rental AS r
    INNER JOIN inventory AS i
        ON i.inventory_id = r.inventory_id
    INNER JOIN film AS f
        ON f.film_id = i.film_id
)
SELECT
    (SELECT COUNT(*) FROM rental) AS rental_detail_count,
    COUNT(*) AS flagged_rental_count,
    (SELECT COUNT(*) FROM rental) - COUNT(*) AS difference
FROM rental_flags;

-- Validation 3: status distribution for interpretation.
WITH rental_flags AS (
    SELECT
        CASE
            WHEN r.return_date IS NULL THEN 'open'
            WHEN r.return_date > r.rental_date + (f.rental_duration * INTERVAL '1 day') THEN 'late'
            ELSE 'on_time'
        END AS return_status
    FROM rental AS r
    INNER JOIN inventory AS i
        ON i.inventory_id = r.inventory_id
    INNER JOIN film AS f
        ON f.film_id = i.film_id
)
SELECT
    return_status,
    COUNT(*) AS rental_count
FROM rental_flags
GROUP BY return_status
ORDER BY return_status;
