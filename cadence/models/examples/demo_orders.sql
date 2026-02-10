{{
    config(
        materialized='table',
        schema='cadence_examples'
    )
}}

/*
    Demo Orders - Sample data with intentional gaps
    
    This creates hourly order data for testing batch detection.
    
    Intentional gaps:
    - 2025-02-08 03:00 (missing - simulates API downtime)
    - 2025-02-08 07:00 (missing - simulates pipeline failure)
    - 2025-02-08 14:00 (missing - simulates late data)
*/

with hourly_batches as (
    {{ generate_expected_batches(
        start_date="'2025-02-08 00:00:00'",
        end_date="'2025-02-08 23:00:00'",
        frequency="hourly"
    ) }}
),

-- Remove specific hours to create gaps
batches_with_gaps as (
    select 
        expected_batch_time as order_time
    from hourly_batches
    where expected_batch_time not in (
        timestamp '2025-02-08 03:00:00',  -- Gap 1: Early morning
        timestamp '2025-02-08 07:00:00',  -- Gap 2: Morning
        timestamp '2025-02-08 14:00:00'   -- Gap 3: Afternoon
    )
),

-- Generate sample orders for each batch
orders as (
    select
        row_number() over (order by order_time) as order_id,
        order_time,
        order_time as created_at,
        -- Random amount between 10 and 500
        (10 + (random() * 490))::decimal(10,2) as amount,
        'completed' as status
    from batches_with_gaps
)

select * from orders
