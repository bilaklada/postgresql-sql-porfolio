# Findings

This project creates a cohort table that can be read across time: month zero is
the first rental month, and later month offsets show repeat activity.

## What I would look for in the output

- cohort sizes by first rental month
- retention drop-off after month zero
- whether earlier cohorts have more observable follow-up periods
- whether later cohorts should be excluded from long-window comparisons

## Why this matters in an interview

This project helps me explain time-based grain, `COUNT(DISTINCT ...)`, cohort
assignment, and validation of retention math. It also shows that I understand
right-censoring in a limited historical dataset.
