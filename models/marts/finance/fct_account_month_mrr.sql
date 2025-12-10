with subscription_months as (
    select
        subscription_id,
        account_id,
        month_start,
        mrr_amount
    from {{ ref('int_subscription_months') }}
),

account_month_mrr as (
    select
        account_id,
        month_start,
        sum(mrr_amount) as total_mrr
    from subscription_months
    group by account_id, month_start
)

select
    account_id,
    month_start,
    total_mrr
from account_month_mrr
