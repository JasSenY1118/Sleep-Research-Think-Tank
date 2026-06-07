# Phase 12 Dataset Metadata CRUD Plan

## Purpose

Build local CRUD logic for dataset metadata records.

## Boundary

Phase 12 is limited to dataset metadata only.

Do not add:

- real EDF upload
- Sleep-EDF preprocessing
- signal parsing
- hypnogram parsing
- model training
- external dataset API
- production database
- authentication
- Dataset Viewer UI connection

## Current Repository Finding

The repository is currently a plain static HTML/CSS website. It has no package manager, TypeScript configuration, JavaScript application framework, backend runtime, or API route support.

The existing Phase 9 local database schema already includes a `datasets` table in `db/schema.sql`.

The Phase 10 Paper CRUD implementation provides a safe pattern for Phase 12:

- local shell repository
- SQLite CLI access
- temporary verification database
- no UI connection
- no API routes in the static-only repo

## CRUD Operations

The Dataset repository should provide:

- `createDataset`
- `listDatasets`
- `getDatasetById`
- `updateDataset`
- `deleteDataset`

## Dataset Fields

Dataset metadata records should support:

- `id`
- `name`
- `source`
- `fileFormat`
- `signalTypes`
- `annotationType`
- `epochLength`
- `task`
- `status`
- `notes`

## Validation Rules

- `name` is required.
- `fileFormat` can be unknown and should be recorded as `to be confirmed`.
- `signalTypes` should be stored consistently with the existing schema as an array or serialised array.
- `status` should be controlled.
- Unknown values should be stored explicitly as `to be confirmed` rather than invented.

Allowed `status` values:

- `planned`
- `metadata-only`
- `raw-files-pending`
- `preprocessing-planned`
- `processed`
- `archived`

## Recommended Implementation

Use the existing Phase 9 local database approach.

Follow the Paper CRUD pattern from Phase 10:

1. Create a small local repository/service script for datasets.
2. Use the existing `datasets` table in `db/schema.sql`.
3. Validate required fields and controlled status values.
4. Store unknown values as `to be confirmed`.
5. Add a temporary local verification script.
6. Do not connect the Dataset Viewer UI yet.

Add API routes only if the project later adopts a framework that supports them cleanly.

## Future Phases

- Phase 13: Model Result CRUD
- Phase 14: connect Dataset Viewer to local dataset metadata
- Phase 15: search/filter integration
- Phase 16: real Sleep-EDF preprocessing pipeline planning

## Phase 12D Expectation

If the repository remains static-only in Phase 12D, do not force API routes. Create an API limitation note instead.
