# 🎵 dbt-cadence

> *Keep your data pipelines in rhythm - detect missing batches before they become problems*

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Status](https://img.shields.io/badge/status-in%20development-yellow)](https://github.com/TON_USERNAME/dbt-cadence)

---

## 🎯 The Problem

Data pipelines are supposed to run like clockwork - hourly, daily, every 15 minutes. But when they break, the silence is deafening.

**Real scenarios:**
- Your API was down for 2 hours → your hourly pipeline never noticed
- A batch arrived 3 days late → your analysis was wrong for 72 hours
- Sunday had zero orders (totally normal) → but you thought it was a bug

**The cost:**
- Knight Capital: $440M lost in 45 minutes because one server was missing from deployment
- British Airways: €100M+ when backup gaps went undetected
- Your company: ??? (you probably don't even know yet)

**Why existing tools don't solve this:**
- ✅ **dbt** transforms data brilliantly, but doesn't track what *should* exist
- ✅ **Airflow/Dagster** track tasks, not data completeness
- ✅ **Monte Carlo/Metaplane** cost $50K-200K/year and are reactive, not preventive
- ✅ **Custom scripts** mean every company reinvents the wheel

---

## 💡 The Solution

**dbt-cadence** is a dbt package that:

1. **You define the rhythm** - "I expect hourly batches" or "daily batches"
2. **We track reality** - What actually arrived in your tables
3. **We alert on gaps** - "Batch 2025-02-08 14:00 is missing"
4. **You prevent disasters** - Before the CEO notices

**Philosophy:**
> *dbt transforms what exists. dbt-cadence ensures what should exist, exists.*

---

## 🚀 Quick Start

**Coming soon.** We're building this in public - follow along!

**Current status:** Week 1 - Foundation phase

**Roadmap:**
- [ ] Week 1-2: Core metadata tracking
- [ ] Week 3-4: Gap detection logic
- [ ] Week 5-6: Configuration & documentation
- [ ] Week 7-8: First beta release

---

## 📖 Why This Project Exists

This project was born from a simple observation: **every data team has this problem, but everyone solves it differently.**

We're building `dbt-cadence` because:
- **It should be native to dbt** - not an external observability platform
- **It should be preventive** - catch gaps before they cascade
- **It should be free** - core data infrastructure shouldn't cost $100K/year
- **It should be simple** - no ML, no magic, just clear logic

**Read the full story:** [WHY.md](./docs/WHY.md) | [THE_DBT_REVOLUTION.md](./docs/THE_DBT_REVOLUTION.md) | [THE_GAP.md](./docs/THE_GAP.md)

---

## 🏗️ Project Structure
```
dbt-cadence/
├── docs/                    # Project documentation
│   ├── WHY.md              # Why this project exists
│   ├── THE_DBT_REVOLUTION.md
│   └── THE_GAP.md
├── macros/                  # dbt macros (coming soon)
├── models/                  # dbt models (coming soon)
├── tests/                   # Test suite (coming soon)
└── README.md               # You are here
```

---

## 🤝 Contributing

This is a learning-in-public project. We're building it 1 hour per day and documenting everything.

**Want to follow along?**
- ⭐ Star this repo
- 👀 Watch for updates
- 📝 Open an issue if you have this problem too

**Want to contribute?**
- Wait for our CONTRIBUTING.md (coming in Week 2)
- For now, share your war stories: What batch-tracking nightmares have you experienced?

---

## 📊 Inspiration & Prior Art

Standing on the shoulders of giants:
- [dbt-core](https://github.com/dbt-labs/dbt-core) - The foundation
- [dbt-utils](https://github.com/dbt-labs/dbt-utils) - Package design patterns
- [dbt-expectations](https://github.com/calogica/dbt-expectations) - Testing philosophy
- [Great Expectations](https://github.com/great-expectations/great_expectations) - Data quality mindset

---

## 📜 License

Apache 2.0 - See [LICENSE](LICENSE)

---

## 🎵 Keep the rhythm.

Built with ❤️ byy vanel

*Because missing data shouldn't be a silent failure.*
