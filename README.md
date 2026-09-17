# BigBasket Category Performance Diagnostic

## Overview

This capstone builds one deterministic BigBasket-style category-performance diagnostic across SQLite/SQL, a spreadsheet cross-check, Tableau Public, and Pandas. Part 1 creates the fixed database and exports `monthly_category_revenue.csv`; Part 2 rebuilds category totals from that exact CSV; Part 3 uses the same CSV for the Tableau dashboard and data story; Part 4 independently cleans the deliberately messy raw export and cross-validates the top category and supplier.

## Repository structure

```text
.
├── generate_data.py
├── bigbasket_capstone.db
├── orders_raw.csv
├── products.csv
├── verify.sql
├── 01_foundations.sql
├── 02_aggregation_joins.sql
├── 03_reporting.sql
├── monthly_category_revenue.csv
├── bigbasket_category_crosscheck.xlsx
├── analysis.ipynb
├── ai_log.md
├── DATA_STORY.md
└── README.md
```

## Part 1 — SQL

Run the deterministic generator exactly as provided:

```bash
python3 generate_data.py
```

It creates the SQLite database and the two raw CSV exports.

- Verification queries: `verify.sql`
- Foundational SQL: `01_foundations.sql`
- Aggregation and joins: `02_aggregation_joins.sql`
- Reporting, CASE tiers, monthly report, and target variance: `03_reporting.sql`
- Fixed Part 2/3 input: `monthly_category_revenue.csv`

The exported monthly report contains **36 rows** and a grand total Delivered revenue of **INR 88,282**.

## Part 2 — Spreadsheet

Workbook: `bigbasket_category_crosscheck.xlsx`

Sheets:
1. `Monthly Data` — direct import of `monthly_category_revenue.csv`
2. `Category Targets` — fixed target table
3. `Pivot Table` — category-level SUM reproduction
4. `Category Summary` — target lookup, variance, percentage variance, tier, and reconciliation

**Final submission check:** The brief requires a native working Pivot Table created from `Monthly Data`. If your grading environment checks for a native spreadsheet pivot object, recreate the `Pivot Table` sheet as an actual Google Sheets/Excel Pivot Table and download the workbook as `.xlsx` before submission. The supplied workbook provides the same category totals/formula structure as a starting point.

## Part 3 — Tableau Public

Create one public Tableau Public dashboard from `monthly_category_revenue.csv` containing:
- Jan–Jun 2026 monthly Delivered revenue trend
- descending category revenue bar chart
- three target-status categories
- four KPI cards
- one dashboard-wide interactive filter

**Live Tableau Public dashboard:** https://prod-in-a.online.tableau.com/#/site/namratagchavan75885-3b12d132d6/workbooks/1573712?:origin=card_share_link

The live URL must be replaced with the actual public Tableau Public URL after publishing.

Data story: [`DATA_STORY.md`](DATA_STORY.md)

## Part 4 — Python/Pandas

Notebook: `analysis.ipynb`

The notebook:
- inspects the raw export
- removes duplicate `order_id` rows
- normalizes city/category casing
- counts and excludes missing revenue from revenue calculations
- leaves legitimate rating nulls unchanged
- calculates and caps IQR outliers
- creates date/derived fields
- merges products to suppliers
- finds the top category and supplier
- contains three matplotlib charts
- contains exactly three What / Why it matters / Next step observations

The cleaned analysis cross-validates to:
- Top category: **Household Essentials**
- Top supplier: **HomeEssentials Traders**

## AI-assisted prompting

See [`ai_log.md`](ai_log.md) for the two RCTCF-structured prompts and verification notes.

## Reproducibility

Do not change `random.seed(42)` or the fixed lists/weights in `generate_data.py`. The acceptance criteria depend on the exact deterministic dataset.

## Submission

Submit **one public GitHub repository link** containing all required artifacts above. No screenshots, PDFs, slides, videos, or audio files are required by the brief.
