import duckdb
import os


db_path = r"C:\Users\popab\OneDrive\Desktop\Git\Projects\saas_finance_dbt\saas_finance_dbt.duckdb"
con = duckdb.connect(db_path)

output_dir = r"C:\Users\popab\OneDrive\Desktop\Git\Projects\saas_finance_dbt\saas_finance_dbt\export"
os.makedirs(output_dir, exist_ok=True)

tables = [
    "stg_accounts",
    "fct_account_revenue_churn",
    "fct_account_month_mrr"
]

for t in tables:
    df = con.execute(f"SELECT * FROM {t}").df()
    csv_path = os.path.join(output_dir, f"{t}.csv")
    df.to_csv(csv_path, index=False)
    print(f"Exported {t} -> {csv_path}")
