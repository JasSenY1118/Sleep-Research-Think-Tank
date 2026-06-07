# Phase 11 Static Limitation Note

## Purpose

Phase 11C requested a read-only Paper Library connection to local Paper data.

This repository is currently a plain static HTML/CSS website. It does not include a backend runtime, JavaScript application framework, server-side data fetching, API route support, or browser-safe SQLite adapter.

## Why UI Connection Is Deferred

The existing Paper CRUD layer is local and shell-based:

- `db/schema.sql`
- `db/paper_repository.sh`
- `db/paper_repository_verify.sh`

That layer is safe for local verification, but it cannot be imported or called directly from browser HTML. A browser page should not execute local shell scripts or access SQLite database files directly.

Forcing a direct connection now would create a broken or unsafe architecture.

## Required Backend Adapter

Before the Paper Library UI can read local Paper records, the project needs a deliberate backend adapter.

A future backend adapter should:

1. Run server-side.
2. Read from the local SQLite database.
3. Expose a read-only Paper API first.
4. Keep SQLite and shell/database logic out of browser code.
5. Preserve placeholder labelling until real papers are approved.

Recommended future read-only route:

- `GET /api/papers`

Optional future detail route:

- `GET /api/papers/:id`

Write routes should remain deferred until explicitly approved:

- `POST /api/papers`
- `PATCH /api/papers/:id`
- `DELETE /api/papers/:id`

## Current Phase 11C Outcome

No Paper Library UI connection was added in Phase 11C.

## Phase 11D Search And Filter Outcome

Phase 11D requested connected Paper Library search and filters against local Paper data.

This is also deferred while the repository remains static-only. Search and filters can only be meaningfully connected after the Paper Library has a safe read-only data source.

Do not connect the static filter controls to fake data or browser-side SQLite access. The correct future sequence is:

1. Add a backend adapter.
2. Add a read-only Paper list endpoint.
3. Load Paper records into the Paper Library.
4. Connect search and filters to the loaded local records.

Until then, Paper Library controls should remain static placeholders.

No changes were made to:

- `index.html`
- `styles.css`
- `db/schema.sql`
- `db/paper_repository.sh`
- `db/paper_repository_verify.sh`

## Guardrails Preserved

Phase 11C did not add:

- create/edit/delete UI
- real paper import
- fake real citations
- PDF upload
- external API
- semantic search
- authentication
- model results
- Sleep-EDF preprocessing
- dataset/model/weekly CRUD

## Recommended Next Step

Plan a backend adapter before attempting Paper Library data connection.

Suggested next checkpoint:

Phase 11C — Static Limitation Documented

Phase 11D — Search And Filters Deferred
