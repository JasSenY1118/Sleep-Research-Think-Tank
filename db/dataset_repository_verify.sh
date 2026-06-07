#!/usr/bin/env bash
set -euo pipefail

# Local verification for Phase 12C Dataset metadata CRUD.
# Uses a temporary database and placeholder-only dataset metadata.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPOSITORY="$SCRIPT_DIR/dataset_repository.sh"
TMP_DB="$(mktemp "${TMPDIR:-/tmp}/sleep-think-tank-dataset-crud.XXXXXX.sqlite")"

cleanup() {
  rm -f "$TMP_DB"
}
trap cleanup EXIT

bash "$REPOSITORY" create \
  "$TMP_DB" \
  "placeholder-dataset-crud-test" \
  "Placeholder dataset metadata for CRUD verification only" \
  "null" \
  "null" \
  '["EEG"]' \
  "null" \
  "30 seconds" \
  "sleep-stage classification" \
  "metadata-only" \
  "Placeholder only. No real EDF files are connected."

created_count="$(sqlite3 "$TMP_DB" "SELECT count(*) FROM datasets WHERE id = 'placeholder-dataset-crud-test';")"
[[ "$created_count" == "1" ]] || {
  echo "createDataset verification failed" >&2
  exit 1
}

file_format="$(sqlite3 "$TMP_DB" "SELECT file_format FROM datasets WHERE id = 'placeholder-dataset-crud-test';")"
[[ "$file_format" == "to be confirmed" ]] || {
  echo "unknown fileFormat verification failed" >&2
  exit 1
}

bash "$REPOSITORY" list "$TMP_DB" >/dev/null
bash "$REPOSITORY" get "$TMP_DB" "placeholder-dataset-crud-test" >/dev/null

bash "$REPOSITORY" update "$TMP_DB" "placeholder-dataset-crud-test" status "preprocessing-planned"
updated_status="$(sqlite3 "$TMP_DB" "SELECT status FROM datasets WHERE id = 'placeholder-dataset-crud-test';")"
[[ "$updated_status" == "preprocessing-planned" ]] || {
  echo "updateDataset verification failed" >&2
  exit 1
}

bash "$REPOSITORY" delete "$TMP_DB" "placeholder-dataset-crud-test"
deleted_count="$(sqlite3 "$TMP_DB" "SELECT count(*) FROM datasets WHERE id = 'placeholder-dataset-crud-test';")"
[[ "$deleted_count" == "0" ]] || {
  echo "deleteDataset verification failed" >&2
  exit 1
}

echo "Dataset metadata CRUD verification passed with placeholder-only temporary data."
