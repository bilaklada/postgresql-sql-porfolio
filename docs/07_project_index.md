# Project Index

The projects folder contains six focused portfolio case studies. I use them to
connect SQL technique to business-style questions without pretending the sample
database is a real company dataset.

| Project | Main SQL patterns | Business focus |
| --- | --- | --- |
| `01_customer_lifetime_value` | CTEs, aggregation, segmentation, validation | customer value and recency |
| `02_store_revenue_and_staff_performance` | multi-table joins, grouping, ranking | store and staff revenue handling |
| `03_inventory_and_demand_analysis` | left joins, demand ratios, anti-join checks | inventory coverage and rental demand |
| `04_rental_retention_and_cohorts` | date truncation, cohorts, windows | repeat rental behavior |
| `05_top_films_categories_and_rankings` | ranking windows, category metrics | film and category performance |
| `06_late_returns_operational_risk` | date logic, CASE, aggregation | late returns and operational follow-up |

## Common project structure

Each project includes:

- `README.md`: overview and how I frame the work
- `question.md`: business question, stakeholder, metrics, and assumptions
- `solution.sql`: main SQL solution
- `validation.sql`: checks that support the output
- `findings.md`: concise findings and interview value

## How I use these projects in interviews

I can talk through one project end to end:

1. define the question
2. identify tables and grain
3. write the query in steps
4. validate the result
5. explain what the output means and what it does not prove
