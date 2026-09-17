# Part 3 — Python/Pandas Analysis

## Cleaning and IQR results
- Raw rows loaded: **508**
- Exact duplicate rows removed: **8**
- Rows remaining: **500**
- Distinct cities after cleaning: **4**
- Distinct categories after cleaning: **6**
- Missing `amount_inr` rows: **10**; these were excluded from revenue sums, not filled.
- `Cancelled`/`Pending` rating nulls were left unfilled because those orders do not have a rating in the raw export.
- Q1: **₹90.00**
- Q3: **₹275.00**
- IQR: **₹185.00**
- Upper fence: **₹552.50**
- Rows capped using `.clip(upper=...)`: **16**

## Business findings
- Top category by cleaned Delivered revenue: **Household Essentials — ₹20,910.00**
- Top supplier by cleaned Delivered revenue: **HomeEssentials Traders — ₹20,910.00**
- Cross-validation with Part 1: **Yes** — top category matches `Household Essentials` and top supplier matches `HomeEssentials Traders`.

## Exactly 3 insights

### 1
**What:** Household Essentials generated **₹20,910.00**, or **24.7%** of cleaned Delivered revenue.  
**Why it matters:** It is the largest revenue contributor in the cleaned analysis.  
**Next step:** Review its product-level and supplier-level contribution to identify the main drivers of this result.

### 2
**What:** **HomeEssentials Traders** generated the highest cleaned supplier revenue at **₹20,910.00**.  
**Why it matters:** Supplier-level contribution can help explain where category revenue is concentrated.  
**Next step:** Compare this supplier's revenue with the remaining suppliers and inspect its associated categories/products.

### 3
**What:** **May** recorded the highest cleaned Delivered monthly revenue at **₹16,668.50**.  
**Why it matters:** The monthly peak identifies a period where demand or order mix was strongest in this dataset.  
**Next step:** Break that month down by category and supplier to identify the contributors to the peak.
