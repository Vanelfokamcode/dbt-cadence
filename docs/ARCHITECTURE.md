# dbt-cadence Architecture

## Overview

`dbt-cadence` is organized to separate concerns cleanly:

- **Guardian** - Core batch tracking logic
- **Examples** - Demonstration and testing
- **Macros** - Reusable functions
- **Seeds** - Configuration data

## Directory Structure
```
cadence/
├── models/
│   ├── guardian/           # Core functionality
│   │   ├── metadata/       # Configuration & expected batches
│   │   ├── detection/      # Actual batches & gap detection
│   │   └── alerts/         # Final reporting
│   └── examples/           # Demo models
├── macros/                 # Reusable SQL functions
├── seeds/                  # Static configuration files
└── tests/                  # Integration tests
```

## Data Flow
```
User Configuration (seed)
    ↓
Expected Batches (generated from config)
    ↓
Actual Batches (queried from target tables)
    ↓
Batch Gaps (comparison: expected vs actual)
    ↓
Missing Batches Report (final alert)
```

## Model Layers

### Guardian (Core)

**metadata/**
- `cadence_config.sql` - User-defined expectations
- `expected_batches.sql` - Generated timeline of expected batches

**detection/**
- `actual_batches.sql` - Extracted actual batches from tables
- `batch_gaps.sql` - Identified missing batches

**alerts/**
- `missing_batches.sql` - Final report with gaps and metadata

### Examples (Demo)

- `demo_hourly_data.sql` - Sample data with intentional gaps
- `demo_gap_detection.sql` - Demonstration of detection logic

## Macros

- `generate_expected_batches()` - Creates expected batch timeline
- `detect_gaps()` - Compares expected vs actual
- `get_cadence_config()` - Retrieves user configuration

## Materialization Strategy

| Layer | Materialization | Why |
|-------|----------------|-----|
| metadata | `incremental` | Append-only configuration |
| detection | `table` | Needs to be fast for comparison |
| alerts | `table` | Final output, optimized for querying |
| examples | `view` | Lightweight demos, recreated each run |

## Schema Organization
```
cadence_metadata   # Guardian internal tables
cadence_examples   # Demo/example tables
```

This keeps our internal logic separate from user-facing examples.

## Why This Structure?

**Separation of Concerns:**
- Configuration (metadata) separate from detection logic
- Detection logic separate from alerting
- Each model has one clear responsibility

**Testability:**
- Each layer can be tested independently
- Examples provide integration test cases

**Extensibility:**
- Easy to add new cadence types (daily, weekly, custom)
- Easy to add new alert channels (Slack, email)
- Easy to add new detection strategies

**Performance:**
- Incremental models for growing data
- Tables for frequently-queried comparisons
- Views for lightweight examples

---

**Next:** See [DEVELOPMENT.md](DEVELOPMENT.md) for setup instructions.
