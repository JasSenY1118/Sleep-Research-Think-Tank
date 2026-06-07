# Phase 11 Checklist

## Paper Library Connection Readiness

- [x] Phase 10 Paper CRUD exists
- [x] Paper Library page located
- [x] Data connection strategy selected
- [x] Read-only UI connection planned
- [x] Search/filter connection planned
- [x] Create/edit/delete UI deferred until approved
- [x] Static limitation documented for Phase 11C
- [x] Search/filter connection deferred until backend adapter exists
- [x] Write UI limitation documented for Phase 11E
- [x] No real papers added
- [x] No fake citations added
- [x] No PDF upload added
- [x] No external API added
- [ ] GitHub sync pending

## Current Strategy

The current repository is plain static HTML/CSS. It does not support API routes, server-side data fetching, or safe browser access to SQLite.

The safest Phase 11 strategy is therefore:

1. Keep the Paper Library static until a backend adapter exists.
2. Do not import SQLite or shell scripts into browser code.
3. Plan a future backend adapter for read-only Paper API access.
4. Defer create/edit/delete UI until the read-only flow is stable and explicitly approved.

## Deferred Items

- Paper Library read-only data connection
- Paper Library connected search and filters
- Paper create/edit/delete UI
- Backend/API adapter
- Persistent local development database
- GitHub sync for Phase 11

## Guardrails

Do not add real paper records, fake real citations, PDF upload, external metadata lookup, semantic search, authentication, dataset CRUD, model CRUD, or weekly-log CRUD in Phase 11B.
