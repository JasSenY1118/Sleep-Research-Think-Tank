# Data Entities

This document defines planned backend entities only. No database has been implemented.

## Paper

Fields:

- `id`
- `title`
- `authors`
- `year`
- `journal`
- `doi`
- `url`
- `researchDomain`
- `tags`
- `mainQuestion`
- `methods`
- `keyFinding`
- `limitation`
- `relevanceScore`
- `status`
- `createdAt`
- `updatedAt`

## ResearchDomain

Fields:

- `id`
- `name`
- `description`
- `parentDomain`
- `keyConcepts`
- `relatedMethods`
- `relatedDatasets`

## Dataset

Fields:

- `id`
- `name`
- `source`
- `fileFormat`
- `signalTypes`
- `annotationType`
- `epochLength`
- `task`
- `status`
- `notes`

## ModelResult

Fields:

- `id`
- `modelName`
- `datasetName`
- `inputSignals`
- `splitType`
- `accuracy`
- `macroF1`
- `balancedAccuracy`
- `status`
- `notes`
- `createdAt`

## WeeklyLog

Fields:

- `id`
- `weekStart`
- `completed`
- `inProgress`
- `blocked`
- `literatureAdded`
- `datasetProgress`
- `codingProgress`
- `decisions`
- `nextActions`

## Decision

Fields:

- `id`
- `date`
- `decision`
- `reason`
- `relatedPhase`
- `relatedModule`

## Consistency Notes

- These entities should guide future database tables, API routes, and frontend types.
- Field names should remain consistent across planning documents and future code.
- Placeholder website content should not be treated as real entity data.
- Real records should include source-backed information only.
