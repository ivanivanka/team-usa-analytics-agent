# Team USA Analytics Agent

An end-to-end personal project based on the Google Cloud "Build an AI Sports Analytics Agents with Team USA" lab.

This repository captures a complete reference implementation across:

- BigQuery data modeling and analytics
- BigQuery ML clustering (athlete archetypes)
- AlloyDB vector search with ScaNN
- ADK agent orchestration via MCP Toolbox for Databases

## Why this repo exists

This is a public, reusable project archive for:

- preserving the working SQL and agent artifacts,
- documenting the exact execution path,
- serving as a starter for a non-lab production adaptation.

## Repository structure

- `docs/`: runbook and process notes
- `sql/`: cleaned and reusable BigQuery SQL for Task 4
- `artifacts/`: exported outputs/config snapshots from the completed lab
- `agent/`, `infra/`, `dataform/`, `notebooks/`: scaffolded project paths for extension work

## What is included

- validated table counts and model outputs,
- MCP tool configuration and agent prompt instructions,
- reproducible Task 4 SQL scripts,
- sanitized lab result records.

## Security and sanitization

This public repo is sanitized:

- no active credentials/tokens,
- no private console/session URLs,
- no personal access secrets.

Lab-specific identifiers are replaced with placeholders in the current history.

## License

MIT. See `LICENSE`.
