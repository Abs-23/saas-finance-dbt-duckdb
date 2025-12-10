with revenue as (
    select
        account_id,
        sum(normalized_mrr) as total_mrr
    from {{ ref('int_subscription_revenue') }}
    group by account_id
),

churn as (
    select
        account_id,
        min(churn_date) as first_churn_date,
        count(*) as churn_event_count
    from {{ ref('stg_churn_events') }}
    group by account_id
),

accounts as (
    select
        account_id,
        account_name,
        industry,
        country,
        signup_date,
        referral_source,
        plan_tier,
        seats,
        is_trial,
        churn_flag
    from {{ ref('stg_accounts') }}
)

select
    a.*,
    coalesce(r.total_mrr, 0) as total_mrr,
    c.first_churn_date,
    coalesce(c.churn_event_count, 0) as churn_event_count
from accounts a
left join revenue r using (account_id)
left join churn c using (account_id)
