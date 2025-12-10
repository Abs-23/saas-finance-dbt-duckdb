with analytics as (
    select
        account_id,
        month_start,
        total_mrr,
        usage_events,
        total_usage_count,
        total_usage_duration_secs,
        total_error_count,
        ticket_count,
        avg_resolution_time_hours,
        avg_first_response_time_minutes,
        avg_satisfaction_score,
        escalated_ticket_count
    from {{ ref('fct_account_month_analytics') }}
),

churn as (
    select
        account_id,
        first_churn_month
    from {{ ref('int_account_churn_month') }}
),

labeled as (
    select
        a.*,
        c.first_churn_month,
        case
            when c.first_churn_month = a.month_start + interval '1 month'
                then 1
            else 0
        end as churn_next_month_flag
    from analytics a
    left join churn c
      on a.account_id = c.account_id
)

select
    *
from labeled
