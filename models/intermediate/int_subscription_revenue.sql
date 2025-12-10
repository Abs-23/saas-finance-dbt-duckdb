with subscriptions as (
    select
        subscription_id,
        account_id,
        start_date,
        end_date,
        plan_tier,
        seats,
        mrr_amount,
        arr_amount,
        billing_frequency,
        churn_flag,
        upgrade_flag,
        downgrade_flag,
        is_trial
    from {{ ref('stg_subscriptions') }}
)

select
    subscription_id,
    account_id,
    start_date,
    end_date,
    plan_tier,
    seats,
    -- prefer explicit mrr_amount if present; fallback to arr_amount / 12
    coalesce(
        mrr_amount,
        case
            when arr_amount is not null then arr_amount / 12
            else null
        end
    ) as normalized_mrr,
    arr_amount,
    billing_frequency,
    churn_flag,
    upgrade_flag,
    downgrade_flag,
    is_trial
from subscriptions
