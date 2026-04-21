-- =========================================================
-- File: 02_full_text_search.sql
-- Goal: Use PostgreSQL full-text search against film descriptions.
-- Dataset: dvdrental
-- Grain: one row per matching film.
-- Notes: This demonstrates tsvector, tsquery, ranking, and GIN indexing.
-- =========================================================

BEGIN;

CREATE INDEX film_fulltext_demo_idx
    ON film
    USING gin (to_tsvector('english', title || ' ' || COALESCE(description, '')));

SELECT
    f.film_id,
    f.title,
    TS_RANK(
        to_tsvector('english', f.title || ' ' || COALESCE(f.description, '')),
        plainto_tsquery('english', 'drama story')
    ) AS search_rank
FROM film AS f
WHERE to_tsvector('english', f.title || ' ' || COALESCE(f.description, ''))
      @@ plainto_tsquery('english', 'drama story')
ORDER BY
    search_rank DESC,
    f.title
LIMIT 25;

EXPLAIN
SELECT
    f.film_id,
    f.title
FROM film AS f
WHERE to_tsvector('english', f.title || ' ' || COALESCE(f.description, ''))
      @@ plainto_tsquery('english', 'drama story');

ROLLBACK;
