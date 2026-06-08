# Phase 14 Checklist

## Dataset Viewer Connection Readiness

- [x] Phase 12 Dataset CRUD exists
- [x] Dataset Viewer page located
- [x] Dataset metadata connection strategy selected
- [x] Read-only UI connection planned
- [x] Search/filter connection planned
- [x] Create/edit/delete UI deferred until approved
- [x] No EDF files added
- [x] No Sleep-EDF preprocessing added
- [x] No fake dataset statistics added
- [x] No model training added
- [x] Static limitation note created for the current static-only repo
- [x] Dataset search/filter connection deferred until a backend adapter exists
- [ ] GitHub sync pending

## Current Strategy

The current repository is plain static HTML/CSS. It does not support API routes, server-side data fetching, or browser access to SQLite.

The safest Phase 14 strategy is:

1. Keep the Dataset Viewer static until a backend adapter exists.
2. Do not import SQLite or shell scripts into browser code.
3. Document the data-flow boundary before attempting UI connection.
4. Add API routes or a backend adapter in a future phase before rendering live dataset metadata.
5. Preserve placeholder labelling until real dataset metadata is approved.

## Planned UI States

Future connected Dataset Viewer states should include:

- loading
- empty state
- error state
- list of dataset metadata records
- placeholder notice when seed metadata is used

## Planned Search And Filter Scope

Future search and filters should operate only on loaded local dataset metadata.

Planned filters:

- text search
- status filter
- file-format filter
- signal-type filter if simple and compatible

Filtering must not mutate the database.

In the current static-only repository, search and filters remain deferred. They should not be connected to fake browser data or direct SQLite access.

## Deferred Work

Do not add these items in Phase 14B, Phase 14C, or Phase 14D:

- Dataset Viewer UI connection
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
