# Phase 14 Write UI Limitation Note

## Purpose

Phase 14E requested create, edit, and delete UI for Dataset metadata records if safe.

Write UI is not safe to implement yet because the project is currently a plain static HTML/CSS website with no backend adapter, no API routes, no server-side validation layer, and no safe browser access to the local SQLite database.

## Why Write UI Is Deferred

The existing Dataset CRUD implementation is local and shell-based:

- `db/schema.sql`
- `db/dataset_repository.sh`
- `db/dataset_repository_verify.sh`

This is appropriate for local verification, but browser UI should not call shell scripts or write directly to SQLite files.

Adding create/edit/delete controls now would require one of two unsafe paths:

1. Fake browser-only data that does not actually persist.
2. Direct local database access from static HTML, which is not a safe or supported architecture.

Both are outside the approved project direction.

## Backend/API Support Needed

Before Dataset metadata write UI can be added, the project needs:

1. A deliberate backend runtime.
2. Server-side Dataset API routes.
3. Validation for required Dataset fields.
4. Safe SQLite access on the server side.
5. Error responses for invalid input and missing records.
6. A verified read-only Dataset Viewer connection first.

Future write routes should be:

- `POST /api/datasets`
- `PATCH /api/datasets/:id`
- `DELETE /api/datasets/:id`

These should only be added after:

- `GET /api/datasets` is stable
- Dataset Viewer read-only rendering is verified
- search and filters work against loaded local metadata

## Required Future Validation

Future Dataset write UI should validate:

- `name` is required
- `status` is one of `planned`, `metadata-only`, `raw-files-pending`, `preprocessing-planned`, `processed`, or `archived`
- `fileFormat` can be `to be confirmed`
- `signalTypes` can be comma-separated in the UI if the backend serialises arrays
- unknown values are stored as `to be confirmed`, not invented

## Current Phase 14E Outcome

No create/edit/delete UI was added.

No changes were made to:

- `index.html`
- `styles.css`
- `db/schema.sql`
- `db/dataset_repository.sh`
- `db/dataset_repository_verify.sh`

## Guardrails Preserved

Phase 14E did not add:

- dataset upload
- EDF upload
- EDF parsing
- hypnogram parsing
- signal processing
- Sleep-EDF preprocessing
- model training
- fake dataset statistics
- external dataset API
- authentication
- Paper CRUD changes
- Model Result CRUD changes
- major redesign
- new dependencies

## Recommended Next Phase

Plan and implement a backend adapter before attempting Dataset Viewer write UI.

Suggested next checkpoint:

Phase 14E — Dataset Write UI Deferred
