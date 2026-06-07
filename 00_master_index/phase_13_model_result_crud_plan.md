# Phase 13 Model Result CRUD Plan

## Purpose

Build local CRUD logic for model-result records.

## Boundary

Phase 13 is limited to model result metadata only.

Do not add:

- model training
- Sleep-EDF preprocessing
- real experiment import
- fake performance numbers
- TensorBoard or W&B integration
- external ML API
- production database
- authentication
- Model Results UI connection

## Current Repository Finding

The repository is currently a plain static HTML/CSS website. It has no package manager, TypeScript configuration, JavaScript application framework, backend runtime, or API route support.

The existing Phase 9 local database schema already includes a `model_results` table in `db/schema.sql`.

The Phase 10 Paper CRUD and Phase 12 Dataset CRUD implementations provide safe patterns for Phase 13:

- local shell repository
- SQLite CLI access
- temporary verification database
- no UI connection
- no API routes in the static-only repo

## CRUD Operations

The Model Result repository should provide:

- `createModelResult`
- `listModelResults`
- `getModelResultById`
- `updateModelResult`
- `deleteModelResult`

## ModelResult Fields

Model-result records should support:

- `id`
- `modelName`
- `datasetName`
- `inputSignals`
- `splitType`
- `accuracy`
- `macroF1`
- `balancedAccuracy`
- `status`
- `notes`
- `createdAt`

## Validation Rules

- `modelName` is required.
- `datasetName` is required.
- `inputSignals` should be stored consistently with the existing schema as an array or serialised array.
- `accuracy` can be null.
- `macroF1` can be null.
- `balancedAccuracy` can be null.
- `status` should be controlled.
- Performance fields must remain null unless based on a real experiment.
- No fake model values should be inserted.

Allowed `status` values:

- `planned`
- `training-pending`
- `evaluated`
- `failed`
- `archived`

If performance metrics are provided in a later approved workflow, they must be numbers between 0 and 1.

## Recommended Implementation

Use the existing Phase 9 local database approach.

Follow the Paper CRUD pattern from Phase 10 and the Dataset CRUD pattern from Phase 12:

1. Create a small local repository/service script for model results.
2. Use the existing `model_results` table in `db/schema.sql`.
3. Validate required fields and controlled status values.
4. Keep performance metrics null unless explicitly supplied from a real experiment.
5. Add a temporary local verification script.
6. Do not connect the Model Results UI yet.

Add API routes only if the project later adopts a framework that supports them cleanly.

## Future Phases

- Phase 14: connect Dataset Viewer to local dataset metadata
- Phase 15: connect Model Results page to local model-result data
- Phase 16: search/filter integration
- Phase 17: Sleep-EDF preprocessing pipeline planning
- Phase 18: real baseline model training pipeline

## Phase 13D Expectation

If the repository remains static-only in Phase 13D, do not force API routes. Create an API limitation note instead.
