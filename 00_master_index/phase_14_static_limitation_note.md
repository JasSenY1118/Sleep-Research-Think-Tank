# Phase 14 Static Limitation Note

## Purpose

Phase 14C requested a read-only Dataset Viewer connection to local Dataset metadata.

This repository is currently a plain static HTML/CSS website. It does not include a backend runtime, JavaScript application framework, server-side data fetching, API route support, or browser-safe SQLite adapter.

## Why UI Connection Is Deferred

The existing Dataset CRUD layer is local and shell-based:

- `db/schema.sql`
- `db/dataset_repository.sh`
- `db/dataset_repository_verify.sh`

That layer is safe for local verification, but it cannot be imported or called directly from browser HTML. A browser page should not execute local shell scripts or access SQLite database files directly.

Forcing a direct connection now would create a broken or unsafe architecture.

## Required Backend Adapter

Before the Dataset Viewer UI can read local Dataset metadata records, the project needs a deliberate backend adapter.

A future backend adapter should:

1. Run server-side.
2. Read from the local SQLite database.
3. Expose a read-only Dataset API first.
4. Keep SQLite and shell/database logic out of browser code.
5. Preserve placeholder labelling until real dataset metadata is approved.
6. Keep EDF files, hypnograms, and preprocessing code separate from metadata-only records.

Recommended future read-only route:

- `GET /api/datasets`

Optional future detail route:

- `GET /api/datasets/:id`

Write routes should remain deferred until explicitly approved:

- `POST /api/datasets`
- `PATCH /api/datasets/:id`
- `DELETE /api/datasets/:id`

## Current Phase 14C Outcome

No Dataset Viewer UI connection was added in Phase 14C.

The Dataset Viewer remains static and clearly labelled as a planning prototype. The local Dataset CRUD repository remains available for command-line verification only.

## Phase 14D Search And Filter Outcome

Phase 14D requests connected Dataset Viewer search and filters against local Dataset metadata.

This should remain deferred while the repository is static-only. Search and filters can only be meaningfully connected after the Dataset Viewer has a safe read-only data source.

Do not connect static filter controls to fake data or browser-side SQLite access. The correct future sequence is:

1. Add a backend adapter.
2. Add a read-only Dataset list endpoint.
3. Load Dataset metadata records into the Dataset Viewer.
4. Connect search and filters to the loaded local metadata.

Until then, Dataset Viewer controls and metadata sections should remain static placeholders.

No Dataset Viewer search or filter behavior was added in Phase 14D.

## No UI Or Data Processing Changes

No changes were made to:

- `index.html`
- `styles.css`
- `db/schema.sql`
- `db/dataset_repository.sh`
- `db/dataset_repository_verify.sh`

## Guardrails Preserved

Phase 14C and Phase 14D did not add:

- create/edit/delete UI
- real EDF files
- EDF upload
- EDF parsing
- hypnogram parsing
- signal processing
- Sleep-EDF preprocessing
- class-distribution calculation
- fake dataset statistics
- model training
- external dataset API
- authentication

## Recommended Next Step

Plan a backend adapter before attempting Dataset Viewer data connection.

Suggested next checkpoints:

- Phase 14C — Static Limitation Documented
- Phase 14D — Dataset Search And Filters Deferred
