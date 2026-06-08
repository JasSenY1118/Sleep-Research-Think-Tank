# Local Database Prototype

This folder contains the Phase 9C local SQLite schema prototype for the Sleep Research Think Tank.

## Scope

The schema is local structure only.

It does not add:

- real paper data
- fake citations
- fake model results
- PDF upload
- external API calls
- Sleep-EDF preprocessing
- model training
- authentication
- production database setup
- vector database support
- website UI database connection

## Files

- `schema.sql`: creates the local SQLite tables planned in Phase 9.
- `seed_placeholder.sql`: adds clearly labelled placeholder records for local testing only.
- `paper_repository.sh`: local Paper CRUD repository using the existing SQLite CLI.
- `paper_repository_verify.sh`: verifies Paper CRUD with placeholder-only temporary data.
- `dataset_repository.sh`: local Dataset metadata CRUD repository using the existing SQLite CLI.
- `dataset_repository_verify.sh`: verifies Dataset metadata CRUD with placeholder-only temporary data.
- `model_result_repository.sh`: local Model Result metadata CRUD repository using the existing SQLite CLI.
- `model_result_repository_verify.sh`: verifies Model Result metadata CRUD with placeholder-only temporary data and null metrics.

## Tables

- `papers`
- `research_domains`
- `datasets`
- `model_results`
- `weekly_logs`
- `decisions`

## Verify The Schema

To verify the schema without creating a database file:

```bash
sqlite3 :memory: < db/schema.sql
```

To create a local database file later:

```bash
sqlite3 db/sleep_research_think_tank.sqlite < db/schema.sql
```

Do not commit generated `.sqlite` files unless a later phase explicitly approves it.

## Verify Placeholder Seeds

To verify the schema and placeholder seed data without creating a database file:

```bash
sqlite3 :memory: < db/schema.sql
sqlite3 :memory: ".read db/schema.sql" ".read db/seed_placeholder.sql"
```

The seed file contains placeholders only:

- one placeholder research domain
- one placeholder Sleep-EDF planning dataset record with unknown values marked as `to be confirmed`
- one placeholder weekly log
- one placeholder decision

It does not seed fake real papers, fake citations, scientific claims, model results, or dataset statistics.

## Paper CRUD Repository

Phase 10C adds a local Paper CRUD repository script. It is not connected to the website UI and does not expose API routes.

Available commands:

```bash
bash db/paper_repository.sh createPaper ...
bash db/paper_repository.sh listPapers <db>
bash db/paper_repository.sh getPaperById <db> <id>
bash db/paper_repository.sh updatePaper <db> <id> <field> <value>
bash db/paper_repository.sh deletePaper <db> <id>
```

Run local verification with:

```bash
bash db/paper_repository_verify.sh
```

The verification script uses a temporary SQLite database and deletes it when finished.

## Dataset Metadata CRUD Repository

Phase 12C adds a local Dataset metadata CRUD repository script. It is not connected to the Dataset Viewer UI and does not expose API routes.

Available commands:

```bash
bash db/dataset_repository.sh createDataset ...
bash db/dataset_repository.sh listDatasets <db>
bash db/dataset_repository.sh getDatasetById <db> <id>
bash db/dataset_repository.sh updateDataset <db> <id> <field> <value>
bash db/dataset_repository.sh deleteDataset <db> <id>
```

Allowed dataset status values:

- `planned`
- `metadata-only`
- `raw-files-pending`
- `preprocessing-planned`
- `processed`
- `archived`

Unknown metadata values should be recorded as `to be confirmed`.

Run local verification with:

```bash
bash db/dataset_repository_verify.sh
```

The verification script uses a temporary SQLite database and deletes it when finished. It does not connect real EDF files, parse Sleep-EDF, upload datasets, call external APIs, or run model training.

## Model Result Metadata CRUD Repository

Phase 13C adds a local Model Result metadata CRUD repository script. It is not connected to the Model Results UI and does not expose API routes.

Available commands:

```bash
bash db/model_result_repository.sh createModelResult ...
bash db/model_result_repository.sh listModelResults <db>
bash db/model_result_repository.sh getModelResultById <db> <id>
bash db/model_result_repository.sh updateModelResult <db> <id> <field> <value>
bash db/model_result_repository.sh deleteModelResult <db> <id>
```

Allowed model-result status values:

- `planned`
- `training-pending`
- `evaluated`
- `failed`
- `archived`

Performance metrics must remain `null` unless they come from a real experiment. If supplied in a later approved workflow, metric values must be numbers between 0 and 1.

Run local verification with:

```bash
bash db/model_result_repository_verify.sh
```

The verification script uses a temporary SQLite database and deletes it when finished. It keeps `accuracy`, `macro_f1`, and `balanced_accuracy` null and does not run model training, run Sleep-EDF preprocessing, import real experiment output, call external ML APIs, or add fake model performance.
