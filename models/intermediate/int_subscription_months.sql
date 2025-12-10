with subscriptions as (
    select
        subscription_id,
        account_id,
        start_date,
        end_date,
        normalized_mrr
    from {{ ref('int_subscription_revenue') }}
),

subscription_months as (
    select
        subscription_id,
        account_id,
        normalized_mrr,
        date_trunc('month', start_date) as month_start
    from subscriptions
)

select
    subscription_id,
    account_id,
    month_start,
    normalized_mrr as mrr_amount
from subscription_months
