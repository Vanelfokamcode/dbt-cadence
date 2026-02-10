{{
    config(
        materialized='table',
        schema='cadence_metadata'
    )
}}

/*
    Missing Batches Report
    
    Final alert table showing only missing batches with enriched metadata.
    
    This is what users query to see gaps, or what gets sent to Slack/email.
*/

with gaps as (
    select * 
    from {{ ref('batch_gaps') }}
    where status = 'MISSING'
),

config as (
    select 
        model_name,
        frequency
    from {{ ref('cadence_config') }}
),

enriched as (
    select
        g.model_name,
        g.expected_batch_time,
        g.gap_age_hours,
        c.frequency,
        
        -- Severity based on age
        case 
            when g.gap_age_hours <= 2 then 'LOW'
            when g.gap_age_hours <= 12 then 'MEDIUM'
            when g.gap_age_hours <= 24 then 'HIGH'
            else 'CRITICAL'
        end as severity,
        
        -- Human-readable message
        'Batch missing for ' || g.gap_age_hours || ' hours' as message,
        
        current_timestamp as detected_at
        
    from gaps g
    left join config c using (model_name)
)

select * from enriched
order by gap_age_hours desc
