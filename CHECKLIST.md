# Pre-Publication Checklist

Before sharing dbt-cadence publicly, verify:

## Documentation
- [x] README.md is complete and compelling
- [x] All docs/*.md files are written
- [x] dbt docs generated successfully
- [x] EXAMPLES.md has real-world scenarios
- [x] CHANGELOG.md exists

## Code Quality
- [x] All tests pass (`dbt test`)
- [x] No hardcoded values
- [x] All models documented in YAML
- [x] Macros have descriptions
- [x] Code follows dbt best practices

## GitHub Setup
- [x] .gitignore is comprehensive
- [x] Issue templates created
- [x] PR template created
- [x] LICENSE file (Apache 2.0)
- [x] CODE_OF_CONDUCT.md
- [x] CONTRIBUTING.md

## Configuration
- [x] dbt_project.yml has require-dbt-version
- [x] packages.yml specifies version ranges
- [x] No secrets in repo (check git history)
- [x] profiles.yml is gitignored

## Testing
- [x] Tested on DuckDB
- [ ] Tested on Snowflake (optional)
- [ ] Tested on BigQuery (optional)
- [x] Demo data works as expected
- [x] All edge cases covered

## Optional (for dbt Hub)
- [ ] hub.md created
- [ ] Submitted to dbt Hub
- [ ] Version tagged (v0.1.0)

## Community
- [ ] GitHub repo made public
- [ ] Shared on LinkedIn/Twitter
- [ ] Posted in dbt Slack community
- [ ] Added to personal portfolio

---

**When all checked, you're ready to launch! 🚀**
