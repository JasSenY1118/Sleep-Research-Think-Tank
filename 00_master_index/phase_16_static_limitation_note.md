# Phase 16C Static Limitation Note

## Purpose

Phase 16C requested a shared search/filter utility layer for the Sleep Research Think Tank website.

## Current Repository Constraint

The current repository is a static HTML/CSS website. It does not currently include:

- a `src/` application source directory
- a TypeScript or JavaScript frontend app structure
- a package manager configuration
- a build, lint, typecheck, or test script
- runtime JavaScript modules for shared imports
- connected local data sources for Paper Library, Dataset Viewer, or Model Results

Because of this, creating files such as `src/utils/search.ts` or `src/utils/filters.ts` would add unused code that the current website cannot import, execute, or verify.

## Phase 16C Decision

Shared runtime search/filter utilities are deferred until the project has a compatible frontend or backend adapter structure.

No shared utility code was added in Phase 16C.

## Phase 16D Paper Library Decision

Phase 16D requested standardising Paper Library search/filter behaviour against the shared utilities from Phase 16C.

Because Phase 16C did not add runtime utilities in the current static-only repository, Paper Library search/filter standardisation is also deferred. The Paper Library page remains a static placeholder interface and should not be wired to fake browser data or unused utility files.

No Paper Library UI behaviour was changed in Phase 16D.

## Phase 16E Dataset Viewer Decision

Phase 16E requested standardising Dataset Viewer search/filter behaviour against the shared utilities from Phase 16C.

Because the repository still does not have importable runtime utilities or a connected Dataset metadata UI data source, Dataset Viewer search/filter standardisation is deferred. The Dataset Viewer page should continue presenting static planning content until a compatible app structure or backend adapter exists.

No Dataset Viewer UI behaviour was changed in Phase 16E.

## Phase 16F Model Results Decision

Phase 16F requested standardising Model Results search/filter behaviour against the shared utilities from Phase 16C.

Because the repository still does not have importable runtime utilities or a connected ModelResult UI data source, Model Results search/filter standardisation is deferred. The Model Results page should continue presenting static planning content and null metric placeholders until a compatible app structure or backend adapter exists.

No Model Results UI behaviour was changed in Phase 16F.

## Future Utility Scope

When the project has a compatible source structure, the shared utility layer can include:

- `normaliseSearchText`
- `matchesTextQuery`
- `matchesOneOf`
- `matchesStatus`
- `matchesYearBucket`
- `hasActiveFilters`

These utilities should support local, case-insensitive filtering across:

- Paper Library
- Dataset Viewer
- Model Results

For Paper Library specifically, future filtering should support:

- title
- authors
- methods
- tags
- key finding
- main question
- domain
- status
- year

For Dataset Viewer specifically, future filtering should support:

- name
- source
- file format
- signal types
- annotation type
- task
- notes
- status

For Model Results specifically, future filtering should support:

- model name
- dataset name
- input signals
- split type
- status
- notes
- null metrics displayed as `not available`

## Required Future Conditions

Before implementing shared search/filter utilities, the repository should have:

- a deliberate frontend source structure or backend adapter
- a clear local data-loading path for paper, dataset, and model-result records
- a way to import shared JavaScript or TypeScript utilities
- build, lint, typecheck, or test verification where applicable

## Guardrails Preserved

Phase 16C did not add:

- UI changes
- database schema changes
- API routes
- semantic search
- embeddings
- vector database integration
- external API calls
- fake papers
- fake dataset statistics
- fake model performance
- EDF upload or preprocessing
- model training

Phase 16D also did not add Paper Library runtime filtering, real papers, fake citations, external APIs, semantic search, or vector database integration.

Phase 16E also did not add Dataset Viewer runtime filtering, EDF upload, EDF parsing, hypnogram parsing, Sleep-EDF preprocessing, fake dataset statistics, external APIs, semantic search, or vector database integration.

Phase 16F also did not add Model Results runtime filtering, fake accuracy values, fake macro-F1 values, fake balanced-accuracy values, model training, Sleep-EDF preprocessing, external ML APIs, semantic search, or vector database integration.

## Suggested Checkpoint

Phase 16C — Shared Search Utilities Deferred

Phase 16D — Paper Library Search Standardisation Deferred

Phase 16E — Dataset Viewer Search Standardisation Deferred

Phase 16F — Model Results Search Standardisation Deferred
