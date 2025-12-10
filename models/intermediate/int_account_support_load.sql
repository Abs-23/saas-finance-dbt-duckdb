with tickets as (
    select
        ticket_id,
        account_id,
        submitted_at,
        closed_at,
        resolution_time_hours,
        priority,
        first_response_time_minutes,
        satisfaction_score,
        escalation_flag
    from {{ ref('stg_support_tickets') }}
),

account_support as (
    select
        account_id,
        date_trunc('month', submitted_at) as month_start,
        count(*) as ticket_count,
        avg(resolution_time_hours) as avg_resolution_time_hours,
        avg(first_response_time_minutes) as avg_first_response_time_minutes,
        avg(satisfaction_score) as avg_satisfaction_score,
        sum(case when escalation_flag then 1 else 0 end) as escalated_ticket_count
    from tickets
    where account_id is not null
    group by account_id, date_trunc('month', submitted_at)
)

select
    account_id,
    month_start,
    ticket_count,
    avg_resolution_time_hours,
    avg_first_response_time_minutes,
    avg_satisfaction_score,
    escalated_ticket_count
from account_support
