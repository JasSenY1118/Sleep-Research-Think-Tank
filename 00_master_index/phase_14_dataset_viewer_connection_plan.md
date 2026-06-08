# Phase 14 Dataset Viewer Connection Plan

## Purpose

Connect the Dataset Viewer to the local Dataset metadata CRUD/database layer.

## Boundary

Phase 14 is limited to planning a Dataset Viewer connection to local dataset metadata.

Do not add:

- real EDF upload
- EDF parsing
- hypnogram parsing
- signal processing
- Sleep-EDF preprocessing
- class-distribution calculation
- model training
- external dataset API
- production database
- authentication
- fake dataset statistics

## Current Repository Constraint

The current repository is plain static HTML/CSS. It does not provide API routes, server-side data fetching, or a browser-safe way to access SQLite.

The Dataset CRUD layer exists as local shell scripts around SQLite. That is safe for local verification, but it should not be imported into browser code or called from static HTML.

## Recommended Data-Flow Approach

Because this repository is static-only, do not force SQLite into the browser.

Recommended approach for now:

1. Keep the Dataset Viewer static and clearly labelled.
2. Document the backend adapter requirement before UI connection.
3. Add a future backend or full-stack framework before connecting the Dataset Viewer to local metadata.
4. Once a backend exists, expose dataset metadata through safe local API routes.

If API routes exist in a future phase, Dataset Viewer should fetch from the local Dataset API.

If a server-side framework supports direct data access in a future phase, use that framework's safest server-side pattern. The browser should still not read SQLite files directly.

## UI States Required For Future Connection

When Dataset Viewer is connected later, it should support:

- loading
- empty state
- error state
- list of dataset metadata records
- placeholder notice when seed metadata is being used

Empty state text:

> No dataset metadata has been added yet. Add dataset records in a future CRUD phase.

Error state text:

> Dataset metadata could not be loaded.

## Dataset Fields To Display

Future connected records should display:

- name
- source
- fileFormat
- signalTypes
- annotationType
- epochLength
- task
- status
- notes

Unknown values should remain clearly marked as `to be confirmed`.

## Future Subphases

- Phase 14C: read-only local Dataset metadata connection
- Phase 14D: search and filters connected to local metadata
- Phase 14E: create/edit/delete UI only if safe
- Phase 14F: verification
- Phase 14G: GitHub sync

## Safe Phase 14C Recommendation

For the current static-only repository, Phase 14C should not connect the Dataset Viewer directly to SQLite.

Instead, Phase 14C should create:

- `00_master_index/phase_14_static_limitation_note.md`

That note should explain why a backend adapter is required before a real UI connection.
