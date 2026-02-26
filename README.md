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

## What to query

### BigQuery SQL examples

Run these from `sql/`:

- `task4_01_create_athlete_features.sql` — feature engineering view
- `task4_02_train_athlete_archetypes.sql` — K-means model training
- `task4_03_create_athlete_profiles_view.sql` — model-backed profiles view
- `task4_04_validate_outputs.sql` — validation and sanity checks

### Agent prompt examples

Try these in ADK Web UI:

- `Tell me about Michael Phelps`
- `Find athletes who overcame adversity to win gold`
- `What career archetype is Simone Biles?`
- `What percentage of Team USA swimmers are Paralympic athletes?`

## Example results

From the completed run:

- `team_usa.athletes = 11,843`
- `team_usa.results = 24,198`
- `medalist_count = 5,220`
- `Michael Phelps archetype = The Elite Achievers`
- `Paralympic swimmers share (agent custom query) = 23.3%`

See full snapshot: `artifacts/LAB_RESULTS.md`

## Why this is cool

- It combines two query engines in one interface:
  - BigQuery for analytics + ML
  - AlloyDB for low-latency semantic/vector search
- It demonstrates realistic agent routing:
  - profile lookup,
  - semantic retrieval,
  - ML archetype classification,
  - custom SQL metrics.
- It is reproducible and inspectable:
  - SQL is explicit,
  - tools are defined in YAML,
  - run outputs are archived in `artifacts/`.

## Security and sanitization

This public repo is sanitized:

- no active credentials/tokens,
- no private console/session URLs,
- no personal access secrets.

Lab-specific identifiers are replaced with placeholders in the current history.

## License

MIT. See `LICENSE`.
