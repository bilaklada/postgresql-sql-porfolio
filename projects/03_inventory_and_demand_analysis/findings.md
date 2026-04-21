# Findings

This project separates three different situations that can look similar in a
simple report: no inventory, inventory with no rental activity, and inventory
with low rentals per copy.

## What I would look for in the output

- films with zero inventory
- films with inventory but no rentals
- high rentals per copy, which may suggest constrained stock
- low rentals per copy, which may suggest slow-moving inventory

## Why this matters in an interview

This project gives me a clear way to discuss left joins, zero-safe division,
anti-join checks, and the difference between demand history and demand forecast.
