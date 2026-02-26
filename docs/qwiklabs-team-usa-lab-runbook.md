# Qwiklabs Team USA Lab Runbook

## 0) Environment Rule

- Local Mac terminal (`ivanivanka@MacBook-Pro ... %`) = local repo only.
- Qwiklabs Cloud Shell (`student_...@cloudshell:~$`) = ALL lab commands (`gcloud`, `bq`, `terraform`).

## 1) Current Status (already completed)

- Local repo created and pushed: `ivanivanka/team-usa-analytics-agent`.
- In Cloud Shell tab 2:
  - `team_usa` dataset created.
  - `team_usa_staging` dataset created.
  - All 4 staging loads completed successfully.
- In Cloud Shell tab 1:
  - `terraform apply -auto-approve` started and progressing (AlloyDB instance creation in progress).

## 2) Exact Next Commands (Cloud Shell)

### 2.1 Wait for Terraform to finish (tab 1)

Wait until you see:

- `Apply complete! Resources: ... added ...`

If it fails/times out:

```bash
cd ~/team-usa-analytics/terraform
terraform apply -auto-approve
```

### 2.2 Validate staging row counts (tab 2)

```bash
bq query --use_legacy_sql=false '
SELECT "stg_olympic_athletes" AS table_name, COUNT(*) AS row_count FROM `team_usa_staging.stg_olympic_athletes`
UNION ALL
SELECT "stg_paralympic_athletes", COUNT(*) FROM `team_usa_staging.stg_paralympic_athletes`
UNION ALL
SELECT "stg_olympic_results", COUNT(*) FROM `team_usa_staging.stg_olympic_results`
UNION ALL
SELECT "stg_paralympic_results", COUNT(*) FROM `team_usa_staging.stg_paralympic_results`;
'
```

## 3) Build production tables (fast path)

Use the provided fallback script to create validated production tables directly.

```bash
cd ~/team-usa-analytics
chmod +x build_prod_tables.sh
./build_prod_tables.sh
```

Validate output counts:

```bash
bq query --use_legacy_sql=false '
SELECT "athletes" AS table_name, COUNT(*) AS row_count FROM `team_usa.athletes`
UNION ALL
SELECT "results", COUNT(*) FROM `team_usa.results`;
'
```

Expected:

- `athletes`: `11843`
- `results`: `24198`

## 4) Load baseline notebook data (Task 3)

In Colab Enterprise import:

- `https://raw.githubusercontent.com/haggman/team-usa-analytics/refs/heads/main/notebooks/data_exploration.ipynb`

Set project ID in notebook:

- `<REDACTED_QWIKLABS_PROJECT_ID>`

## 5) BigQuery ML (Task 4)

- Create `team_usa.athlete_features` view.
- Train `team_usa.athlete_archetypes` (k-means).
- Create `team_usa.athlete_profiles` view.

## 6) AlloyDB semantic search (Task 5)

In Colab import:

- `https://raw.githubusercontent.com/haggman/team-usa-analytics/refs/heads/main/notebooks/alloydb_semantic_search.ipynb`

Use:

- Project: `<REDACTED_QWIKLABS_PROJECT_ID>`
- Region: `us-central1`
- User email: `<REDACTED_QWIKLABS_USER_EMAIL>`

## 7) Agent build (Task 6)

In Cloud Shell:

```bash
cd ~/team-usa-analytics/agent
cp .env.example .env
```

Set in `.env`:

- `PROJECT_ID=<REDACTED_QWIKLABS_PROJECT_ID>`
- `REGION=us-central1`
- `DB_USER=<REDACTED_QWIKLABS_USER_EMAIL>`

Then:

```bash
chmod +x setup.sh
./setup.sh
source .venv/bin/activate
source .env
./toolbox --tools-file tools.yaml
```

In a second tab:

```bash
cd ~/team-usa-analytics/agent
source .venv/bin/activate
source .env
adk web
```
