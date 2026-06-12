# Phase 18F Write UI Limitation Note

## Purpose

Phase 18F requested create, edit, and delete UI for WeeklyLog and Decision records if safe.

## Current Repository Constraint

Write UI is not safe to implement yet because the project is currently a plain static HTML/CSS website with no:

- backend adapter
- API routes
- frontend app structure
- server-side validation layer
- authentication model
- safe browser access to the local SQLite database

The local CRUD scripts added in Phase 18C are shell-based repository utilities. They are not callable safely from static browser HTML.

## Phase 18F Decision

WeeklyLog and Decision write UI is deferred.

No add, edit, delete, confirmation, validation, success, or error UI was added in Phase 18F.

## What Exists Now

The repository includes local-only CRUD support for:

- `createWeeklyLog`
- `listWeeklyLogs`
- `getWeeklyLogById`
- `updateWeeklyLog`
- `deleteWeeklyLog`
- `createDecision`
- `listDecisions`
- `getDecisionById`
- `updateDecision`
- `deleteDecision`

These commands are available in:

- `db/weekly_decision_repository.sh`

They are verified by:

- `db/weekly_decision_repository_verify.sh`

## Future Backend/API Support Needed

Before write UI can be added, the project needs:

- a backend adapter or compatible frontend app framework
- safe API routes for WeeklyLog and Decision records
- validation for required fields
- clear error handling
- a safe persistence boundary
- a decision on whether authentication is required before editing project logs

## Future Write UI Scope

When implementation becomes safe, WeeklyLog UI can include:

- Add Weekly Log button
- minimal Add Weekly Log form
- Edit Weekly Log action
- Delete Weekly Log action with confirmation
- validation error display
- success/error feedback

Decision UI can include:

- Add Decision button
- minimal Add Decision form
- Edit Decision action
- Delete Decision action with confirmation
- validation error display
- success/error feedback

## Validation Rules To Preserve Later

WeeklyLog:

- `weekStart` is required.
- Array-like fields may be comma-separated in UI if the database expects serialised arrays.
- Empty fields should remain empty or `to be confirmed`, not invented.

Decision:

- `date` is required.
- `decision` is required.
- `reason` is required.
- `relatedPhase` and `relatedModule` can be optional.
- Empty fields should remain empty or `to be confirmed`, not invented.

## Guardrails Preserved

Phase 18F did not add:

- write UI
- create forms
- edit forms
- delete buttons
- browser-to-SQLite access
- API routes
- fake progress
- fake decisions
- external APIs
- calendar or email automation
- AI summarisation
- semantic search
- authentication
- unrelated module changes

## Suggested Checkpoint

Phase 18F — Weekly Decision Write UI Deferred
