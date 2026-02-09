{% macro generate_expected_batches(start_date, end_date, frequency='hourly') %}

    {# Strip quotes if they exist #}
    {% set clean_frequency = frequency | replace("'", "") | replace('"', '') %}

    {# Calculate the interval based on frequency #}
    {% if clean_frequency == 'hourly' %}
        {% set interval_sql = "interval '1 hour'" %}
    {% elif clean_frequency == 'daily' %}
        {% set interval_sql = "interval '1 day'" %}
    {% else %}
        {{ exceptions.raise_compiler_error("Frequency must be 'hourly' or 'daily', got: " ~ clean_frequency) }}
    {% endif %}

    {# Generate the date spine #}
    with recursive date_spine as (
        
        select 
            cast({{ start_date }} as timestamp) as expected_batch_time
        
        union all
        
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
