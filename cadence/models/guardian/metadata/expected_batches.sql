{{
    config(
        materialized='table',
        schema='cadence_metadata'
    )
}}

{% set config_query %}
    select model_name, frequency, start_date
    from {{ ref('cadence_config') }}
{% endset %}

{% set configs = run_query(config_query) %}

{% if execute %}

with
{% for config in configs %}
{{ config.model_name }}_batches as (
    select
        '{{ config.model_name }}' as model_name,
        expected_batch_time
    from (
        {{ generate_expected_batches(
            start_date="'" ~ config.start_date ~ "'",
            end_date="'2025-02-09'",
            frequency=config.frequency
        ) }}
    )
){% if not loop.last %},{% endif %}
{% endfor %}

{% for config in configs %}
select * from {{ config.model_name }}_batches
{% if not loop.last %}
union all
{% endif %}
{% endfor %}

{% else %}
select 
    cast(null as varchar) as model_name,
    cast(null as timestamp) as expected_batch_time
where false
{% endif %}
