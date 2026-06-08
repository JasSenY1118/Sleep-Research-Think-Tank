# Phase 13 Model Result API Limitation Note

## Purpose

Phase 13D requested Model Result CRUD API routes only if the current framework supports local API routes cleanly.

This repository is currently a plain static HTML/CSS website. It does not include a backend runtime, `package.json`, Next.js, Vite server configuration, route handlers, or an API framework.

Because the framework does not support local API routes cleanly, Phase 13D should not force Model Result API route files into the project.

## Current Model Result CRUD Boundary

Model Result metadata CRUD currently exists as a local repository/service layer:

- Schema: `db/schema.sql`
- Model Result CRUD repository: `db/model_result_repository.sh`
- Local verification: `db/model_result_repository_verify.sh`

This layer is safe for local SQLite verification. It is not connected to the Model Results UI and does not expose web routes.

## Future Backend Option

When the project is ready for Model Result API routes, add a backend framework deliberately. Suitable future options include:

- a small Node/Express service
- a Python/FastAPI service
- a Next.js app with API route handlers

The backend should keep SQLite access server-side and expose only validated Model Result metadata operations.

## Future Model Result API Routes

When backend support exists, expose:

- `GET /api/model-results`
- `GET /api/model-results/:id`
- `POST /api/model-results`
- `PATCH /api/model-results/:id`
- `DELETE /api/model-results/:id`

## Future API Behaviour

Model Result API routes should:

- return all model-result metadata records from the local database
- return one model-result metadata record by id
- return a clear not-found response when a record is missing
- require `modelName` when creating records
- require `datasetName` when creating records
- validate controlled `status` values
- validate metric range if metrics are provided
- update only allowed fields
- avoid fake model performance, Sleep-EDF preprocessing, model training, external ML APIs, and real experiment import

## Current Phase 13D Outcome

No Model Result API routes were added.

No changes were made to:

- `index.html`
- `styles.css`
- `db/schema.sql`
- `db/model_result_repository.sh`
- `db/model_result_repository_verify.sh`

## Guardrails Preserved

Phase 13D did not add:

- Model Results UI connection
- fake accuracy values
- fake macro-F1 values
- fake balanced-accuracy values
- Sleep-EDF preprocessing
- model training
- real experiment import
- TensorBoard/W&B integration
- external ML API
- authentication
- new dependencies
