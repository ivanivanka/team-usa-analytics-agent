# Changelog

All notable changes to this project are documented in this file.

## 2026-02-26

### Added

- Public project scaffold and runbook for the Team USA analytics agent workflow.
- Task 4 BigQuery SQL scripts for feature view, model training, and profile view.
- Lab completion artifacts and result snapshots.
- MIT license.

### Changed

- Redacted lab-specific identifiers from tracked files.
- Renamed exported Python artifacts to `.txt` snapshots to avoid execution/tooling coupling.
- Updated CI defaults for public-project context:
  - `scripts/ci` now passes until project-specific tests are added.
  - deploy-manifest workflow now skips gracefully when `markster-ops` is not accessible.

### Security

- Removed lab access metadata from current tree and prepared history rewrite to purge older commits.
