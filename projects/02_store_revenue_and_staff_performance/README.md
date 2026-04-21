# Store Revenue and Staff Performance

I use this project to analyze revenue by store and staff member. The goal is to
show careful multi-table joins across payments, rentals, inventory, stores, and
staff.

The project separates the store where the inventory item belongs from the staff
member who handled the payment, because those are related but not identical
concepts.

## Main SQL patterns

- multi-table joins
- grouping by store and staff
- window ranking within store
- revenue reconciliation
- row-count validation after joins
