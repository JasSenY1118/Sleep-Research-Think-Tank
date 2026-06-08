# Phase 17C Static Limitation Note

## Purpose

Phase 17C requested a shared global search utility or adapter for local structured data.

## Current Repository Constraint

The current repository is a static HTML/CSS website. It does not currently include:

- a `src/` application source directory
- a TypeScript or JavaScript frontend app structure
- a package manager configuration
- a build, lint, typecheck, or test script
- runtime JavaScript modules for shared imports
- connected local UI data sources for Paper Library, Dataset Viewer, or Model Results
- API routes or server-side data fetching

Because of this, creating files such as `src/utils/globalSearch.ts` or `src/types/search.ts` would add unused code that the current website cannot import, execute, or verify.

## Phase 17C Decision

Global search runtime utilities are deferred until the project has a compatible frontend app structure or backend adapter.

No global search utility code was added in Phase 17C.

## Phase 17D Global Search Page Decision

Phase 17D requested a dedicated Global Search page that searches across local Papers, Datasets, and Model Results.

Because the repository still does not have global search utilities, connected local UI data sources, a frontend app structure, or a backend adapter, the Global Search page is deferred. Adding a static page that appears to search placeholder cards would risk misleading behaviour and would not satisfy the local structured-data requirement.

No Global Search page, navigation entry, header search box, or search UI behaviour was added in Phase 17D.

## Phase 17E Result Navigation Decision

Phase 17E requested navigation from global search results to the relevant module.

Because Phase 17D did not add a Global Search page and the repository still has no runtime global search result set, result navigation is deferred. There are no result cards or result rows to link safely yet.

When implementation becomes safe, global search results can link to:

- Paper Library
- Dataset Viewer
- Model Results

Record-level routes do not exist in the current static website, so future navigation should initially link to the relevant module section only.

No global search result navigation, record-level route, detail page, or CRUD behaviour was added in Phase 17E.

## Future Global Search Result Shape

When the project has a compatible source structure, a reusable `GlobalSearchResult` shape can include:

- id
- type
- title
- subtitle
- description
- tags
- href or targetModule
- sourceRecordId

Supported result categories should include:

- paper
- dataset
- model-result

## Future Utility Scope

When implementation becomes safe, the global search adapter can include:

- safe text normalisation
- case-insensitive matching
- null and undefined handling
- mapping Paper records to global search results
- mapping Dataset records to global search results
- mapping ModelResult records to global search results
- grouping results by category
- counting results per category
- preserving null model metrics as `not available`

## Future Global Search Page Scope

When implementation becomes safe, a dedicated Global Search page can include:

- page title: Global Search
- subtitle: Search across local papers, datasets, and model-result records in the Sleep Research Think Tank.
- initial state
- loading state if needed
- grouped results for Papers, Datasets, and Model Results
- result counts per group
- empty state
- error state
- simple links back to the relevant module

The page should use local structured data only and should not invent missing fields.

## Future Result Navigation Scope

When implementation becomes safe, global search result actions can use labels such as:

- Open in Paper Library
- Open in Dataset Viewer
- Open in Model Results

If record-level routes are still unavailable, these actions should link only to the relevant module section.

## Required Future Conditions

Before implementing global search utilities, the repository should have:

- a deliberate frontend source structure or backend adapter
- a clear local data-loading path for Paper, Dataset, and ModelResult records
- a way to import shared JavaScript or TypeScript utilities
- build, lint, typecheck, or test verification where applicable

## Guardrails Preserved

Phase 17C did not add:

- UI changes
- database schema changes
- CRUD changes
- API routes
- semantic search
- embeddings
- vector database integration
- external API calls
- fake papers
- fake dataset statistics
- fake model performance
- PDF search
- EDF upload or preprocessing
- model training

Phase 17D also did not add:

- Global Search page
- header search box
- navigation changes
- runtime search behaviour
- fake search results
- static placeholder search masquerading as local structured-data search

Phase 17E also did not add:

- global search result navigation
- record-level routes
- detail pages
- new CRUD behaviour
- navigation changes

## Suggested Checkpoint

Phase 17C — Global Search Utility Deferred

Phase 17D — Global Search Page Deferred

Phase 17E — Global Search Result Navigation Deferred
