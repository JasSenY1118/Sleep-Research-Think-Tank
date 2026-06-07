# Phase 12 Checklist

## Dataset Metadata CRUD Readiness

- [x] Phase 9 database exists
- [x] Dataset entity exists
- [x] `datasets` table exists
- [x] Dataset CRUD plan created
- [x] Dataset repository/service planned
- [x] No real EDF files connected
- [x] No Sleep-EDF preprocessing added
- [x] No dataset upload added
- [x] No model training added
- [x] Dataset CRUD service implemented
- [x] Dataset CRUD verified locally
- [x] Dataset API route limitation documented if static-only
- [ ] GitHub sync pending

## Current Strategy

The current repository is plain static HTML/CSS. It does not support API routes, server-side data fetching, or browser access to SQLite.

The safest Phase 12 strategy is:

1. Use the existing Phase 9 SQLite schema.
2. Follow the Phase 10 Paper CRUD shell repository pattern.
3. Implement Dataset metadata CRUD locally only.
4. Keep Dataset Viewer UI disconnected until a backend adapter exists.
5. Document API route limitations while the repo remains static-only.

## Guardrails

Do not add real EDF files, Sleep-EDF preprocessing, signal parsing, hypnogram parsing, dataset upload, model training, external dataset APIs, authentication, production database setup, or Dataset Viewer UI connection in Phase 12B.

## Phase 12C Notes

Phase 12C adds a local Dataset metadata CRUD repository and verification script only. The Dataset Viewer UI remains disconnected, and no real EDF files, Sleep-EDF preprocessing, dataset upload, external API, or model training was added.

## Phase 12D Notes

Phase 12D documents why Dataset API routes are not implemented while the repository remains plain static HTML/CSS. No API routes, backend runtime, Dataset Viewer UI connection, real EDF files, Sleep-EDF preprocessing, dataset upload, external API, or model training was added.
