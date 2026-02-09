-- Test: Generate hourly batches for 1 day

{{ cadence.generate_expected_batches(
    start_date="'2025-02-08 00:00:00'",
    end_date="'2025-02-08 23:00:00'",
    frequency="hourly"
) }}
