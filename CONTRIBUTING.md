# Contributing to dbt-cadence

First off, **thank you** for considering contributing to dbt-cadence! 🎵

This project exists because data engineers everywhere face the same problem - missing batches that go undetected. Every contribution helps make data pipelines more reliable.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Setup](#development-setup)
- [Pull Request Process](#pull-request-process)
- [Style Guidelines](#style-guidelines)

---

## 📜 Code of Conduct

This project adheres to the Contributor Covenant [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

**TL;DR:** Be kind, be respectful, be helpful.

---

## 🚀 How Can I Contribute?

### 🐛 Reporting Bugs

**Before submitting a bug report:**
- Check if it's already reported in [Issues](https://github.com/vanelfokamcode/dbt-cadence/issues)
- Make sure you're using the latest version

**When submitting a bug report, include:**
- dbt version (`dbt --version`)
- Database/warehouse (Snowflake, BigQuery, etc.)
- Minimal reproducible example
- Expected vs actual behavior

### 💡 Suggesting Enhancements

We love ideas! Open an issue with:
- Clear use case ("As a data engineer, I want...")
- Why existing solutions don't work
- Proposed solution (if you have one)

### 🔧 Your First Code Contribution

**Good first issues:**
- Issues labeled `good first issue`
- Documentation improvements
- Test coverage improvements

---

## 🛠️ Development Setup

### Prerequisites

- Python 3.8+
- dbt-core 1.5+
- DuckDB (for local testing)

### Setup Steps
```bash
# 1. Fork the repo on GitHub

# 2. Clone your fork
git clone git@github.com:vanelfokamcode/dbt-cadence.git
cd dbt-cadence

# 3. Create a virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# 4. Install dependencies
pip install -r requirements.txt

# 5. Install dbt-duckdb for local testing
pip install dbt-duckdb

# 6. Run tests (when available)
pytest tests/
```

---

## 🔄 Pull Request Process

### Before Submitting

1. **Create a branch:**
```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/your-bug-fix
```

2. **Make your changes**
   - Follow our [Style Guidelines](#style-guidelines)
   - Add tests if applicable
   - Update documentation

3. **Test locally:**
```bash
   dbt run --models your_model
   dbt test
```

4. **Commit with a good message:**
```bash
   git commit -m "feat: add hourly batch validation

   - Implement hourly cadence detection
   - Add tests for edge cases (weekends, holidays)
   - Update README with configuration examples"
```

### Commit Message Format

We follow [Conventional Commits](https://www.conventionalcommits.org/):
```
<type>: <description>

[optional body]

[optional footer]
```

**Types:**
- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation only
- `test:` Adding tests
- `refactor:` Code refactoring
- `perf:` Performance improvement
- `chore:` Maintenance tasks

**Examples:**
```
feat: add daily batch tracking
fix: handle timezone edge cases in gap detection
docs: update README with installation instructions
test: add integration tests for Snowflake
```

### Submitting the PR

1. Push to your fork:
```bash
   git push origin feature/your-feature-name
```

2. Open a Pull Request on GitHub

3. **PR Description should include:**
   - What does this PR do?
   - Why is it needed?
   - How was it tested?
   - Screenshots (if UI changes)

4. **Wait for review:**
   - Maintainers will review within 48-72 hours
   - Address feedback
   - Once approved → Merge! 🎉

---

## 📐 Style Guidelines

### Python Code

- Follow [PEP 8](https://pep8.org/)
- Use type hints where possible
- Max line length: 100 characters
- Use meaningful variable names

**Example:**
```python
# ❌ Bad
def f(x, y):
    return x + y

# ✅ Good
def calculate_expected_batches(start_date: datetime, end_date: datetime) -> List[datetime]:
    """
    Generate list of expected batch timestamps.
    
    Args:
        start_date: Beginning of time range
        end_date: End of time range
    
    Returns:
        List of datetime objects representing expected batches
    """
    pass
```

### SQL / dbt Models

- Use lowercase for keywords (`select`, `from`, `where`)
- Indent with 4 spaces
- One column per line in SELECT
- Use CTEs for readability

**Example:**
```sql
-- ✅ Good
with expected_batches as (
    select
        batch_timestamp,
        model_name
    from {{ ref('cadence_config') }}
    where is_active = true
),

actual_batches as (
    select distinct
        date_trunc('hour', created_at) as batch_timestamp
    from {{ ref('stg_orders') }}
)

select
    e.batch_timestamp,
    e.model_name,
    case
        when a.batch_timestamp is null then 'MISSING'
        else 'OK'
    end as status
from expected_batches e
left join actual_batches a
    on e.batch_timestamp = a.batch_timestamp
```

### Documentation

- Use Markdown
- Add examples for complex features
- Keep it concise but complete

---

## ❓ Questions?

- Open a [Discussion](https://github.com/Vanelfokamcode/dbt-cadence/discussions)
- Check existing [Issues](https://github.com/Vanelfokamcode/dbt-cadence/issues)
- Read the [docs/](docs/) folder

---

## 🙏 Thank You!

Your contributions make dbt-cadence better for everyone. Whether it's a bug report, feature request, or code contribution - it all matters.

**Keep the rhythm. 🎵**
