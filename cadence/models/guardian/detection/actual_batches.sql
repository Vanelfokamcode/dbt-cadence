{{
    config(
        materialized='ephemeral',
        schema='cadence_metadata'
    )
}}

/*
    Actual Batches - DYNAMIC VERSION
    
    Extracts actual batch timestamps from ALL monitored tables.
*/

-- depends_on: {{ ref('demo_orders') }}
-- depends_on: {{ ref('demo_subscriptions') }}
-- depends_on: {{ ref('demo_page_views') }}

{# Get all active configs #}
{% set config_query %}
    select 
        model_name,
        table_ref,
        timestamp_column,
        frequency
    from {{ ref('cadence_config') }}
{% endset %}

{% set configs = run_query(config_query) %}

{% if execute %}

    {# Generate a query for each configured table #}
    {% for config in configs %}
    
        select distinct
            '{{ config.model_name }}' as model_name,
            {% if config.frequency == 'hourly' %}
                date_trunc('hour', {{ config.timestamp_column }})
            {% elif config.frequency == 'daily' %}
                date_trunc('day', {{ config.timestamp_column }})
            {% endif %} as actual_batch_time
        from {{ ref(config.table_ref) }}
        
        {% if not loop.last %}
        union all
        {% endif %}
        
    {% endfor %}

{% else %}

    {# Placeholder for compilation #}
    select 
        cast(null as varchar) as model_name,
        cast(null as timestamp) as actual_batch_time
    where false

{% endif %}
