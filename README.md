# PostgreSQL SQL Portfolio

I use this repository to show practical PostgreSQL work against a relational
sample database: clear SQL, controlled joins, analytical queries, validation
checks, and concise project writeups.

This is a personal technical portfolio for job applications. My goal is to show
that I can reason through relational data, write SQL that another engineer can
review, and defend analytical results with validation rather than only returning
the first query output.

## Why This Repository Exists

I built this portfolio to make my SQL practice visible and structured. The work
is intentionally compact: it is not a dump of every exercise I have ever written.
It focuses on the PostgreSQL skills I want to discuss in interviews:

- SQL fundamentals and readable query structure
- joins, grain control, and relationship awareness
- aggregations, subqueries, CTEs, and recursive CTEs
- window functions for ranking, running totals, and period comparison
- `EXISTS`, `NOT EXISTS`, anti-joins, set operations, and `LATERAL`
- views, materialized views, constraints, transactions, indexing, and explain plans
- PostgreSQL features such as JSONB, full-text search, metadata queries, and partitioning demos
- validation checks for row counts, nulls, duplicates, and foreign-key logic
- business-style analysis using realistic questions from the `dvdrental` schema

## Dataset Strategy

The primary dataset is `dvdrental`. It is small enough to inspect directly, but
it has enough relationships to practice real SQL habits:

- customers rent inventory items
- inventory connects stores to films
- films connect to categories and actors through bridge tables
- payments connect customers, rentals, staff, and revenue
- stores, staff, addresses, cities, and countries provide dimensional context

Pagila is documented as optional setup only. I keep `dvdrental` as the main
dataset so the portfolio stays focused and easy to review.

## Repository Structure

```text
.
├── setup/                  # Local database setup and cleanup
├── docs/                   # Portfolio documentation and SQL working notes
├── sql/                    # Topic-based PostgreSQL scripts
├── projects/               # Business-oriented portfolio case studies
├── interview/              # Talking points and interview preparation
├── assets/                 # Optional ERDs, screenshots, and diagrams
└── results/                # Optional curated outputs and explain plans
```

## Topics Covered

The `sql/` folder is organized as a progression:

- `00_schema_introspection`: table inventory, keys, relationships, and baseline quality checks
- `01_foundations`: SELECT, filtering, ordering, aggregation, CASE, NULL logic, and dates
- `02_joins`: inner joins, outer joins, self joins, semi-joins, anti-joins, and join pitfalls
- `03_advanced_queries`: subqueries, correlated subqueries, CTEs, recursion, set operations, and LATERAL
- `04_analytics`: ranking, running totals, lag/lead, percentiles, top-N, and segmentation
- `05_database_objects`: views, materialized views, constraints, indexes, explain plans, transactions, upserts, and merge patterns
- `06_postgresql_specific`: JSONB, full-text search, partitioning, and catalog metadata
- `07_quality_checks`: row-count checks, null checks, duplicate detection, and FK consistency checks

## Portfolio Projects

The `projects/` folder contains six case studies. Each project includes the
business question, stakeholder perspective, tables used, analysis grain, metric
definitions, assumptions, SQL solution, validation queries, findings, and
interview value.

| Project | Focus |
| --- | --- |
| Customer Lifetime Value | Customer revenue, rental activity, recency, and segmentation |
| Store Revenue and Staff Performance | Store-level revenue and staff handling patterns |
| Inventory and Demand Analysis | Film inventory coverage, rental demand, and underused stock |
| Rental Retention and Cohorts | First rental month, repeat behavior, and cohort retention |
| Top Films, Categories, and Rankings | Window functions, category rankings, and revenue leaders |
| Late Returns Operational Risk | Return timing, late rental flags, and operational risk patterns |

## How To Run Locally

1. Install PostgreSQL.
2. Create a local database.

```bash
createdb dvdrental
```

3. Restore the `dvdrental` sample database.

```bash
pg_restore --dbname=dvdrental --verbose dvdrental.tar
```

4. Enable optional extensions used in PostgreSQL-specific examples.

```bash
psql -d dvdrental -f setup/03_extensions.sql
```

5. Run any SQL file with `psql`.

```bash
psql -d dvdrental -f sql/00_schema_introspection/01_tables_columns.sql
psql -d dvdrental -f projects/01_customer_lifetime_value/solution.sql
```

6. Remove portfolio-created database objects when needed.

```bash
psql -d dvdrental -f setup/04_reset_environment.sql
```

## Query Style Principles

I write SQL in this repository with a few consistent habits:

- define the intended grain before aggregating
- use explicit column lists instead of `SELECT *` in portfolio queries
- use table aliases that are short but understandable
- keep join logic close to the tables being joined
- split multi-step analysis into CTEs when it improves readability
- avoid clever SQL when a direct query is easier to review
- add validation queries for important outputs

## Validation Philosophy

I treat validation as part of SQL work. In this repository, validation usually
means checking one or more of the following:

- whether joins changed the expected row count
- whether a bridge table introduced duplicate rows
- whether nulls are expected or signal missing relationship coverage
- whether totals reconcile between detail rows and summaries
- whether analytical flags match the metric definitions
- whether foreign-key relationships behave as expected

This is important because a query can be syntactically correct and still answer
the wrong question.

## Performance And Optimization Awareness

This portfolio is not a production tuning project, but it includes practical
PostgreSQL performance habits:

- reading `EXPLAIN` and `EXPLAIN ANALYZE`
- understanding sequential scans, index scans, joins, sorting, and aggregation
- adding indexes only for a clear access pattern
- considering selectivity and join keys
- using materialized views when repeated analytical summaries are worth storing
- keeping query clarity and correctness ahead of premature optimization

## Interview Value

I use this portfolio to talk through how I approach SQL work:

- how I identify the correct analysis grain
- how I decide between joins, subqueries, CTEs, and window functions
- how I validate a result before presenting it
- how I use PostgreSQL features beyond basic SELECT queries
- how I translate a business question into a reproducible SQL solution

The interview folder contains concise talking points and a question bank tied
directly to the repository content.

## Future Roadmap

Future improvements should stay focused:

- add a small ERD image generated from the local `dvdrental` schema
- add curated sample outputs for the six portfolio projects
- save a few representative explain plans after running the queries locally
- optionally add a Pagila comparison only if it demonstrates PostgreSQL features not already covered

## Author

This is my personal PostgreSQL SQL portfolio.

- Git author: Lada Bilak
- Focus: SQL, PostgreSQL, analytics engineering fundamentals, and reliable data analysis
