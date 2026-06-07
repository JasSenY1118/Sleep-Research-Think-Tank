# Phase 11 Paper Library Connection Plan

## Purpose

Connect the Paper Library to the local Paper CRUD/database layer created in Phase 10.

## Boundary

Phase 11 is limited to planning and, in later approved subphases, a safe read-only Paper Library data connection.

Do not add:

- real paper import
- PDF upload
- external metadata lookup
- PubMed or CrossRef API access
- semantic search
- authentication
- deployment database
- dataset CRUD
- model-result CRUD
- weekly-log CRUD

## Current Repository Finding

The project is currently a plain static HTML/CSS website. The Paper Library is a section in `index.html`, and the local Paper CRUD layer is a shell-based SQLite repository in `db/paper_repository.sh`.

The repository does not currently include:

- `package.json`
- TypeScript configuration
- JavaScript application framework
- backend runtime
- server-side rendering
- API route support
- browser-safe SQLite adapter

Because of this, the Paper Library should not directly call SQLite or the shell repository from the browser.

## Recommended Data Flow

### Current safest approach

Use documentation-only planning until a backend adapter exists.

Static HTML should keep placeholder Paper Library content clearly labelled. The local SQLite CRUD layer should remain a local repository and verification workflow.

### Future backend adapter approach

When approved, add a deliberate backend adapter before connecting the UI:

1. Add a small backend runtime or framework.
2. Expose local Paper API routes.
3. Keep the SQLite repository behind server-side code.
4. Let the Paper Library fetch read-only paper records from the local API.
5. Add write operations only after read-only flow is stable.

### If API routes exist in a future phase

The Paper Library should fetch from local Paper API routes:

- `GET /api/papers`
- `GET /api/papers/:id`

Write routes should remain deferred until explicitly approved:

- `POST /api/papers`
- `PATCH /api/papers/:id`
- `DELETE /api/papers/:id`

### If a server-side framework exists in a future phase

Use the safest server-side data access pattern provided by that framework. The browser should not import local SQLite scripts or shell commands.

## Required UI States For Future Connection

The connected Paper Library should support:

- loading state
- empty state
- error state
- list of papers
- placeholder notice when using seed or placeholder records

Empty state text:

> No papers have been added yet. Add papers in a future CRUD phase.

Error state text:

> Paper data could not be loaded.

## Paper Fields To Display

The read-only Paper Library connection should display:

- title
- authors
- year
- researchDomain
- tags
- mainQuestion
- methods
- keyFinding
- limitation
- relevanceScore
- status

## Future Subphases

- Phase 11C: read-only local Paper list
- Phase 11D: search and filter connected to local data
- Phase 11E: create/edit/delete UI if safe
- Phase 11F: verification
- Phase 11G: GitHub sync

## Phase 11C Recommendation

If the repository is still static-only in Phase 11C, do not force a broken Paper Library data connection. Create a static limitation note instead and defer UI connection until a backend adapter exists.
