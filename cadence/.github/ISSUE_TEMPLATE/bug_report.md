---
name: Bug Report
about: Report a bug in dbt-cadence
title: '[BUG] '
labels: bug
assignees: ''
---

## Describe the bug

A clear description of what the bug is.

## To Reproduce

Steps to reproduce the behavior:
1. Configure cadence with '...'
2. Run 'dbt run'
3. See error

## Expected behavior

What you expected to happen.

## Actual behavior

What actually happened.

## Environment

- **dbt version:** (run `dbt --version`)
- **Database:** (Snowflake, BigQuery, DuckDB, etc.)
- **dbt-cadence version:** (commit hash or release)
- **OS:** (macOS, Linux, Windows)

## Configuration
```yaml
# Your cadence_config.csv (sanitized)
model_name,frequency,start_date,enabled,table_ref,timestamp_column
my_model,hourly,2025-01-01,true,stg_my_model,created_at
```

## Error messages
```
Paste any error messages here
```

## Additional context

Any other context about the problem.
