{{
    config(
        materialized='table',
        schema='cadence_examples'
    )
}}

/*
    Demo Subscriptions - Daily data for testing
*/

with daily_batches as (
    {{ generate_expected_batches(
        start_date="'2025-01-01'",
        end_date="'2025-02-09'",
        frequency="daily"
    ) }}
),

subscriptions as (
    select
        row_number() over (order by expected_batch_time) as subscription_id,
        expected_batch_time as created_at,
        (50 + (random() * 200))::decimal(10,2) as monthly_amount,
        'active' as status
    from daily_batches
)

select * from subscriptions
