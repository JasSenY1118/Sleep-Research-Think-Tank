# Phase 16 Checklist

## Search/Filter Planning Readiness

- [x] Paper Library module located
- [x] Dataset Viewer module located
- [x] Model Results module located
- [x] Paper Library search/filter status reviewed
- [x] Dataset Viewer search/filter status reviewed
- [x] Model Results search/filter status reviewed
- [x] Search/filter plan created
- [x] Shared utility strategy selected
- [x] No semantic search added
- [x] No vector database added
- [x] No external API added
- [x] No fake data added
- [x] Static limitation note created if Phase 16C proceeds in the current static-only repo
- [x] Paper Library search standardisation deferred in the current static-only repo
- [x] Dataset Viewer search standardisation deferred in the current static-only repo
- [x] Model Results search standardisation deferred in the current static-only repo
- [ ] GitHub sync pending

## Current Module Status

Paper Library:

- Static search/filter placeholder controls exist.
- The controls are not connected to local Paper records.
- Paper Library local data connection remains deferred until a backend adapter exists.
- Paper Library search standardisation remains deferred until shared runtime utilities can be imported and verified.

Dataset Viewer:

- No active search/filter controls exist.
- Dataset metadata connection remains deferred until a backend adapter exists.
- Dataset Viewer search standardisation remains deferred until shared runtime utilities can be imported and verified.

Model Results:

- No active search/filter controls exist.
- ModelResult data connection remains deferred until a backend adapter exists.
- Null metrics remain displayed as `not available`.
- Model Results search standardisation remains deferred until shared runtime utilities can be imported and verified.

## Current Strategy

The current repository is plain static HTML/CSS. It does not support shared JavaScript or TypeScript utilities, API routes, server-side data fetching, or browser access to SQLite.

The safest Phase 16 strategy is:

1. Plan shared search/filter behaviour first.
2. Do not create unused `src/utils` files in the current static-only repo.
3. Do not connect UI controls to fake browser data.
4. Do not connect browser code directly to SQLite or shell scripts.
5. Add a backend adapter or frontend app structure before implementing reusable filtering utilities.

## Shared Behaviour To Preserve Later

- Case-insensitive text search.
- Safe null/undefined handling.
- Filtering should not mutate records.
- Empty filtered states should be clear.
- Reset filters should be simple and safe.
- Null model metrics should remain `not available` or `pending`.

## Deferred Work

Do not add these items in Phase 16B:

- search/filter implementation
- shared runtime utilities
- UI changes
- semantic search
- vector database
- embeddings
- external API
- fake paper data
- fake dataset statistics
- fake model performance
- EDF upload or preprocessing
- model training
- database schema changes
- CRUD behaviour changes

## Phase 16D Status

Phase 16D did not modify the Paper Library UI because the repository does not yet have an importable JavaScript or TypeScript utility layer. The current Paper Library controls remain static placeholders and should be connected only after a compatible app structure or backend adapter exists.

## Phase 16E Status

Phase 16E did not modify the Dataset Viewer UI because the repository does not yet have an importable JavaScript or TypeScript utility layer or a connected Dataset metadata UI data source. Dataset filtering should be implemented only after a compatible app structure or backend adapter exists.

## Phase 16F Status

Phase 16F did not modify the Model Results UI because the repository does not yet have an importable JavaScript or TypeScript utility layer or a connected ModelResult UI data source. Model-result filtering should be implemented only after a compatible app structure or backend adapter exists, and null metrics must continue to display as `not available`.
