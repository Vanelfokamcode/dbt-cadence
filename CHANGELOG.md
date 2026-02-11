# Changelog

All notable changes to dbt-cadence will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial release of dbt-cadence
- Core gap detection for hourly and daily batches
- Dynamic configuration via seeds
- Severity-based alerting (LOW/MEDIUM/HIGH/CRITICAL)
- Comprehensive test suite
- Full documentation

### Models
- `cadence_config` - User configuration
- `expected_batches` - Generated timeline
- `actual_batches` - Extracted real batches
- `batch_gaps` - Gap detection
- `missing_batches` - Alert table

### Macros
- `generate_expected_batches` - Core batch generation

### Examples
- Demo models with intentional gaps
- Real-world usage examples

## [0.1.0] - 2026-02-11

### Added
- Initial public release
- Basic gap detection functionality
- Documentation and examples

---

## Release Process

1. Update CHANGELOG.md
2. Update version in dbt_project.yml
3. Commit: `git commit -m "chore: bump version to X.Y.Z"`
4. Tag: `git tag -a vX.Y.Z -m "Release X.Y.Z"`
5. Push: `git push && git push --tags`
