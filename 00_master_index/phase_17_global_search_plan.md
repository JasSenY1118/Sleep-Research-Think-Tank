# Phase 17 Global Search Plan

## Purpose

Add a local global search feature across the Sleep Research Think Tank.

## Boundary

Phase 17 is limited to planning local structured-data search.

Do not add:

- semantic search
- vector database
- embeddings
- PubMed/CrossRef API
- external API
- PDF search
- real paper import
- EDF parsing
- model training
- fake scientific data
- database schema changes
- CRUD behaviour changes

## Included Modules

- Paper Library
- Dataset Viewer
- Model Results

## Optional Future Modules

- Weekly Progress
- Decision Log
- Research Map

## Current Repository Constraint

The current repository is plain static HTML/CSS. It does not include:

- a JavaScript or TypeScript app structure
- a `src/` source directory
- shared runtime search utilities
- connected local data in the UI
- API routes
- server-side data fetching
- a package manager or build pipeline

Paper Library, Dataset Viewer, and Model Results data connections are currently documented as deferred until a backend adapter or compatible frontend app structure exists.

Global search should not be wired to fake browser data, static placeholder cards, shell scripts, or direct SQLite access from the browser.

## Search Result Types

- Paper result
- Dataset result
- Model result

## Paper Result Fields

Future Paper search results should be able to use:

- title
- authors
- researchDomain
- tags
- mainQuestion
- methods
- keyFinding

## Dataset Result Fields

Future Dataset search results should be able to use:

- name
- source
- fileFormat
- signalTypes
- task
- status
- notes

## Model Result Fields

Future ModelResult search results should be able to use:

- modelName
- datasetName
- inputSignals
- splitType
- status
- notes

## Required Global Search Behaviour

- Search should be case-insensitive.
- Search should handle null and undefined values safely.
- Results should be grouped by type.
- Each result group should show a count.
- Empty results should show a clear empty state.
- Search should not mutate database records.
- Search should operate only on currently available local data.
- Null model metrics must remain `not available`.
- Placeholder records must stay clearly labelled if seed data is ever displayed.

## Recommended Implementation

Do not implement runtime global search until the project has a compatible local data access path.

When implementation becomes safe:

1. Reuse Phase 16 search/filter utilities where possible.
2. Add a small global search adapter only if it keeps module logic simple.
3. Avoid large refactors.
4. Avoid changing CRUD services.
5. Prefer a dedicated Global Search page over a header search box at first.
6. Keep the design consistent with the academic dashboard style.
7. Keep results grouped by category.
8. Keep null model metrics displayed as `not available`.

## Dedicated Page Versus Header Search

A dedicated Global Search page is the safest first implementation because it can show:

- an initial state
- grouped results
- result counts
- empty state
- error state
- clear module navigation

A header search box should remain a later enhancement because the current static navigation is already compact and there is no runtime data layer yet.

## Future Utility Shape

If a compatible app structure is added later, a global search result shape can include:

- id
- type
- title
- subtitle
- description
- tags
- href or targetModule
- sourceRecordId

## Future Phases

- Phase 18: Weekly and Decision Log integration.
- Phase 19: Sleep-EDF preprocessing pipeline planning.
- Phase 20: semantic search planning only after local structured search is stable.

## Safe Phase 17C Recommendation

For the current static-only repository, Phase 17C should not create `src/utils/globalSearch.ts` or `src/types/search.ts` yet because there is no `src` folder, package manager, TypeScript configuration, build step, or connected UI data.

If Phase 17C proceeds before the architecture changes, create a static limitation note instead:

- `00_master_index/phase_17_static_limitation_note.md`

That note should explain why global search utilities are deferred until a backend adapter or frontend app structure exists.
