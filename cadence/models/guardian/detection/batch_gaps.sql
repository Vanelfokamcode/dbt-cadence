{{
    config(
        materialized='table',
        schema='cadence_metadata'
    )
}}

with expected as (
    select 
        model_name,
        expected_batch_time
    from {{ ref('expected_batches') }}
),

actual as (
    select 
        model_name,
        actual_batch_time
    from {{ ref('actual_batches') }}
),

comparison as (
    select
        e.model_name,
        e.expected_batch_time,
        a.actual_batch_time,
        case 
            when a.actual_batch_time is not null then 'OK'
            else 'MISSING'
        end as status,
        case 
            when a.actual_batch_time is null 
            then datediff('hour', e.expected_batch_time, current_timestamp)
            else null
        end as gap_age_hours
    from expected e
    left join actual a 
        on e.model_name = a.model_name
        and e.expected_batch_time = a.actual_batch_time
)

select * from comparison
