{{
    config(
        materialized='table',
        schema='cadence_examples'
    )
}}

/*
    Demo Page Views - Hourly data with one intentional gap
*/

with hourly_batches as (
    {{ generate_expected_batches(
        start_date="'2025-02-08 00:00:00'",
        end_date="'2025-02-08 23:00:00'",
        frequency="hourly"
    ) }}
),

-- Remove one hour to create a gap
batches_with_gap as (
    select expected_batch_time as viewed_at
    from hourly_batches
    where expected_batch_time != timestamp '2025-02-08 15:00:00'
),

page_views as (
    select
        row_number() over (order by viewed_at) as page_view_id,
        viewed_at,
        '/page/' || (random() * 100)::int as page_url,
        'user_' || (random() * 1000)::int as user_id
    from batches_with_gap
)

select * from page_views
