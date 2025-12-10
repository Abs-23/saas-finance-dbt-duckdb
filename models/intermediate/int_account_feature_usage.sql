with usage as (
    select
        usage_id,
        subscription_id,
        usage_date,
        feature_name,
        usage_count,
        usage_duration_secs,
        error_count,
        is_beta_feature
    from {{ ref('stg_feature_usage') }}
),

usage_with_accounts as (
    select
        u.*,
        s.account_id
    from usage u
    left join {{ ref('stg_subscriptions') }} s
        using (subscription_id)
),

account_usage as (
    select
        account_id,
        date_trunc('month', usage_date) as month_start,
        count(*) as usage_events,
        sum(usage_count) as total_usage_count,
        sum(usage_duration_secs) as total_usage_duration_secs,
        sum(error_count) as total_error_count
    from usage_with_accounts
    where account_id is not null
    group by account_id, date_trunc('month', usage_date)
)

select
    account_id,
    month_start,
    usage_events,
    total_usage_count,
    total_usage_duration_secs,
    total_error_count
from account_usage
