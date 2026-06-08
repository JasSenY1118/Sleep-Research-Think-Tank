# Phase 15 Model Results Connection Plan

## Purpose

Connect the Model Results page to the local ModelResult CRUD/database layer.

## Boundary

Phase 15 is limited to planning a Model Results connection to local model-result metadata.

Do not add:

- model training
- Sleep-EDF preprocessing
- real experiment import
- fake performance metrics
- TensorBoard/W&B integration
- external ML API
- production database
- authentication

## Current Repository Constraint

The current repository is plain static HTML/CSS. It does not provide API routes, server-side data fetching, or a browser-safe way to access SQLite.

The ModelResult CRUD layer exists as local shell scripts around SQLite. That is safe for local verification, but it should not be imported into browser code or called from static HTML.

## Recommended Data-Flow Approach

Because this repository is static-only, do not force SQLite into the browser.

Recommended approach for now:

1. Keep the Model Results page static and clearly labelled.
2. Document the backend adapter requirement before UI connection.
3. Add a future backend or full-stack framework before connecting the Model Results page to local metadata.
4. Once a backend exists, expose model-result metadata through safe local API routes.

If API routes exist in a future phase, Model Results should fetch from the local ModelResult API.

If a server-side framework supports direct data access in a future phase, use that framework's safest server-side pattern. The browser should still not read SQLite files directly.

## UI States Required For Future Connection

When Model Results is connected later, it should support:

- loading
- empty state
- error state
- list/table of model-result records
- placeholder notice when seed metadata is being used

Empty state text:

> No model results have been added yet. Add model-result records in a future CRUD phase.

Error state text:

> Model-result data could not be loaded.

## ModelResult Fields To Display

Future connected records should display:

- modelName
- datasetName
- inputSignals
- splitType
- accuracy
- macroF1
- balancedAccuracy
- status
- notes
- createdAt

## Metric Display Rule

- If `accuracy`, `macroF1`, or `balancedAccuracy` is null, display `not available` or `pending`.
- Do not display invented values.
- Only display numeric values if they come from an explicit existing local record.
- Do not calculate model metrics in the website.

## Future Subphases

- Phase 15C: read-only local ModelResult connection
- Phase 15D: search and filters connected to local model-result data
- Phase 15E: create/edit/delete UI only if safe
- Phase 15F: verification
- Phase 15G: GitHub sync

## Safe Phase 15C Recommendation

For the current static-only repository, Phase 15C should not connect the Model Results page directly to SQLite.

Instead, Phase 15C should create:

- `00_master_index/phase_15_static_limitation_note.md`

That note should explain why a backend adapter is required before a real UI connection.
