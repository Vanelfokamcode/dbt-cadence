# Usage Examples

Real-world scenarios for using dbt-cadence.

---

## Example 1: E-commerce Order Stream

**Scenario:** You ingest orders from Shopify every hour via API.

### Setup
```csv
# seeds/cadence_config.csv
model_name,frequency,start_date,enabled,table_ref,timestamp_column
shopify_orders,hourly,2025-01-01,true,stg_shopify_orders,created_at
```

### Detection
```sql
-- Check for gaps
SELECT * FROM cadence_metadata.missing_batches
WHERE model_name = 'shopify_orders'
  AND severity IN ('HIGH', 'CRITICAL')
```

### Alert
```python
# airflow/dags/monitor_orders.py
gaps = query_db("""
    SELECT * FROM cadence_metadata.missing_batches
    WHERE model_name = 'shopify_orders'
    AND gap_age_hours > 2
""")

if gaps:
    send_pagerduty_alert("Orders missing for 2+ hours!")
```

---

## Example 2: Nightly Data Warehouse Refresh

**Scenario:** Your warehouse refreshes daily at 2 AM.

### Setup
```csv
fct_daily_sales,daily,2024-01-01,true,fct_sales,sale_date
dim_customers,daily,2024-01-01,true,dim_customers,updated_at
```

### Morning Check
```sql
-- First thing every morning
SELECT 
    model_name,
    expected_batch_time::date as missing_date,
    message
FROM cadence_metadata.missing_batches
WHERE expected_batch_time::date = current_date - 1
```

**If any rows → yesterday's refresh failed!**

---

## Example 3: Multi-Source Data Lake

**Scenario:** You have multiple sources feeding a data lake.

### Setup
```csv
salesforce_leads,hourly,2025-01-01,true,bronze_salesforce_leads,ingested_at
hubspot_contacts,hourly,2025-01-01,true,bronze_hubspot_contacts,ingested_at
stripe_payments,hourly,2025-01-01,true,bronze_stripe_payments,created_at
google_analytics,daily,2025-01-01,true,bronze_ga_sessions,session_date
```

### Dashboard Query
```sql
-- Summary by source
SELECT 
    model_name,
    COUNT(*) as total_gaps,
    MAX(gap_age_hours) as oldest_gap_hours,
    COUNT(CASE WHEN severity = 'CRITICAL' THEN 1 END) as critical_count
FROM cadence_metadata.missing_batches
GROUP BY 1
ORDER BY critical_count DESC, oldest_gap_hours DESC
```

---

## Example 4: Backfill Detection

**Scenario:** You're backfilling historical data and want to track progress.

### Setup
```csv
backfill_2023_orders,hourly,2023-01-01,true,stg_orders,created_at
```

### Progress Tracking
```sql
-- Backfill completeness
WITH expected AS (
    SELECT COUNT(*) as expected_count
    FROM cadence_metadata.expected_batches
    WHERE model_name = 'backfill_2023_orders'
),
actual AS (
    SELECT COUNT(*) as actual_count
    FROM cadence_metadata.batch_gaps
    WHERE model_name = 'backfill_2023_orders'
      AND status = 'OK'
)
SELECT 
    actual_count,
    expected_count,
    (actual_count * 100.0 / expected_count)::decimal(5,2) as pct_complete
FROM expected, actual
```

**Output:** `98.5% complete` → You know exactly how much is left!

---

## Example 5: Custom Alerting Logic

**Scenario:** Different models have different SLAs.

### Custom Severity
```sql
-- Override severity based on business rules
SELECT
    model_name,
    expected_batch_time,
    gap_age_hours,
    CASE
        WHEN model_name = 'critical_revenue_data' AND gap_age_hours > 1 THEN 'CRITICAL'
        WHEN model_name = 'optional_analytics' AND gap_age_hours > 48 THEN 'LOW'
        ELSE severity
    END as adjusted_severity,
    message
FROM cadence_metadata.missing_batches
```

### Scheduled Alerts
```python
# Run every hour
def check_gaps():
    critical = query("""
        SELECT * FROM cadence_metadata.missing_batches
        WHERE severity = 'CRITICAL'
    """)
    
    if critical:
        for gap in critical:
            slack.send(
                channel="#data-alerts",
                message=f":rotating_light: {gap.message}",
                fields={
                    "Model": gap.model_name,
                    "Expected": gap.expected_batch_time,
                    "Age": f"{gap.gap_age_hours} hours"
                }
            )
```

---

## Tips & Tricks

### Tip 1: Start Date Strategy

Set `start_date` to when your pipeline became stable, not when data started.

❌ Bad: `start_date = 2020-01-01` (pipeline unstable back then)  
✅ Good: `start_date = 2024-06-01` (when monitoring makes sense)

### Tip 2: Temporary Disable

Don't delete configs - disable them:
```csv
old_system,hourly,2023-01-01,false,stg_old_system,created_at
```

You can re-enable later without losing config.

### Tip 3: Grace Periods

Add grace periods before alerting:
```sql
SELECT * FROM cadence_metadata.missing_batches
WHERE gap_age_hours > 2  -- 2 hour grace period
```

### Tip 4: Weekend Handling

If your pipeline doesn't run weekends:
```sql
SELECT * FROM cadence_metadata.missing_batches
WHERE EXTRACT(DOW FROM expected_batch_time) NOT IN (0, 6)  -- Skip Sat/Sun
```

---

**More questions? [Open a discussion](https://github.com/Vanelfokamcode/dbt-cadence/discussions)**
