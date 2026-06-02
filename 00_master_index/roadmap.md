# Roadmap

## Project Name

Sleep Research Think Tank

## Final Product

A clean academic website for current sleep research with these modules:

- Dashboard
- Research Map
- Paper Library
- Dataset
- Models
- Weekly

## Phase 0: Stable Skeleton

Status: Complete

Goals:

- Establish project rules.
- Create master planning documents.
- Define scope and design direction.
- Create a stable static website skeleton.
- Add required navigation for Dashboard, Research Map, Paper Library, Dataset, Models, and Weekly.

Deliverables:

- `index.html`
- `styles.css`
- `AGENTS.md`
- `README.md`
- `00_master_index/roadmap.md`
- `00_master_index/task_tracker.md`
- `00_master_index/decision_log.md`
- `00_master_index/weekly_log.md`

## Phase 1: Dashboard

Status: Complete

Goals:

- Turn the Dashboard placeholder into a useful project overview.
- Add Project Overview, Build Pipeline, Research Focus, and Current Status sections.
- Keep all content clearly labelled when placeholder.
- Avoid adding backend, search, EDF loading, model training, or advanced animations.
- Confirm the static site still opens cleanly in the browser.

Deliverables:

- Dashboard overview with mission and build phase.
- Six build pipeline cards.
- Seven research focus cards.
- Placeholder current-status tracker.

## Phase 2: Research Map

Status: Complete

Goals:

- Build only the Research Map module.
- Add a structured taxonomy of current sleep research domains, methods, datasets, and translational directions.
- Keep Paper Library, Dataset, Models, and Weekly as future anchors only.
- Avoid backend, database, external API, citations, fake paper titles, or fake claims.

Deliverables:

- Research Map overview.
- Six research domain cards.
- Concept tags for each domain.
- Planning section for paper tagging, dataset organisation, model development, and grant or PhD idea generation.

## Phase 3: Paper Library Static Prototype

Status: Complete

Goals:

- Build only the Paper Library module.
- Add static search and filter UI placeholders.
- Add clearly labelled placeholder/example paper cards.
- Define the future paper summary schema.
- Avoid backend, database, external API, PDF upload, DOI links, PubMed links, fake citations, or fake claims.

Deliverables:

- Library Overview.
- Filter Bar.
- Example Paper Cards.
- Paper Summary Schema.
- Future Integration Notes.

## Phase 4: Dataset Viewer Static Prototype

Status: Complete

Goals:

- Build only the Dataset Viewer module.
- Document the Sleep-EDF Expanded dataset planning structure.
- Show signal, annotation, preprocessing, label mapping, visualisation, model-ready format, and status placeholders.
- Avoid EDF loading, preprocessing code, backend, database, external API, fake dataset statistics, or fake model results.

Deliverables:

- Dataset Overview.
- Signal and Annotation Structure.
- Preprocessing Pipeline.
- Label Mapping.
- Future Visualisation Placeholders.
- Model-Ready Data Format.
- Dataset Status Panel.

## Phase 5: Model Results Static Prototype

Status: Complete

Goals:

- Build only the Model Results module.
- Prepare the site for future sleep-stage classification model tracking.
- Add model overview, baseline plan, roadmap, placeholder results table, evaluation metrics, error analysis placeholders, visualisation placeholders, and status panel.
- Avoid training code, Python execution, backend, database, external API, fake model performance, or fake scientific claims.

Deliverables:

- Model Overview.
- Baseline Model Plan.
- Future Model Roadmap.
- Results Placeholder Table.
- Evaluation Metrics.
- Error Analysis Placeholder.
- Future Visualisation Placeholders.
- Model Status Panel.

## Phase 6: Weekly Progress Page

Status: Complete

Goals:

- Build only the Weekly Progress module.
- Connect progress content to documented weekly logs.
- Keep planning notes distinct from verified research content.
- Track literature, dataset work, coding progress, decisions, blockers, next week, and checkpoints.
- Avoid backend, database, external API, fake scientific results, fake real papers, model training code, or dataset processing code.

Deliverables:

- This Week.
- Literature Added.
- Dataset Progress.
- Coding Progress.
- Decisions Made.
- Blockers.
- Next Week.
- Checkpoint Panel.

## Phase 7: Full Static Website Review And Cleanup

Status: Reviewed

Goals:

- Verify minimal academic design.
- Remove unnecessary duplication.
- Check navigation and responsive layout.
- Confirm app still runs.

Deliverables:

- Phase 7A static website review.
- Approved cleanup of duplicated layout styles.
- Navigation and responsive layout verification.
- Documentation alignment with the current static website.

## Phase 8: Backend/Data Schema Planning

Status: In progress

Goals:

- Plan the backend and data schema before implementation.
- Define reusable entities for papers, research domains, datasets, model results, weekly logs, and decisions.
- Plan API routes without creating live backend routes.
- Document why TypeScript types are not applicable while the project remains static HTML/CSS.

Deliverables:

- `00_master_index/backend_schema_plan.md`
- `00_master_index/data_entities.md`
- `00_master_index/api_route_plan.md`
- `00_master_index/schema_types_note.md`
- `00_master_index/phase_8_checklist.md`

## Phase 9: Local SQLite Database Prototype

Status: Planned

Goals:

- Create a local SQLite prototype after schema planning is stable.
- Keep database work local and minimal.
- Avoid external services until the local data model is proven.

## Phase 10: Paper Database CRUD Prototype

Status: Planned

Goals:

- Implement create, read, update, and delete flows for paper records.
- Keep records structured and consistent with the planned Paper entity.
- Avoid fake real citations or unsupported scientific claims.

## Phase 11: Connect Paper Library To Local Data

Status: Planned

Goals:

- Connect the Paper Library interface to local paper data.
- Preserve clearly labelled placeholder content until real records are added.
- Keep filters and tags aligned with Research Map domains.

## Phase 12: Dataset Metadata Storage

Status: Planned

Goals:

- Store dataset metadata for Sleep-EDF planning and future datasets.
- Track formats, signal types, annotations, task, status, and notes.
- Avoid EDF loading or preprocessing until a later dedicated phase.

## Phase 13: Model-Result Storage

Status: Planned

Goals:

- Store model-result metadata and metrics only when real results exist.
- Keep unavailable metrics explicitly marked as unavailable.
- Avoid fake model performance values.

## Phase 14: Semantic Search

Status: Planned

Goals:

- Add semantic search only after stable structured data exists.
- Revisit vector search when paper records and tags are mature.
- Avoid adding vector databases prematurely.
