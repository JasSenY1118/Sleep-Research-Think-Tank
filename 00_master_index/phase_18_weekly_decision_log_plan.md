# Phase 18 Weekly Decision Log Plan

## Purpose

Connect Weekly Progress to local weekly logs and decision records.

## Boundary

Phase 18 is limited to planning local WeeklyLog and Decision data integration.

Do not add:

- external calendar integration
- email integration
- automation scheduler
- AI-generated weekly summary
- semantic search
- external API
- fake progress
- fake decisions
- production database
- authentication
- unrelated module changes

## Included Entities

### WeeklyLog

Fields:

- id
- weekStart
- completed
- inProgress
- blocked
- literatureAdded
- datasetProgress
- codingProgress
- decisions
- nextActions

### Decision

Fields:

- id
- date
- decision
- reason
- relatedPhase
- relatedModule

## Current Repository Constraint

The current repository is plain static HTML/CSS. It does not include:

- a JavaScript or TypeScript app structure
- a `src/` source directory
- connected local data in the UI
- API routes
- server-side data fetching
- a package manager or build pipeline

The local SQLite schema already includes `weekly_logs` and `decisions` tables, but there is no WeeklyLog or Decision CRUD repository script yet.

Weekly Progress currently renders static placeholder content from `index.html`. It should not be connected directly to SQLite from the browser.

## Required UI States

When a safe data path exists, Weekly Progress should support:

- loading
- empty state
- error state
- weekly logs list
- decision log list
- placeholder notice when seed data is used

## Display Rules

- Do not make placeholder logs look like real completed work.
- Clearly label placeholder records.
- Show `to be confirmed` for unknown values.
- Preserve the existing academic dashboard style.
- Do not invent progress, decisions, literature records, dataset progress, or coding progress.

## Recommended Implementation

Do not connect the Weekly Progress UI until the project has a compatible local data access path.

When implementation becomes safe:

1. Add local WeeklyLog and Decision CRUD repositories if missing.
2. Follow the existing Paper, Dataset, and ModelResult repository patterns.
3. Add read-only UI connection only after a backend adapter or compatible frontend app structure exists.
4. Keep write UI deferred until explicitly approved.
5. Keep placeholder seed data clearly labelled.
6. Avoid large refactors.
7. Avoid changing unrelated modules.

## Future Subphases

- Phase 18C: WeeklyLog and Decision CRUD service, if missing.
- Phase 18D: read-only Weekly Progress data connection.
- Phase 18E: search/filter for weekly logs and decisions.
- Phase 18F: create/edit/delete UI only if safe.
- Phase 18G: verification.
- Phase 18H: GitHub sync.

## Safe Phase 18C Recommendation

Phase 18C can safely add small local CRUD repository scripts because the schema already includes `weekly_logs` and `decisions`.

Likely files:

- `db/weekly_decision_repository.sh`
- `db/weekly_decision_repository_verify.sh`
- `db/README.md`

The repository should remain local and should not connect to the website UI.

## Safe Phase 18D Recommendation

For the current static-only repository, Phase 18D should not connect Weekly Progress directly to SQLite.

If Phase 18D proceeds before the architecture changes, create a limitation note instead:

- `00_master_index/phase_18_static_limitation_note.md`

That note should explain why a backend adapter or compatible frontend app structure is required before Weekly Progress can read local WeeklyLog and Decision records.
