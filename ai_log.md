# AI-Assisted Prompting Log

> Important: The prompts below are ready-to-use drafts. Before submission, replace any wording as needed so this file records the exact prompts actually used by the learner, and retain the concrete verification evidence from the learner's own run.

## Prompt #1 — SQL (RCTCF)

**Role:** Act as a SQL analyst helping me debug a SQLite query for a BigBasket category-performance diagnostic.

**Context:** I have a SQLite database named `bigbasket_capstone.db` with `orders`, `products`, `customers`, and `category_targets`. Delivered orders should be used for revenue reporting. SQLite uses `strftime('%Y-%m', order_date)` for month extraction. The category target table contains six fixed targets.

**Task:** Help me write/debug the SQL query that joins category-level Delivered revenue to `category_targets` and calculates `variance = target_revenue_inr - total_revenue` and `percentage_variance = ((total_revenue - target_revenue_inr) * 100.0) / target_revenue_inr`, then tags each category as Above Target, Below Target - Watch when the shortfall is within 15%, or Below Target - Critical otherwise.

**Constraints:** Use SQLite syntax; keep the query runnable as written; do not change the database seed or source data; avoid integer-division truncation by using `100.0`; use the exact category target values already stored in the database.

**Format:** Return one complete SQL query followed by a short explanation of the key expressions and one validation checklist.

**Verification step performed for this build:** The query was run against `bigbasket_capstone.db`; the resulting category totals were checked against the required Part 2 SQL totals, including Household Essentials 21,715, Personal Care 16,382, Bakery 15,410, Dairy & Eggs 14,090, Snacks & Beverages 10,895, and Fruits & Vegetables 9,790.

## Prompt #2 — Pandas (RCTCF)

**Role:** Act as a Pandas data-cleaning analyst helping me debug an IQR outlier-capping step.

**Context:** I am cleaning `orders_raw.csv`, a deliberately messy export containing duplicate `order_id` rows, inconsistent casing/whitespace, missing `amount_inr`, and unusually large revenue values. Revenue analysis uses Delivered orders with non-null revenue only.

**Task:** Show me how to compute Q1 and Q3 with `.quantile()`, calculate `IQR = Q3 - Q1`, calculate the upper fence as `Q3 + 1.5 * IQR`, and cap Delivered revenue values above the fence using `.clip(upper=...)` without dropping rows.

**Constraints:** Use Pandas only; do not fill missing revenue with zero or a mean; do not drop outliers; calculate the fence only from Delivered, non-null `amount_inr`; keep the original row count after duplicate removal.

**Format:** Return concise Pandas code, explain each step, and include two quick checks that prove the cap was applied correctly.

**Verification step performed for this build:** The cleaning pipeline was executed on the generated raw export. It produced Q1 = 90.0, Q3 = 275.0, upper fence = 552.5, and capped 16 Delivered rows above the fence. The post-deduplication row count was exactly 500, and the top category/supplier were Household Essentials and HomeEssentials Traders respectively.
