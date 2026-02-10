{{
    config(
        materialized='ephemeral',
        schema='cadence_metadata'
    )
}}

/*
    Actual Batches
    
    Extracts the actual batch timestamps that exist in the monitored table.
    
    This is compared against expected_batches to find gaps.
    
    For now: Hardcoded to demo_orders
    Chapter 12: Make dynamic based on config
*/

with demo_data as (
    select 
        created_at
    from {{ ref('demo_orders') }}
),

actual as (
    select distinct
        'orders' as model_name,
        date_trunc('hour', created_at) as actual_batch_time
    from demo_data
)

select * from actual
