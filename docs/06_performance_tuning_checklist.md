# Performance Tuning Checklist

This portfolio is not a production tuning case study, but I want my SQL to show
practical performance awareness.

## Before tuning

- Confirm the query answers the right business question.
- Confirm the intended grain.
- Check whether joins multiply rows.
- Compare summary totals against detail totals.
- Run `ANALYZE` if local table statistics may be stale.

## When reading EXPLAIN

I look for:

- scan type: sequential scan, index scan, bitmap scan
- join type: nested loop, hash join, merge join
- estimated rows versus actual rows
- sort and aggregation steps
- filters applied late in the plan
- repeated loops with unexpectedly high row counts

## Index questions

Before adding an index, I ask:

- Is the table large enough for the index to matter?
- Is the predicate selective?
- Is the column used for joins, filtering, or ordering?
- Will the index support a real query pattern?
- Does the index add write overhead without enough read benefit?

## PostgreSQL examples in this repo

The database object scripts include examples for:

- indexing common join and filter columns
- using expression indexes
- using GIN indexes for JSONB and full-text search
- comparing plans before and after a targeted index
- materializing a repeated analytical summary

## Practical position

I do not treat indexes as decoration. I want each index to have a reason tied to
a query shape.
