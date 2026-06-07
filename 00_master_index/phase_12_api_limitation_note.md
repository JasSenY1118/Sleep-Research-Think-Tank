# Phase 12 Dataset API Limitation Note

## Purpose

Phase 12D requested Dataset CRUD API routes only if the current framework supports local API routes cleanly.

This repository is currently a plain static HTML/CSS website. It does not include a backend runtime, `package.json`, Next.js, Vite server configuration, route handlers, or an API framework.

Because the framework does not support local API routes cleanly, Phase 12D should not force Dataset API route files into the project.

## Current Dataset CRUD Boundary

Dataset metadata CRUD currently exists as a local repository/service layer:

- Schema: `db/schema.sql`
- Dataset CRUD repository: `db/dataset_repository.sh`
- Local verification: `db/dataset_repository_verify.sh`

This layer is safe for local SQLite verification. It is not connected to the Dataset Viewer UI and does not expose web routes.

## Future Backend Option

When the project is ready for Dataset API routes, add a backend framework deliberately. Suitable future options include:

- a small Node/Express service
- a Python/FastAPI service
- a Next.js app with API route handlers

The backend should keep SQLite access server-side and expose only validated Dataset metadata operations.

## Future Dataset API Routes

When backend support exists, expose:

- `GET /api/datasets`
- `GET /api/datasets/:id`
- `POST /api/datasets`
- `PATCH /api/datasets/:id`
- `DELETE /api/datasets/:id`

## Future API Behaviour

Dataset API routes should:

- return all dataset metadata records from the local database
- return one dataset metadata record by id
- return a clear not-found response when a record is missing
- require `name` when creating records
- validate controlled `status` values
- update only allowed fields
- avoid real EDF upload, Sleep-EDF preprocessing, external APIs, and model training

## Current Phase 12D Outcome

No Dataset API routes were added.

No changes were made to:

- `index.html`
- `styles.css`
- `db/schema.sql`
- `db/dataset_repository.sh`
- `db/dataset_repository_verify.sh`

## Guardrails Preserved

Phase 12D did not add:

- Dataset Viewer UI connection
- real EDF files
- EDF parsing
- hypnogram parsing
- Sleep-EDF preprocessing
- dataset upload
- external API
- model training
- authentication
- new dependencies
