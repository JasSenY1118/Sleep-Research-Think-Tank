#!/usr/bin/env bash
set -euo pipefail

# Local verification for Phase 13C Model Result metadata CRUD.
# Uses a temporary database and placeholder-only model-result metadata.
# Performance metrics remain null; no fake model values are inserted.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPOSITORY="$SCRIPT_DIR/model_result_repository.sh"
TMP_DB="$(mktemp "${TMPDIR:-/tmp}/sleep-think-tank-model-result-crud.XXXXXX.sqlite")"

cleanup() {
  rm -f "$TMP_DB"
}
trap cleanup EXIT

bash "$REPOSITORY" create \
  "$TMP_DB" \
  "placeholder-model-result-crud-test" \
  "Placeholder model metadata for CRUD verification only" \
  "Placeholder dataset metadata for CRUD verification only" \
  '["EEG"]' \
  "subject-wise" \
  "null" \
  "null" \
  "null" \
  "planned" \
  "Placeholder only. No model training or real performance metrics are included."

created_count="$(sqlite3 "$TMP_DB" "SELECT count(*) FROM model_results WHERE id = 'placeholder-model-result-crud-test';")"
[[ "$created_count" == "1" ]] || {
  echo "createModelResult verification failed" >&2
  exit 1
}

metric_count="$(sqlite3 "$TMP_DB" "SELECT count(*) FROM model_results WHERE id = 'placeholder-model-result-crud-test' AND accuracy IS NULL AND macro_f1 IS NULL AND balanced_accuracy IS NULL;")"
[[ "$metric_count" == "1" ]] || {
  echo "null metric verification failed" >&2
  exit 1
}

bash "$REPOSITORY" list "$TMP_DB" >/dev/null
bash "$REPOSITORY" get "$TMP_DB" "placeholder-model-result-crud-test" >/dev/null

bash "$REPOSITORY" update "$TMP_DB" "placeholder-model-result-crud-test" status "training-pending"
updated_status="$(sqlite3 "$TMP_DB" "SELECT status FROM model_results WHERE id = 'placeholder-model-result-crud-test';")"
[[ "$updated_status" == "training-pending" ]] || {
  echo "updateModelResult verification failed" >&2
  exit 1
}

bash "$REPOSITORY" delete "$TMP_DB" "placeholder-model-result-crud-test"
deleted_count="$(sqlite3 "$TMP_DB" "SELECT count(*) FROM model_results WHERE id = 'placeholder-model-result-crud-test';")"
[[ "$deleted_count" == "0" ]] || {
  echo "deleteModelResult verification failed" >&2
  exit 1
}

echo "Model Result metadata CRUD verification passed with placeholder-only temporary data and null metrics."
