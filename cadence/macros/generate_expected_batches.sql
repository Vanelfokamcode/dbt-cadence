{#
    Generate a series of expected batch timestamps
    
    Args:
        start_date (date/timestamp): Beginning of range
        end_date (date/timestamp): End of range  
        frequency (string): 'hourly' or 'daily'
    
    Returns:
        Table with column 'expected_batch_time'
        
    Example:
        {{ generate_expected_batches(
            start_date="'2025-02-08'",
            end_date="'2025-02-09'",
            frequency="'hourly'"
        ) }}
#}

{% macro generate_expected_batches(start_date, end_date, frequency='hourly') %}

    {# Step 1: Calculate the interval based on frequency #}
    {% if frequency == 'hourly' %}
        {% set interval_sql = "interval '1 hour'" %}
    {% elif frequency == 'daily' %}
        {% set interval_sql = "interval '1 day'" %}
    {% else %}
        {{ exceptions.raise_compiler_error("Frequency must be 'hourly' or 'daily', got: " ~ frequency) }}
    {% endif %}

    {# Step 2: Generate the date spine #}
    with recursive date_spine as (
        
        -- Base case: start date
        select 
            cast({{ start_date }} as timestamp) as expected_batch_time
        
        union all
        
        -- Recursive case: add interval until we reach end_date
        select 
            expected_batch_time + {{ interval_sql }}
        from date_spine
        where expected_batch_time + {{ interval_sql }} <= cast({{ end_date }} as timestamp)
    )
    
    select 
        expected_batch_time
    from date_spine
    order by expected_batch_time

{% endmacro %}
