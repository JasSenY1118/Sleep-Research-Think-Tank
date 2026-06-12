# Phase 18 Checklist

## Weekly Decision Planning Readiness

- [x] Weekly Progress page located
- [x] WeeklyLog entity exists
- [x] Decision entity exists
- [x] Local database schema exists
- [x] `weekly_logs` table exists
- [x] `decisions` table exists
- [x] Weekly/Decision connection strategy selected
- [x] Read-only UI connection planned
- [x] Write UI deferred until approved
- [x] No external automation added
- [x] No fake progress added
- [x] No fake decisions added
- [x] No AI summarisation added
- [x] WeeklyLog and Decision CRUD repository created if approved
- [x] Static limitation note created if UI connection proceeds in the current static-only repo
- [x] Weekly/Decision search and filters deferred in the current static-only repo
- [x] Weekly/Decision write UI deferred in the current static-only repo
- [ ] GitHub sync pending

## Current Module Status

Weekly Progress:

- Static placeholder content exists in `index.html`.
- The UI is not connected to local WeeklyLog records.
- The UI is not connected to local Decision records.
- Placeholder/example decision rows are visible.
- Weekly Progress local data connection remains deferred until a backend adapter or compatible frontend app structure exists.
- Weekly Progress search and filters remain deferred until local WeeklyLog and Decision records can be loaded safely.
- Weekly Progress create/edit/delete UI remains deferred until a backend adapter or compatible frontend app structure exists.

WeeklyLog:

- Entity is documented in `00_master_index/data_entities.md`.
- Table exists in `db/schema.sql`.
- Placeholder seed data exists in `db/seed_placeholder.sql`.
- CRUD repository exists in `db/weekly_decision_repository.sh`.

Decision:

- Entity is documented in `00_master_index/data_entities.md`.
- Table exists in `db/schema.sql`.
- Placeholder seed data exists in `db/seed_placeholder.sql`.
- CRUD repository exists in `db/weekly_decision_repository.sh`.

## Current Strategy

The current repository is plain static HTML/CSS. It does not support shared JavaScript or TypeScript utilities, API routes, server-side data fetching, or browser access to SQLite.

The safest Phase 18 strategy is:

1. Plan WeeklyLog and Decision integration first.
2. Add local CRUD scripts only if approved.
3. Do not connect static HTML directly to SQLite.
4. Do not connect Weekly Progress to fake browser data.
5. Add a backend adapter or frontend app structure before a read-only UI connection.
6. Keep write UI deferred until explicitly approved.

## Behaviour To Preserve Later

- Placeholder logs and decisions must stay clearly labelled.
- Unknown values should remain `to be confirmed`.
- Weekly Progress should show clear loading, empty, and error states.
- Search/filter should not mutate records.
- Write UI should validate required WeeklyLog and Decision fields.
- No fake progress or fake decisions should be added.

## Deferred Work

Do not add these items in Phase 18B:

- WeeklyLog CRUD implementation
- Decision CRUD implementation
- Weekly Progress UI connection
- create/edit/delete UI
- external calendar integration
- email integration
- automation scheduler
- AI-generated weekly summary
- semantic search
- external API
- fake progress
- fake decisions
- authentication
- database schema changes
- unrelated module changes

## Phase 18C Status

Phase 18C added local WeeklyLog and Decision CRUD repository scripts using the existing SQLite CLI pattern. These scripts remain local only and are not connected to the website UI.

## Phase 18D Status

Phase 18D did not modify the Weekly Progress UI because the repository does not yet have a backend adapter, API routes, frontend app structure, or safe browser access to local SQLite. A read-only UI connection should be implemented only after a compatible data-loading path exists.

## Phase 18E Status

Phase 18E did not modify Weekly Progress search or filters because no read-only WeeklyLog/Decision UI data connection exists yet. Search and filters should be implemented only after local records can be loaded safely, and they must not mutate database records or operate on fake browser-side data.

## Phase 18F Status

Phase 18F did not add WeeklyLog or Decision create/edit/delete UI because static HTML cannot safely call the local SQLite repository scripts. Write UI should be implemented only after a backend adapter or compatible frontend app structure exists, with validation for required WeeklyLog and Decision fields.
