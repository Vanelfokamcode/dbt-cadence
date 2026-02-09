{{
    config(
        materialized='table',
        schema='cadence_metadata'
    )
}}

/*
    Expected Batches
    
    Generates expected batch timestamps for configured models.
    
    For now: hardcoded for 'orders' model as a demo.
    Chapter 11: we'll make this dynamic based on cadence_config.
*/

with config as (
    select 
        model_name,
        frequency,
        start_date
    from {{ ref('cadence_config') }}
    where model_name = 'orders'  -- Demo: just orders for now
),

expected as (
    select
        'orders' as model_name,
        expected_batch_time
    from (
        {{ generate_expected_batches(
            start_date="'2025-02-01 00:00:00'",
            end_date="'2025-02-08 23:00:00'",
            frequency="hourly"
        ) }}
    )
)

select * from expected
