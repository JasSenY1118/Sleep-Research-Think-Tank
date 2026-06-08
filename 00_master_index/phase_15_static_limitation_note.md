# Phase 15 Static Limitation Note

## Purpose

Phase 15C requested a read-only Model Results connection to local ModelResult metadata.

This repository is currently a plain static HTML/CSS website. It does not include a backend runtime, JavaScript application framework, server-side data fetching, API route support, or browser-safe SQLite adapter.

## Why UI Connection Is Deferred

The existing ModelResult CRUD layer is local and shell-based:

- `db/schema.sql`
- `db/model_result_repository.sh`
- `db/model_result_repository_verify.sh`

That layer is safe for local verification, but it cannot be imported or called directly from browser HTML. A browser page should not execute local shell scripts or access SQLite database files directly.

Forcing a direct connection now would create a broken or unsafe architecture.

## Required Backend Adapter

Before the Model Results UI can read local ModelResult metadata records, the project needs a deliberate backend adapter.

A future backend adapter should:

1. Run server-side.
2. Read from the local SQLite database.
3. Expose a read-only ModelResult API first.
4. Keep SQLite and shell/database logic out of browser code.
5. Preserve placeholder labelling until real model-result metadata is approved.
6. Keep metric display separate from any training or experiment pipeline.
7. Display null metrics as `not available` or `pending`.

Recommended future read-only route:

- `GET /api/model-results`

Optional future detail route:

- `GET /api/model-results/:id`

Write routes should remain deferred until explicitly approved:

- `POST /api/model-results`
- `PATCH /api/model-results/:id`
- `DELETE /api/model-results/:id`

## Current Phase 15C Outcome

No Model Results UI connection was added in Phase 15C.

The Model Results page remains static and clearly labelled as a planning prototype. The local ModelResult CRUD repository remains available for command-line verification only.

## Phase 15D Search And Filter Outcome

Phase 15D requests connected Model Results search and filters against local ModelResult metadata.

This should remain deferred while the repository is static-only. Search and filters can only be meaningfully connected after the Model Results page has a safe read-only data source.

Do not connect static filter controls to fake data or browser-side SQLite access. The correct future sequence is:

1. Add a backend adapter.
2. Add a read-only ModelResult list endpoint.
3. Load ModelResult metadata records into the Model Results page.
4. Connect search and filters to the loaded local metadata.
5. Keep null metrics displayed as `not available` or `pending`.

Until then, Model Results controls and metadata sections should remain static placeholders.

No Model Results search or filter behavior was added in Phase 15D.

## Metric Display Guardrails

Future connected UI must follow these rules:

- If `accuracy` is null, display `not available`.
- If `macroF1` is null, display `not available`.
- If `balancedAccuracy` is null, display `not available`.
- Do not invent, infer, or calculate metric values in the website.
- Only display numeric metrics when they come from an explicit local record.
- Do not make placeholder metadata look like real experiment output.

## No UI Or Model Pipeline Changes

No changes were made to:

- `index.html`
- `styles.css`
- `db/schema.sql`
- `db/model_result_repository.sh`
- `db/model_result_repository_verify.sh`

## Guardrails Preserved

Phase 15C and Phase 15D did not add:

- create/edit/delete UI
- fake accuracy values
- fake macro-F1 values
- fake balanced-accuracy values
- model training
- Sleep-EDF preprocessing
- real experiment import
- automatic metric calculation
- TensorBoard/W&B integration
- external ML API
- authentication

## Recommended Next Step

Plan a backend adapter before attempting Model Results data connection.

Suggested next checkpoint:

Phase 15C — Static Limitation Documented

Phase 15D — Model Result Search And Filters Deferred
