# Database Setup

I develop this portfolio against a local PostgreSQL instance. The examples are
written for PostgreSQL 15 or newer because a small number of files reference
`MERGE`, while the rest of the repository works on older supported versions.

## Create a local database

```bash
createdb dvdrental
```

If I want to start from a clean database:

```bash
dropdb --if-exists dvdrental
createdb dvdrental
```

## Connect with psql

```bash
psql -d dvdrental
```

Useful `psql` settings while reviewing query output:

```sql
\pset null '[NULL]'
\x auto
\timing on
```

## Repository assumptions

- The main schema is `public`.
- The primary dataset is `dvdrental`.
- Portfolio-created examples use a separate `portfolio` schema where possible.
- Reset logic lives in `setup/04_reset_environment.sql`.

I keep setup work explicit because interview discussions often move quickly
from "can you write the query" to "can you explain the environment and the
assumptions behind the output."
