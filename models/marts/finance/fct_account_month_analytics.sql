with revenue as (
    select
        account_id,
        month_start,
        total_mrr
    from {{ ref('fct_account_month_mrr') }}
),

usage as (
    select
        account_id,
        month_start,
        usage_events,
        total_usage_count,
        total_usage_duration_secs,
        total_error_count
    from {{ ref('int_account_feature_usage') }}
),

support as (
    select
        account_id,
        month_start,
        ticket_count,
        avg_resolution_time_hours,
        avg_first_response_time_minutes,
        avg_satisfaction_score,
        escalated_ticket_count
    from {{ ref('int_account_support_load') }}
)

select
    coalesce(r.account_id, u.account_id, s.account_id) as account_id,
    coalesce(r.month_start, u.month_start, s.month_start) as month_start,
    r.total_mrr,
    u.usage_events,
    u.total_usage_count,
    u.total_usage_duration_secs,
    u.total_error_count,
    s.ticket_count,
    s.avg_resolution_time_hours,
    s.avg_first_response_time_minutes,
    s.avg_satisfaction_score,
    s.escalated_ticket_count
from revenue r
full outer join usage u
  on r.account_id = u.account_id and r.month_start = u.month_start
full outer join support s
  on coalesce(r.account_id, u.account_id) = s.account_id
 and coalesce(r.month_start, u.month_start) = s.month_start
