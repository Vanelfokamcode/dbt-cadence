-- Test: Generate daily batches for 1 week

{{cadence.generate_expected_batches(
    start_date="'2025-02-01'",
    end_date="'2025-02-07'",
    frequency="daily"
) }}
