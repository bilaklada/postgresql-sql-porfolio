-- =========================================================
-- File: 04_reset_environment.sql
-- Goal: Remove database objects created by portfolio examples.
-- Dataset: dvdrental
-- Notes: This does not drop or modify dvdrental source tables.
-- =========================================================

DROP SCHEMA IF EXISTS portfolio CASCADE;

-- Extensions are left installed because they may be shared by other local work.
-- If I want to remove them manually:
-- DROP EXTENSION IF EXISTS pg_trgm;
-- DROP EXTENSION IF EXISTS unaccent;
