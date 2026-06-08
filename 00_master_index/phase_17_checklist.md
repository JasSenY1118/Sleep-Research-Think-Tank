# Phase 17 Checklist

## Global Search Planning Readiness

- [x] Paper Library module located
- [x] Dataset Viewer module located
- [x] Model Results module located
- [x] Paper local database repository exists
- [x] Dataset metadata local database repository exists
- [x] ModelResult local database repository exists
- [x] Paper Library UI data connection reviewed
- [x] Dataset Viewer UI data connection reviewed
- [x] Model Results UI data connection reviewed
- [x] Phase 16 search/filter status reviewed
- [x] Global search plan created
- [x] No semantic search added
- [x] No vector database added
- [x] No embeddings added
- [x] No external API added
- [x] No fake data added
- [x] Static limitation note created if Phase 17C proceeds in the current static-only repo
- [x] Global Search page deferred in the current static-only repo
- [ ] GitHub sync pending

## Current Module Status

Paper Library:

- Static placeholder paper cards exist.
- Static search/filter placeholder controls exist.
- The UI is not connected to local Paper records.
- Paper Library local data connection remains deferred until a backend adapter exists.

Dataset Viewer:

- Static dataset planning content exists.
- The UI is not connected to local Dataset metadata records.
- Dataset Viewer local metadata connection remains deferred until a backend adapter exists.

Model Results:

- Static model-result planning content exists.
- The UI is not connected to local ModelResult records.
- ModelResult local data connection remains deferred until a backend adapter exists.
- Null metrics remain displayed as `not available`.

Global Search:

- No global search page exists yet.
- No global search component exists yet.
- No global search utility exists yet.
- No header search box exists yet.
- Global Search page implementation remains deferred until shared runtime utilities and a safe local data source exist.
- Global Search result navigation remains deferred until a real global search result set exists.

## Current Strategy

The current repository is plain static HTML/CSS. It does not support shared JavaScript or TypeScript utilities, API routes, server-side data fetching, or browser access to SQLite.

The safest Phase 17 strategy is:

1. Plan global search behaviour first.
2. Do not create unused `src/utils` files in the current static-only repo.
3. Do not connect global search to fake browser data.
4. Do not connect browser code directly to SQLite or shell scripts.
5. Add a backend adapter or frontend app structure before implementing global search utilities.
6. Prefer a dedicated Global Search page after a safe data path exists.

## Shared Behaviour To Preserve Later

- Case-insensitive search.
- Safe null/undefined handling.
- Grouped results by type.
- Result counts per type.
- Clear empty state.
- Search must not mutate records.
- Search must use local structured data only.
- Null model metrics must remain `not available`.

## Deferred Work

Do not add these items in Phase 17B:

- global search implementation
- global search page
- header search box
- shared runtime utilities
- UI changes
- semantic search
- vector database
- embeddings
- external API
- fake paper data
- fake dataset statistics
- fake model performance
- PDF search
- EDF upload or preprocessing
- model training
- database schema changes
- CRUD behaviour changes

## Phase 17D Status

Phase 17D did not modify the website UI because the repository does not yet have global search utilities, connected local UI data, a frontend app structure, or a backend adapter. A Global Search page should be implemented only after local structured data can be loaded safely and searched without fake browser-side records.

## Phase 17E Status

Phase 17E did not modify website navigation because no Global Search page or runtime result set exists yet. Future result navigation should initially link to module sections only, unless record-level routes are added in a later approved phase.
