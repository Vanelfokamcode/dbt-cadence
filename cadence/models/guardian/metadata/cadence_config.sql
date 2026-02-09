{{
    config(
        materialized='table',
        schema='cadence_metadata'
    )
}}

/*
    Cadence Configuration
    
    This model defines which tables/models should be monitored
    and what their expected batch frequency is.
    
    Users can:
    - Define expected batch frequency (hourly, daily)
    - Set monitoring start date
    - Enable/disable monitoring per model
*/

with config_source as (
    select * from {{ ref('example_cadence_config') }}
),

validated as (
    select
        model_name,
        frequency,
        cast(start_date as date) as start_date,
        enabled,
        current_timestamp as config_loaded_at
    from config_source
    where enabled = true  -- Only active configs
)

select * from validated
