# Phase 15 Write UI Limitation Note

## Purpose

Phase 15E requested create, edit, and delete UI for ModelResult records if safe.

Write UI is not safe to implement yet because the project is currently a plain static HTML/CSS website with no backend adapter, no API routes, no server-side validation layer, and no safe browser access to the local SQLite database.

## Why Write UI Is Deferred

The existing ModelResult CRUD implementation is local and shell-based:

- `db/schema.sql`
- `db/model_result_repository.sh`
- `db/model_result_repository_verify.sh`

This is appropriate for local verification, but browser UI should not call shell scripts or write directly to SQLite files.

Adding create/edit/delete controls now would require one of two unsafe paths:

1. Fake browser-only data that does not actually persist.
2. Direct local database access from static HTML, which is not a safe or supported architecture.

Both are outside the approved project direction.

## Backend/API Support Needed

Before ModelResult write UI can be added, the project needs:

1. A deliberate backend runtime.
2. Server-side ModelResult API routes.
3. Validation for required ModelResult fields.
4. Safe SQLite access on the server side.
5. Error responses for invalid input and missing records.
6. A verified read-only Model Results connection first.

Future write routes should be:

- `POST /api/model-results`
- `PATCH /api/model-results/:id`
- `DELETE /api/model-results/:id`

These should only be added after:

- `GET /api/model-results` is stable
- Model Results read-only rendering is verified
- search and filters work against loaded local metadata

## Required Future Validation

Future ModelResult write UI should validate:

- `modelName` is required
- `datasetName` is required
- `status` is one of `planned`, `training-pending`, `evaluated`, `failed`, or `archived`
- `inputSignals` can be comma-separated in the UI if the backend serialises arrays
- `accuracy` can be empty/null
- `macroF1` can be empty/null
- `balancedAccuracy` can be empty/null
- entered metric values must be numbers between 0 and 1
- empty metric values should be stored as null, not as 0
- metric values must never be auto-generated or invented

## Current Phase 15E Outcome

No create/edit/delete UI was added.

No changes were made to:

- `index.html`
- `styles.css`
- `db/schema.sql`
- `db/model_result_repository.sh`
- `db/model_result_repository_verify.sh`

## Guardrails Preserved

Phase 15E did not add:

- model training
- Sleep-EDF preprocessing
- real experiment import
- automatic metric calculation
- fake model performance
- TensorBoard/W&B integration
- external ML API
- authentication
- Paper CRUD changes
- Dataset CRUD changes
- major redesign
- new dependencies

## Recommended Next Phase

Plan and implement a backend adapter before attempting Model Results write UI.

Suggested next checkpoint:

Phase 15E — Model Result Write UI Deferred
