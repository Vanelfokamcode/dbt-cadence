-- Test model to verify dbt is working

select
    'dbt-cadence' as project_name,
    '{{ target.name }}' as environment,
    '{{ target.type }}' as warehouse_type,
    current_timestamp as created_at,
    'Hello from dbt!' as message
