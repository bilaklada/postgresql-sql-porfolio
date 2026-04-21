# SQL Portfolio Learning Roadmap

## Purpose of this document

This document defines the structure of the repository and the logic behind the learning progression.

The repository is not meant to be a random collection of SQL files. It is meant to show disciplined growth from foundational SQL toward advanced analytical and PostgreSQL-specific work.

The progression is designed around four ideas:

1. understand relational data before writing complex queries
2. write readable and maintainable SQL
3. validate results instead of trusting the first output
4. connect SQL techniques to realistic business questions

---

## Stage 1 — Foundations

Goal:
Build a reliable base in core SQL syntax and basic analytical thinking.

Topics:
- `SELECT`
- `WHERE`
- `ORDER BY`
- `GROUP BY`
- `HAVING`
- `CASE WHEN`
- `NULL` handling
- dates and timestamps
- simple aggregations

Expected outcome:
The author can write clear basic queries and understands the difference between row-level filtering and aggregated analysis.

---

## Stage 2 — Joins and relational thinking

Goal:
Understand how tables relate to each other and how joins affect row counts, duplicates, and missing values.

Topics:
- `INNER JOIN`
- `LEFT JOIN`
- self joins
- multi-table joins
- `EXISTS`
- `NOT EXISTS`
- semi-joins
- anti-joins
- duplication risks after joins

Expected outcome:
The author can safely combine multiple tables and explain why a join does or does not preserve the expected grain of the result.

---

## Stage 3 — Advanced query construction

Goal:
Break down more complex logic into structured SQL steps.

Topics:
- subqueries
- correlated subqueries
- CTEs
- recursive CTEs
- set operations
- `LATERAL`
- reusable analytical patterns

Expected outcome:
The author can write multi-step SQL in a way that remains readable and logically controlled.

---

## Stage 4 — Analytical SQL

Goal:
Use SQL for ranking, comparisons, segmentation, and time-aware analysis.

Topics:
- window functions
- ranking functions
- running totals
- `LAG` and `LEAD`
- top-N per group
- percentiles
- customer and revenue segmentation

Expected outcome:
The author can solve realistic analytical tasks using SQL instead of relying only on spreadsheets or external tools.

---

## Stage 5 — Database objects and PostgreSQL depth

Goal:
Show awareness of how SQL fits into database engineering, not only analysis.

Topics:
- views
- materialized views
- constraints
- indexes
- `EXPLAIN`
- `EXPLAIN ANALYZE`
- transactions
- `ON CONFLICT`
- `MERGE`
- `JSONB`
- schema and catalog introspection

Expected outcome:
The author can discuss how PostgreSQL supports reliable and maintainable data work beyond writing a single query.

---

## Stage 6 — Validation and professional habits

Goal:
Treat SQL as a professional workflow where outputs must be checked and defended.

Topics:
- row-count checks
- duplicate detection
- reconciliation queries
- null audits
- foreign key consistency checks
- edge-case validation for windows and aggregations

Expected outcome:
The author does not present results without checking whether they are trustworthy.

---

## Stage 7 — Portfolio case studies

Goal:
Turn technical SQL knowledge into portfolio-grade business examples.

Case studies should include:
- business question
- stakeholder perspective
- tables used
- grain of analysis
- assumptions
- main SQL solution
- validation queries
- findings summary

Expected outcome:
The repository becomes useful in interviews because it shows not only syntax, but also analytical reasoning and communication.

---

## How this roadmap should shape the repository

Each folder should represent a real stage of maturity.

The repo should move from:
- isolated syntax practice

toward:
- structured analytical modules
- validation-driven SQL
- PostgreSQL-specific demonstrations
- interview-ready business projects

This is the core principle of the repository:
**clean SQL, clear logic, validated outputs, and visible relational understanding.**