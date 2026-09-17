# BigBasket Capstone — Part 3 Pandas Analysis
import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv("orders_raw.csv")
products = pd.read_csv("products.csv")

df = df.drop_duplicates().copy()
df["city"] = df["city"].astype(str).str.strip().str.title()
df["category"] = df["category"].astype(str).str.strip().str.title()
df["amount_inr"] = pd.to_numeric(df["amount_inr"], errors="coerce")

delivered = (df["status"] == "Delivered") & df["amount_inr"].notna()
Q1 = df.loc[delivered, "amount_inr"].quantile(0.25)
Q3 = df.loc[delivered, "amount_inr"].quantile(0.75)
IQR = Q3 - Q1
upper_fence = Q3 + 1.5 * IQR
df.loc[delivered, "amount_inr"] = df.loc[delivered, "amount_inr"].clip(upper=upper_fence)

df["order_date"] = pd.to_datetime(df["order_date"])
df["month"] = df["order_date"].dt.month
df["month_name"] = df["order_date"].dt.month_name()
df["revenue_per_unit"] = df["amount_inr"] / df["quantity"]
df["is_delivered"] = df["status"].eq("Delivered")

delivered_df = df[df["is_delivered"] & df["amount_inr"].notna()]
category_revenue = delivered_df.groupby("category")["amount_inr"].sum().sort_values(ascending=False)
merged = df.merge(products[["product_id","supplier"]], on="product_id", how="left")
supplier_revenue = merged[merged["is_delivered"] & merged["amount_inr"].notna()].groupby("supplier")["amount_inr"].sum().sort_values(ascending=False)

print("Rows after duplicate removal:", len(df))
print("Q1:", Q1, "Q3:", Q3, "Upper fence:", upper_fence)
print("Rows capped:", int((delivered & (pd.to_numeric(pd.read_csv("orders_raw.csv")["amount_inr"], errors="coerce") > upper_fence)).sum()))
print("Top category:", category_revenue.index[0])
print("Top supplier:", supplier_revenue.index[0])
