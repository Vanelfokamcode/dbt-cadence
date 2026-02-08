# Development Setup Guide

This guide will help you set up your local development environment for `dbt-cadence`.

## Prerequisites

- **Python 3.8+** (`python --version`)
- **pip** (comes with Python)
- **Git** (for version control)

## Quick Start (5 minutes)

### 1. Clone the Repository
```bash
git clone git@github.com:Vanelfokamcode/dbt-cadence.git
cd dbt-cadence
```

### 2. Create Virtual Environment
```bash
python3 -m venv venv
source venv/bin/activate  # macOS/Linux
# OR
venv\Scripts\activate     # Windows
```

You should see `(venv)` in your terminal.

### 3. Install Dependencies
```bash
pip install --upgrade pip
pip install -r requirements.txt
```

### 4. Verify Installation
```bash
dbt --version
```

You should see dbt-core and dbt-duckdb listed.

### 5. Test dbt Connection
```bash
cd cadence
dbt debug
```

All checks should pass ✅

### 6. Run First Model
```bash
dbt run --select test_connection
```

You should see `PASS=1` 🎉

---

## Project Structure
```
dbt-cadence/
├── cadence/                # dbt project root
│   ├── dbt_project.yml    # Project configuration
│   ├── models/            # SQL transformations
│   │   ├── guardian/      # Core batch tracking logic
│   │   └── examples/      # Demo models
│   ├── macros/            # Reusable SQL functions
│   ├── tests/             # Custom SQL tests
│   └── seeds/             # Static CSV data
├── docs/                   # Project documentation
├── venv/                   # Python virtual environment (not in git)
├── requirements.txt        # Python dependencies
└── README.md              # Project overview
```

---

## Configuration Files

### ~/.dbt/profiles.yml (NOT in repo)

This file contains database credentials and should NEVER be committed to git.

Location: `~/.dbt/profiles.yml`

**For development (DuckDB):**
```yaml
cadence:
  target: dev
  outputs:
    dev:
      type: duckdb
      path: 'dev.duckdb'
      threads: 4
```

### cadence/dbt_project.yml (IN repo)

Project-level configuration (no secrets).

---

## Common Commands

### Run Models
```bash
# Run all models
dbt run

# Run specific model
dbt run --select model_name

# Run models in a directory
dbt run --select guardian
```

### Test Models
```bash
# Run all tests
dbt test

# Test specific model
dbt test --select model_name
```

### Generate Documentation
```bash
dbt docs generate
dbt docs serve
```

Then open http://localhost:8080

### Clean Build Artifacts
```bash
dbt clean
```

---

## Development Workflow

1. **Create a branch:**
```bash
   git checkout -b feature/your-feature
```

2. **Make changes to models:**
   - Edit `.sql` files in `models/`
   - Add tests in `.yml` files

3. **Test locally:**
```bash
   dbt run --select your_model
   dbt test --select your_model
```

4. **Commit with good messages:**
```bash
   git commit -m "feat: add hourly batch validation"
```

5. **Push and create PR:**
```bash
   git push origin feature/your-feature
```

---

## Troubleshooting

### "dbt: command not found"

Your virtual environment is not activated.
```bash
source venv/bin/activate
```

### "Credentials in profile "cadence", target "dev" invalid"

Check your `~/.dbt/profiles.yml` file exists and is valid YAML.

### "Compilation Error"

Check your SQL syntax. dbt will show which file has the error.

### DuckDB file locked

Close any other processes using `dev.duckdb`:
```bash
rm dev.duckdb
dbt run
```

---

## Next Steps

- Read [WHY.md](WHY.md) to understand the project vision
- Read [CONTRIBUTING.md](../CONTRIBUTING.md) for contribution guidelines
- Check [GitHub Issues](https://github.com/Vanelfokamcode/dbt-cadence/issues) for tasks

---

**Questions?** Open a [Discussion](https://github.com/Vanelfokamcode/dbt-cadence/discussions)

**Keep the rhythm. 🎵**
