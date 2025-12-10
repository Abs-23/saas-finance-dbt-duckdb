# SaaS Finance Analytics – dbt, DuckDB & Power BI


<img width="1418" height="793" alt="Image" src="https://github.com/user-attachments/assets/bc73060f-9e87-42c0-bfcf-7aa4f7309c1f" />

An executive SaaS dashboard for MRR and churn, built directly on top of the dbt + DuckDB models in this repository.


## What this project is

This project is me taking SaaS finance analytics a step further by combining dbt, DuckDB and Power BI in a single, end‑to‑end workflow.  
In my earlier project I focused on getting comfortable with dbt and the basic modeling patterns. Here, I’m using those foundations to build a cleaner data model, expose it through DuckDB, and then turn it into a polished Power BI report that a finance or RevOps stakeholder could actually use.

## What I focused on

I cared less about covering every possible metric and more about doing a few important things well:

- Modeling **MRR and churn** in a way that is easy to reason about (account‑level and account‑month level).
- - Using a simple **Python export script** to move the curated DuckDB tables into CSVs that Power BI can consume reliably.
- Designing a small, purposeful **star schema** for BI: an accounts dimension with two fact tables for MRR and revenue/churn.
- Building an **executive‑style dashboard** that highlights MRR, churned accounts and churn rate, plus trends over time and breakdowns by plan tier and industry.

## How to run it

1. Use dbt to build the models on top of DuckDB.
2. Run the Python export script to write the key tables out as CSV files.
3. Open the Power BI report and point it at those CSVs.

This project is mainly about showing how I think through modeling SaaS revenue data, testing it, and then turning it into something that tells a clear story in Power BI.

