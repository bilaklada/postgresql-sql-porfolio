# Inventory and Demand Analysis

I use this project to compare available inventory copies with rental demand.
This is a good portfolio project because it forces me to handle films with no
inventory, inventory with no rentals, and demand metrics that require careful
division.

## Main SQL patterns

- left joins
- aggregation before classification
- `NULLIF` to avoid division by zero
- anti-join thinking
- reconciliation between rental detail and summary metrics
