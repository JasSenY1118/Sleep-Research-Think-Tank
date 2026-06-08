# Phase 15 Checklist

## Model Results Connection Readiness

- [x] Phase 13 ModelResult CRUD exists
- [x] Model Results page located
- [x] ModelResult connection strategy selected
- [x] Read-only UI connection planned
- [x] Search/filter connection planned
- [x] Create/edit/delete UI deferred until approved
- [x] No model training added
- [x] No Sleep-EDF preprocessing added
- [x] No fake model performance added
- [x] No external ML API added
- [x] Static limitation note created for the current static-only repo
- [x] Model Results search/filter connection deferred until a backend adapter exists
- [ ] GitHub sync pending

## Current Strategy

The current repository is plain static HTML/CSS. It does not support API routes, server-side data fetching, or browser access to SQLite.

The safest Phase 15 strategy is:

1. Keep the Model Results page static until a backend adapter exists.
2. Do not import SQLite or shell scripts into browser code.
3. Document the data-flow boundary before attempting UI connection.
4. Add API routes or a backend adapter in a future phase before rendering live model-result metadata.
5. Preserve placeholder labelling until real model-result metadata is approved.
6. Keep all metric fields null or `not available` unless they come from an explicit local record.

## Planned UI States

Future connected Model Results states should include:

- loading
- empty state
- error state
- list/table of model-result records
- placeholder notice when seed metadata is used

## Planned Search And Filter Scope

Future search and filters should operate only on loaded local model-result metadata.

Planned filters:

- text search
- status filter
- dataset filter
- input-signal filter
- split-type filter

Filtering must not mutate the database.

Null metric values must remain displayed as `not available` or `pending`.

In the current static-only repository, search and filters remain deferred. They should not be connected to fake browser data or direct SQLite access.

## Deferred Work

Do not add these items in Phase 15B, Phase 15C, or Phase 15D:

- Model Results UI connection
- create/edit/delete UI
- fake accuracy values
- fake macro-F1 values
- fake balanced-accuracy values
- model training
- Sleep-EDF preprocessing
- real experiment import
- automatic metric calculation
- TensorBoard/W&B integration
- external ML API
- authentication
