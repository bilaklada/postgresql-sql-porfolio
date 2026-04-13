-- =========================================================
-- File: 06_left_join.sql
-- Database: PostgreSQL / dvdrental
-- Topic: LEFT JOIN
-- Purpose: Practice outer joins, NULL-aware filtering,
--          zero-preserving aggregations, and optional
--          relationships across transactional tables.
-- Author: Lada Bilak
-- =========================================================

-- =========================================================
-- Section 1: Identifying missing related records
-- =========================================================

-- ---------------------------------------------------------
-- 1. Find customers who never made a payment
-- Goal: Return customer records for which no matching
--       payment row exists.
-- ---------------------------------------------------------


-- ---------------------------------------------------------
-- 2. Find customers who never rented any film
-- Goal: Return customer records for which no matching
--       rental row exists.
-- ---------------------------------------------------------


-- ---------------------------------------------------------
-- 3. Show every customer together with number of payments
-- Goal: Preserve all customers, including those with zero
--       payments.
-- ---------------------------------------------------------


-- ---------------------------------------------------------
-- 4. Show every customer together with total amount paid
-- Goal: Preserve all customers and replace missing totals
--       with zero.
-- ---------------------------------------------------------


-- ---------------------------------------------------------
-- 5. Find films never added to inventory
-- Goal: Return films for which no inventory row exists.
-- ---------------------------------------------------------


-- ---------------------------------------------------------
-- 6. Find films present in inventory but never rented
-- Goal: Return film records that have inventory entries but
--       no matching rentals.
-- ---------------------------------------------------------


-- ---------------------------------------------------------
-- 7. Show every film together with number of rentals
-- Goal: Preserve films with zero rentals.
-- ---------------------------------------------------------


-- ---------------------------------------------------------
-- 8. Show every category together with number of films
-- Goal: Preserve categories with zero related films.
-- ---------------------------------------------------------


-- ---------------------------------------------------------
-- 9. Show every language together with number of films
-- Goal: Preserve languages with zero related films.
-- ---------------------------------------------------------

-- =========================================================
-- Section 2: LEFT JOIN with conditional absence logic
-- =========================================================

-- ---------------------------------------------------------
-- 10. Find customers who rented films but never made payment
-- Goal: Return customers with at least one rental and no
--       matching payment rows.
-- ---------------------------------------------------------


-- ---------------------------------------------------------
-- 11. Show every staff member together with payment count
-- Goal: Preserve staff members with zero handled payments.
-- ---------------------------------------------------------


-- ---------------------------------------------------------
-- 12. Show every store together with customer count
-- Goal: Preserve stores with zero customers.
-- ---------------------------------------------------------


-- ---------------------------------------------------------
-- 13. Show every store together with staff count
-- Goal: Preserve stores with zero staff members.
-- ---------------------------------------------------------


-- ---------------------------------------------------------
-- 14. Find customers with no payment greater than 8
-- Goal: Keep customers whose maximum qualifying payment does
--       not exceed 8, including customers with no payments.
-- ---------------------------------------------------------


-- ---------------------------------------------------------
-- 15. Show every customer with number of payments above 8
-- Goal: Count only high-value payments while preserving
--       customers with none.
-- ---------------------------------------------------------


-- ---------------------------------------------------------
-- 16. Find inventory films that were never rented
-- Goal: Return films in inventory that have no rental rows,
--       including useful inventory identifiers.
-- ---------------------------------------------------------


-- ---------------------------------------------------------
-- 17. Show every customer with most recent payment date
-- Goal: Preserve customers with no payments.
-- ---------------------------------------------------------


-- ---------------------------------------------------------
-- 18. Show every customer with first rental date
-- Goal: Preserve customers with no rentals.
-- ---------------------------------------------------------


-- =========================================================
-- Section 3: Category and film absence analysis
-- =========================================================

-- ---------------------------------------------------------
-- 19. Find categories for which no film was ever rented
-- Goal: Return categories that have no rental activity
--       through their related films.
-- ---------------------------------------------------------


-- ---------------------------------------------------------
-- 20. Show every category with number of distinct rented films
-- Goal: Preserve categories with zero rented films.
-- ---------------------------------------------------------


-- ---------------------------------------------------------
-- 21. Show every film together with total revenue
-- Goal: Preserve films with zero revenue.
-- ---------------------------------------------------------


-- ---------------------------------------------------------
-- 22. Find customers who made payments but never rented
-- Goal: Return customers that appear in payments but have no
--       rental records.
-- ---------------------------------------------------------


-- =========================================================
-- Section 4: Classification flags and combined metrics
-- =========================================================

-- ---------------------------------------------------------
-- 23. Show every customer with payment status flag
-- Goal: Classify customers as having payments or not.
-- ---------------------------------------------------------


-- ---------------------------------------------------------
-- 24. Show every film with rental status flag
-- Goal: Classify films as rented or never rented.
-- ---------------------------------------------------------


-- ---------------------------------------------------------
-- 25. Show every customer with rental count and payment count
-- Goal: Preserve customers even when one or both metrics are
--       zero.
-- Note: Pre-aggregation is used to avoid row multiplication
--       from joining rental and payment directly.
-- ---------------------------------------------------------
