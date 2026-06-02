# Sleep Research Think Tank

Sleep Research Think Tank is planned as a clean academic website for organizing current sleep research, datasets, model outputs, and weekly project progress.

## Planned Modules

- Dashboard
- Research Map
- Paper Library
- Dataset Viewer
- Model Results
- Weekly Progress

## Current Status

Current phase:

Phase 8 — Backend and Data Schema Planning

Current status:

The static website prototype is complete. Backend schema planning is in progress. No live database, API route, authentication, PDF upload, Sleep-EDF preprocessing, or model-training functionality has been implemented yet.

Current files include:

- `index.html`
- `styles.css`
- `AGENTS.md`
- `00_master_index/roadmap.md`
- `00_master_index/task_tracker.md`
- `00_master_index/decision_log.md`
- `00_master_index/weekly_log.md`
- `00_master_index/backend_schema_plan.md`
- `00_master_index/data_entities.md`
- `00_master_index/api_route_plan.md`
- `00_master_index/schema_types_note.md`
- `00_master_index/phase_8_checklist.md`

## Design Direction

The website should feel minimal, academic, and professional.

Preferred palette:

- Deep teal
- Muted navy
- Warm off-white
- Soft grey

## Research Integrity

- Placeholder content must be clearly labelled.
- Real papers, datasets, results, statistics, and model claims must not be invented.
- Scientific claims should be added only when backed by traceable sources.

## How To Run

Open `index.html` directly in a browser, or serve the folder locally:

```bash
node -e "const http=require('http'),fs=require('fs'),path=require('path');const root=process.cwd();const types={'.html':'text/html','.css':'text/css'};http.createServer((req,res)=>{const u=new URL(req.url,'http://127.0.0.1');let p=path.join(root,u.pathname==='/'?'index.html':u.pathname);if(!p.startsWith(root)){res.writeHead(403);res.end();return;}fs.readFile(p,(e,d)=>{if(e){res.writeHead(404);res.end('not found');return;}res.writeHead(200,{'content-type':types[path.extname(p)]||'text/plain'});res.end(d);});}).listen(48173,'127.0.0.1',()=>console.log('Serving http://127.0.0.1:48173/'));"
```

Then open `http://127.0.0.1:48173/`.

No build step, backend, package install, or development server is required for Phase 8 planning.

## Known Limitations

- Static Dashboard, Research Map, Paper Library, Dataset Viewer, Model Results, and Weekly Progress modules only.
- Paper search and filters are visible placeholders only.
- No DOI links, PubMed links, PDF upload, or citation export.
- No EDF loading or preprocessing code.
- No model training code or model performance values.
- No backend, external API, or database.
- No real papers, datasets, model results, statistics, or scientific claims.
