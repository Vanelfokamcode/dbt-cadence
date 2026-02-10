{{
    config(
        materialized='table',
        schema='cadence_metadata'
    )
}}

with config_source as (
    select * from {{ ref('example_cadence_config') }}
),

validated as (
    select
        model_name,
        frequency,
        cast(start_date as date) as start_date,
        enabled,
        table_ref,
        timestamp_column,
        current_timestamp as config_loaded_at
    from config_source
    where enabled = true
)

select * from validated
