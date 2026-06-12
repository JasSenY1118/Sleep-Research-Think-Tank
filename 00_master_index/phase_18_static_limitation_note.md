# Phase 18D Static Limitation Note

## Purpose

Phase 18D requested a read-only Weekly Progress connection to local WeeklyLog and Decision data.

## Current Repository Constraint

The current repository is a static HTML/CSS website. It does not currently include:

- a JavaScript or TypeScript frontend app structure
- a `src/` source directory
- API routes
- server-side data fetching
- a backend adapter
- a package manager or build pipeline
- safe browser access to the local SQLite database

Because of this, the Weekly Progress page cannot safely read local WeeklyLog or Decision records from SQLite.

## Current Data Status

The local database layer now includes:

- `weekly_logs` table in `db/schema.sql`
- `decisions` table in `db/schema.sql`
- `db/weekly_decision_repository.sh`
- `db/weekly_decision_repository_verify.sh`

These files provide local CRUD support only. They are not connected to the website UI and do not expose API routes.

## Phase 18D Decision

The Weekly Progress UI connection is deferred until the project has a compatible frontend app structure or backend adapter.

No Weekly Progress UI connection was added in Phase 18D.

## Phase 18E Search And Filter Decision

Phase 18E requested local search/filter behaviour for WeeklyLog and Decision records.

Because Phase 18D did not add a read-only Weekly Progress data connection, search and filters are also deferred. Search/filter behaviour should operate on loaded local WeeklyLog and Decision records only, not on static placeholder HTML or fake browser-side data.

No Weekly Progress search, filter, reset control, or filtered empty state was added in Phase 18E.

## Future Read-Only Connection Scope

When implementation becomes safe, Weekly Progress should display local WeeklyLog fields:

- week start
- completed
- in progress
- blocked
- literature added
- dataset progress
- coding progress
- decisions
- next actions

It should also display local Decision fields:

- date
- decision
- reason
- related phase
- related module

## Required Future UI States

When a safe data path exists, Weekly Progress should support:

- loading state
- empty state: `No weekly logs or decisions have been added yet.`
- error state: `Weekly progress data could not be loaded.`
- data-loaded weekly logs list
- data-loaded decision log list
- placeholder notice when seed data is used

## Future Search And Filter Scope

When implementation becomes safe, Weekly Progress search can include WeeklyLog fields:

- week start
- completed
- in progress
- blocked
- literature added
- dataset progress
- coding progress
- decisions
- next actions

It can also include Decision fields:

- date
- decision
- reason
- related phase
- related module

Future filters can include:

- related phase
- related module
- week or date
- status-like grouping for completed, in progress, and blocked items if compatible with the loaded WeeklyLog structure

Empty filtered results should show:

`No weekly logs or decisions match the current filters.`

## Required Future Conditions

Before connecting Weekly Progress to local data, the repository should have:

- a deliberate backend adapter or frontend app structure
- a safe local data-loading path for WeeklyLog and Decision records
- a way for the UI to handle loading, empty, and error states
- verification that placeholder records remain clearly labelled

## Guardrails Preserved

Phase 18D did not add:

- UI changes
- write UI
- API routes
- direct browser-to-SQLite access
- fake progress
- fake decisions
- external APIs
- calendar or email automation
- AI summarisation
- semantic search
- authentication
- unrelated module changes

Phase 18E also did not add:

- Weekly Progress search controls
- Weekly Progress filter controls
- reset or clear filter controls
- filtered result state
- semantic search
- vector database
- embeddings
- fake progress
- fake decisions

## Suggested Checkpoint

Phase 18D — Read-Only Weekly Progress Data Connection Deferred

Phase 18E — Weekly Decision Search Filters Deferred
