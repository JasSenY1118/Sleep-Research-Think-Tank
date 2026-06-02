# Decision Log

Record project decisions here as they are made. Keep entries concise and include the reason for each decision.

## Decisions

| Date | Decision | Reason | Status |
| --- | --- | --- | --- |
| 2026-06-01 | Establish project governance files before app scaffolding. | The project needs clear working rules, scope, and tracking before implementation begins. | Accepted |
| 2026-06-01 | Use a minimal academic design direction with deep teal, muted navy, warm off-white, and soft grey. | The final product should feel professional, restrained, and research-oriented. | Accepted |
| 2026-06-01 | Do not invent scientific papers, results, datasets, statistics, or model claims. | Research integrity requires placeholder content to remain clearly labelled until verified sources are added. | Accepted |
| 2026-06-01 | Use a static HTML/CSS skeleton for Phase 0. | The current goal is a stable website skeleton without backend, dependencies, paper search, EDF loading, or model training code. | Accepted |
| 2026-06-01 | Build Phase 1 as Dashboard-only static content. | The requested scope is Dashboard only, with other modules left as future anchors for navigation. | Accepted |
| 2026-06-01 | Build Phase 2 as Research Map-only static content. | The requested scope is the Research Map module, with other modules left unchanged except shared navigation anchors. | Accepted |
| 2026-06-01 | Build Phase 3 as a static Paper Library prototype. | The requested scope is a placeholder literature interface without backend, database, external APIs, DOI/PubMed links, PDF upload, or fake citations. | Accepted |
| 2026-06-01 | Build Phase 4 as a static Dataset Viewer prototype. | The requested scope is dataset documentation only, without EDF loading, preprocessing code, backend, database, external APIs, fake dataset statistics, or fake model results. | Accepted |
| 2026-06-01 | Build Phase 5 as a static Model Results prototype. | The requested scope is model-result planning only, without training code, Python execution, backend, database, external APIs, fake performance values, or fake scientific claims. | Accepted |
| 2026-06-01 | Build Phase 6 as a static Weekly Progress page. | The requested scope is project-control tracking only, without backend, database, external APIs, fake scientific results, fake real papers, model training code, or dataset processing code. | Accepted |
| 2026-06-01 | Perform Phase 7 cleanup without adding features. | Cleanup is limited to spacing, naming, duplicated styles, documentation alignment, and responsive/navigation verification. | Accepted |
| 2026-06-02 | Use schema-first backend planning before implementing SQLite or API routes. | This prevents messy backend code and keeps data entities consistent across Paper Library, Dataset Viewer, Model Results, and Weekly Progress. | Accepted |

## Open Decisions

| Decision Needed | Options | Notes |
| --- | --- | --- |
| App framework | Static HTML/CSS, Vite, Next.js, other | Static HTML/CSS is sufficient for Phase 0; revisit only if later phases require it. |
| Data storage format | SQLite prototype, PostgreSQL later | Phase 8 planning recommends local SQLite first, with PostgreSQL as a later upgrade path if needed. |
| Citation format | To be determined | Decide before adding real paper records. |
