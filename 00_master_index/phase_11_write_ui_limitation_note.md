# Phase 11 Write UI Limitation Note

## Purpose

Phase 11E requested create, edit, and delete UI for Paper records if safe.

Write UI is not safe to implement yet because the project is currently a plain static HTML/CSS website with no backend adapter, no API routes, no server-side validation layer, and no safe browser access to the local SQLite database.

## Why Write UI Is Deferred

The existing Paper CRUD implementation is local and shell-based:

- `db/schema.sql`
- `db/paper_repository.sh`
- `db/paper_repository_verify.sh`

This is appropriate for local verification, but browser UI should not call shell scripts or write directly to SQLite files.

Adding create/edit/delete controls now would require one of two unsafe paths:

1. Fake browser-only data that does not actually persist.
2. Direct local database access from static HTML, which is not a safe or supported architecture.

Both are outside the approved project direction.

## Backend/API Support Needed

Before Paper write UI can be added, the project needs:

1. A deliberate backend runtime.
2. Server-side Paper API routes.
3. Validation for required Paper fields.
4. Safe SQLite access on the server side.
5. Error responses for invalid input and missing records.
6. A verified read-only Paper Library connection first.

Future write routes should be:

- `POST /api/papers`
- `PATCH /api/papers/:id`
- `DELETE /api/papers/:id`

These should only be added after:

- `GET /api/papers` is stable
- Paper Library read-only rendering is verified
- search and filters work against loaded local data

## Current Phase 11E Outcome

No create/edit/delete UI was added.

No changes were made to:

- `index.html`
- `styles.css`
- `db/schema.sql`
- `db/paper_repository.sh`
- `db/paper_repository_verify.sh`

## Guardrails Preserved

Phase 11E did not add:

- real paper import
- fake real citations
- PDF upload
- external metadata lookup
- PubMed or CrossRef API
- semantic search
- authentication
- dataset CRUD
- model-result CRUD
- weekly-log CRUD
- major redesign
- new dependencies

## Recommended Next Phase

Plan and implement a backend adapter before attempting Paper Library write UI.

Suggested next checkpoint:

Phase 11E — Paper Write UI Deferred
