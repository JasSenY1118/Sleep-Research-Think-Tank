# Backend Schema Plan

## Purpose Of The Backend

The future backend should store structured research data for the Sleep Research Think Tank. Its first job is to make paper summaries, research domains, dataset metadata, model-result records, weekly logs, and decisions consistent across the static website modules.

The backend should not be implemented in Phase 8. This phase is schema planning only.

## Modules That Will Use Backend Data

- Dashboard: summary counts, current status, and latest progress.
- Research Map: research domains, key concepts, related methods, and related datasets.
- Paper Library: paper metadata, summary fields, tags, status, and relevance scores.
- Dataset Viewer: dataset metadata, signal types, annotation structure, and processing status.
- Model Results: model result records, metrics, split type, and evaluation notes.
- Weekly Progress: weekly logs, blockers, next actions, and decisions.

## Recommended First Backend Stack

Recommended first backend direction:

- Local SQLite database for the first prototype.
- Simple schema-first data layer.
- CRUD should begin with Paper records only.
- No authentication at first.
- No vector database at first.

## Why SQLite Is Suitable For Local Prototype

SQLite is appropriate for the first backend prototype because:

- It is simple to run locally.
- It does not require a separate database server.
- It is enough for early structured data validation.
- It supports fast iteration on tables, fields, and CRUD workflows.
- It keeps the backend small while the data model is still changing.

## Future Upgrade Path To PostgreSQL

PostgreSQL should be considered after the schema stabilises and the project needs:

- Multi-user access.
- Production deployment.
- More robust query and indexing support.
- Larger data volume.
- More formal migration workflows.

The SQLite schema should be designed so it can migrate cleanly to PostgreSQL later.

## Why No Vector Database Yet

A vector database should not be added yet because the project does not have stable structured data, real paper summaries, or a reviewed search workflow.

Semantic search should wait until:

- Paper records are real and source-backed.
- Core metadata fields are stable.
- The Paper Library CRUD flow works.
- The team understands what users need to search.

## Why No Authentication Yet

Authentication should not be added in the first backend prototype because:

- The current site is a local static prototype.
- User roles and permissions are not defined.
- Authentication would add complexity before the data model is stable.
- Early phases should focus on schema correctness and local CRUD.

## What Remains Static For Now

The following remain static until later phases:

- Website layout and visual modules.
- Placeholder paper cards.
- Dataset Viewer content.
- Model Results content.
- Weekly Progress content.
- Research Map taxonomy.
- Dashboard summaries.

## Later Phase Implementation Plan

- Phase 9: local SQLite prototype.
- Phase 10: paper database CRUD.
- Phase 11: dataset metadata storage.
- Phase 12: model-results storage.
- Phase 13: semantic search or vector database, only after stable structured data exists.

## Risks To Avoid

- Adding backend code before schema review.
- Connecting a database before entity fields are stable.
- Adding fake scientific papers, metrics, or dataset statistics.
- Adding semantic search before structured data exists.
- Adding authentication before user roles are known.
- Letting API routes diverge from documented data entities.
- Mixing placeholder content with verified research records.
