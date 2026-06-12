#!/usr/bin/env bash
set -euo pipefail

# Local verification for Phase 18C WeeklyLog and Decision CRUD.
# Uses a temporary database and placeholder-only weekly/decision data.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPOSITORY="$SCRIPT_DIR/weekly_decision_repository.sh"
TMP_DB="$(mktemp "${TMPDIR:-/tmp}/sleep-think-tank-weekly-decision-crud.XXXXXX.sqlite")"

cleanup() {
  rm -f "$TMP_DB"
}
trap cleanup EXIT

bash "$REPOSITORY" createWeeklyLog \
  "$TMP_DB" \
  "placeholder-weekly-crud-test" \
  "to be confirmed" \
  '["Placeholder completed item for CRUD verification only"]' \
  '["Placeholder in-progress item for CRUD verification only"]' \
  '["Placeholder blocker for CRUD verification only"]' \
  '[]' \
  "Placeholder only. Dataset progress is not real." \
  "Placeholder only. Coding progress is not real." \
  '["placeholder-decision-crud-test"]' \
  '["Placeholder next action for CRUD verification only"]'

weekly_created_count="$(sqlite3 "$TMP_DB" "SELECT count(*) FROM weekly_logs WHERE id = 'placeholder-weekly-crud-test';")"
[[ "$weekly_created_count" == "1" ]] || {
  echo "createWeeklyLog verification failed" >&2
  exit 1
}

bash "$REPOSITORY" listWeeklyLogs "$TMP_DB" >/dev/null
bash "$REPOSITORY" getWeeklyLogById "$TMP_DB" "placeholder-weekly-crud-test" >/dev/null

bash "$REPOSITORY" updateWeeklyLog "$TMP_DB" "placeholder-weekly-crud-test" datasetProgress "Placeholder update only. Dataset progress remains not real."
updated_dataset_progress="$(sqlite3 "$TMP_DB" "SELECT dataset_progress FROM weekly_logs WHERE id = 'placeholder-weekly-crud-test';")"
[[ "$updated_dataset_progress" == "Placeholder update only. Dataset progress remains not real." ]] || {
  echo "updateWeeklyLog verification failed" >&2
  exit 1
}

bash "$REPOSITORY" createDecision \
  "$TMP_DB" \
  "placeholder-decision-crud-test" \
  "to be confirmed" \
  "Placeholder decision for CRUD verification only" \
  "Placeholder reason for local CRUD verification only." \
  "Phase 18C" \
  "Weekly Progress"

decision_created_count="$(sqlite3 "$TMP_DB" "SELECT count(*) FROM decisions WHERE id = 'placeholder-decision-crud-test';")"
[[ "$decision_created_count" == "1" ]] || {
  echo "createDecision verification failed" >&2
  exit 1
}

bash "$REPOSITORY" listDecisions "$TMP_DB" >/dev/null
bash "$REPOSITORY" getDecisionById "$TMP_DB" "placeholder-decision-crud-test" >/dev/null

bash "$REPOSITORY" updateDecision "$TMP_DB" "placeholder-decision-crud-test" relatedModule "Decision Log"
updated_related_module="$(sqlite3 "$TMP_DB" "SELECT related_module FROM decisions WHERE id = 'placeholder-decision-crud-test';")"
[[ "$updated_related_module" == "Decision Log" ]] || {
  echo "updateDecision verification failed" >&2
  exit 1
}

bash "$REPOSITORY" deleteDecision "$TMP_DB" "placeholder-decision-crud-test"
decision_deleted_count="$(sqlite3 "$TMP_DB" "SELECT count(*) FROM decisions WHERE id = 'placeholder-decision-crud-test';")"
[[ "$decision_deleted_count" == "0" ]] || {
  echo "deleteDecision verification failed" >&2
  exit 1
}

bash "$REPOSITORY" deleteWeeklyLog "$TMP_DB" "placeholder-weekly-crud-test"
weekly_deleted_count="$(sqlite3 "$TMP_DB" "SELECT count(*) FROM weekly_logs WHERE id = 'placeholder-weekly-crud-test';")"
[[ "$weekly_deleted_count" == "0" ]] || {
  echo "deleteWeeklyLog verification failed" >&2
  exit 1
}

echo "WeeklyLog and Decision CRUD verification passed with placeholder-only temporary data."
