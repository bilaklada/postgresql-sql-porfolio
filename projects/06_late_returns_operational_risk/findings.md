# Findings

This project turns rental duration rules into an operational risk summary. It is
important to separate late returned rentals from open rentals because they imply
different follow-up actions.

## What I would look for in the output

- categories with high late return rates within each store
- categories with both high late rate and high rental count
- open rental volume as a separate operational queue
- average days late for categories with enough late returns to matter

## Why this matters in an interview

This project helps me explain interval logic, operational flags, denominator
choice, and why a late-return rate should use returned rentals as the denominator
while open rentals are tracked separately.
