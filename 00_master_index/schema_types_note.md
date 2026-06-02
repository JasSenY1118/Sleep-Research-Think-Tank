# Schema Types Note

## Why TypeScript Types Are Not Applicable Yet

This project is currently a static HTML/CSS website. It does not include a `src` directory, `package.json`, `tsconfig.json`, or any TypeScript source files.

Because there is no TypeScript application structure yet, Phase 8C should not create `src/types/research.ts`. Adding that path now would introduce an unused project structure before the frontend or backend framework has been selected.

## Equivalent Schema File To Create Later

When the project moves into a TypeScript frontend or backend phase, create a shared type file such as:

```text
src/types/research.ts
```

That file should export reusable types or interfaces for:

- Paper
- ResearchDomain
- Dataset
- ModelResult
- WeeklyLog
- Decision

If the backend is implemented separately, the backend may also need a schema file such as:

```text
src/server/schema/research.ts
```

or, for a database-first implementation:

```text
src/server/db/schema.ts
```

The exact path should match the framework chosen in the backend prototype phase.

## Consistency With Data Entities

Future TypeScript types should stay aligned with `00_master_index/data_entities.md`.

Each future type should preserve the same core fields already planned in the data entity document:

- Paper metadata, paper summary fields, tags, relevance score, status, and timestamps.
- Research domain names, descriptions, parent domains, key concepts, methods, and related datasets.
- Dataset source, format, signal types, annotations, epoch structure, task, status, and notes.
- Model result metadata, input signals, split type, metrics, status, notes, and created date.
- Weekly log status groups, literature additions, dataset progress, coding progress, decisions, and next actions.
- Decision log date, decision, reason, related phase, and related module.

If a field changes in the future TypeScript schema, update `data_entities.md` at the same time so the documentation and implementation remain in sync.

## Phase 8C Scope

This note is documentation only.

No runtime logic, mock data, fake papers, API calls, database connections, visual changes, or new dependencies were added in this phase.
