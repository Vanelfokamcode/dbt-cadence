# dbt-cadence

**Keep your data pipelines in rhythm** - Detect missing batches before they become problems.

## What does this package do?

dbt-cadence monitors your data pipelines for missing batches. It:

- ✅ Generates expected batch timelines (hourly, daily)
- ✅ Compares against actual data
- ✅ Detects gaps with severity levels
- ✅ Provides alert-ready tables

## Why use dbt-cadence?

**Traditional observability tools are reactive.** They alert you AFTER bad data lands.

**dbt-cadence is preventive.** It knows what SHOULD exist and alerts when it doesn't.

## Quick Start

1. Install: `dbt deps`
2. Configure: Add to `seeds/cadence_config.csv`
3. Run: `dbt seed && dbt run --select cadence`
4. Alert: Query `cadence_metadata.missing_batches`

## Supported databases

- ✅ DuckDB
- ✅ Snowflake (tested)
- ✅ BigQuery (tested)
- ✅ Redshift (should work)
- ✅ Postgres (should work)

Any database that supports recursive CTEs.

## Requirements

- dbt >= 1.8.0
- dbt-utils >= 1.3.0

## Resources

- [Documentation](https://github.com/Vanelfokamcode/dbt-cadence/tree/main/docs)
- [Examples](https://github.com/Vanelfokamcode/dbt-cadence/blob/main/docs/EXAMPLES.md)
- [Issue Tracker](https://github.com/Vanelfokamcode/dbt-cadence/issues)
