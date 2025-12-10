with churn_events as (
    select
        account_id,
        date_trunc('month', churn_date) as churn_month
    from {{ ref('stg_churn_events') }}
    where churn_date is not null
),

first_churn as (
    select
        account_id,
        min(churn_month) as first_churn_month
    from churn_events
    group by account_id
)

select
    account_id,
    first_churn_month
from first_churn
