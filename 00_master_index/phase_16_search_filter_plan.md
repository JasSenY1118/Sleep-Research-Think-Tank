# Phase 16 Search Filter Plan

## Purpose

Standardise local search and filtering across Paper Library, Dataset Viewer, and Model Results.

## Boundary

Phase 16 is limited to planning local search/filter behaviour.

Do not add:

- semantic search
- vector database
- embeddings
- external API
- PubMed/CrossRef search
- real paper import
- EDF parsing
- model training
- fake scientific data
- database schema changes
- CRUD behaviour changes

## Modules Included

- Paper Library
- Dataset Viewer
- Model Results

## Modules Excluded For Now

- Dashboard
- Research Map
- Weekly Progress

## Current Repository Constraint

The current repository is plain static HTML/CSS. It does not include a JavaScript or TypeScript app structure, shared source utilities, connected local data in the UI, API routes, or server-side data fetching.

Paper Library, Dataset Viewer, and Model Results data connections are currently documented as deferred until a backend adapter exists. Search/filter implementation should not be wired to fake browser data or direct SQLite access.

## Shared Search/Filter Principles

- Text search should be case-insensitive.
- Null and undefined values should be handled safely.
- Search should not mutate database records.
- Filters should operate on currently loaded local data.
- Empty filtered results should show clear messages.
- Reset filters should be available where simple and safe.
- Null model metrics should remain `not available` or `pending`.
- Placeholder records should stay clearly labelled.

## Paper Library Fields

Future Paper Library search/filter should support:

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

## Dataset Viewer Fields

Future Dataset Viewer search/filter should support:

- name
- source
- fileFormat
- signalTypes
- annotationType
- epochLength
- task
- status
- notes

## Model Results Fields

Future Model Results search/filter should support:

- modelName
- datasetName
- inputSignals
- splitType
- accuracy
- macroF1
- balancedAccuracy
- status
- notes

## Recommended Implementation

Do not add shared utilities until the project has a compatible app/source structure or connected local data in the UI.

When implementation becomes safe:

1. Add shared search/filter utilities only if they remove real duplication.
2. Keep utility functions small and readable.
3. Avoid large refactors.
4. Preserve existing UI design.
5. Replace duplicated filtering logic gradually.
6. Keep each module independently testable.
7. Keep null model metrics displayed as `not available` or `pending`.

Potential utility functions later:

- `normaliseSearchText`
- `matchesTextQuery`
- `matchesOneOf`
- `matchesStatus`
- `matchesYearBucket`
- `hasActiveFilters`

## Future Phases

- Phase 17: cross-module global search planning.
- Phase 18: semantic search planning only after stable structured local search exists.
- Phase 19: Sleep-EDF preprocessing pipeline planning.

## Safe Phase 16C Recommendation

For the current static-only repository, Phase 16C should not create `src/utils/search.ts` or `src/utils/filters.ts` yet because there is no `src` folder, package manager, TypeScript configuration, build step, or connected UI data.

If Phase 16C proceeds before the architecture changes, create a limitation note instead:

- `00_master_index/phase_16_static_limitation_note.md`

That note should explain why shared utilities are deferred until a backend adapter or frontend app structure exists.
