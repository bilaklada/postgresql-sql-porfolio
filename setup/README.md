# Setup

I use this folder to keep database setup separate from the portfolio SQL.

The main dataset is `dvdrental`, the PostgreSQL sample database based on a
DVD rental business. It is compact enough to understand, but relational enough
to practice joins, window functions, constraints, indexing, validation checks,
and PostgreSQL-specific features.

## Files

- `00_database_setup.md`: local PostgreSQL prerequisites and database creation
- `01_load_dvdrental.md`: how I load the main dataset
- `02_load_pagila_optional.md`: optional notes for Pagila when extra PostgreSQL depth is useful
- `03_extensions.sql`: extensions used by selected examples
- `04_reset_environment.sql`: cleanup script for portfolio-created objects

I do not store large database dumps in this repository. I keep the repository
focused on SQL, documentation, and repeatable setup instructions.
