# Late Returns Operational Risk

I use this project to analyze late returns using film rental duration rules.
The goal is to connect SQL date logic with an operational question.

The project distinguishes returned rentals, late returned rentals, and currently
open rentals. That distinction prevents me from treating all missing return
dates as late without context.

## Main SQL patterns

- interval arithmetic
- `CASE` flags
- joins across rental, inventory, film, customer, and store
- operational aggregation
- validation of date assumptions
