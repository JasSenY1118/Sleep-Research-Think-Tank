#!/usr/bin/env bash
set -euo pipefail

# Local Model Result metadata CRUD repository for Phase 13C.
# Uses the existing raw SQLite approach. No UI connection, API routes,
# fake performance values, model training, Sleep-EDF preprocessing, or external ML API.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCHEMA_FILE="$SCRIPT_DIR/schema.sql"

usage() {
  cat <<'USAGE'
Usage:
  model_result_repository.sh create <db> <id> <model_name> <dataset_name> <input_signals_json> <split_type> <accuracy|null> <macro_f1|null> <balanced_accuracy|null> <status> <notes|null>
  model_result_repository.sh list <db>
  model_result_repository.sh get <db> <id>
  model_result_repository.sh update <db> <id> <field> <value|null>
  model_result_repository.sh delete <db> <id>

Fields accepted by update:
  modelName model_name datasetName dataset_name inputSignals input_signals
  splitType split_type accuracy macroF1 macro_f1 balancedAccuracy
  balanced_accuracy status notes

Status values:
  planned, training-pending, evaluated, failed, archived

Performance metrics must be null unless they come from a real experiment.
If supplied, metric values must be numbers between 0 and 1.
USAGE
}

die() {
  printf 'Error: %s\n' "$*" >&2
  exit 1
}

require_sqlite() {
  command -v sqlite3 >/dev/null 2>&1 || die "sqlite3 is required"
}

ensure_db() {
  local db_path="$1"
  [[ -n "$db_path" ]] || die "database path is required"
  [[ -f "$SCHEMA_FILE" ]] || die "schema file not found: $SCHEMA_FILE"
  sqlite3 "$db_path" < "$SCHEMA_FILE"
}

sql_escape() {
  printf "%s" "$1" | sed "s/'/''/g"
}

sql_text() {
  printf "'%s'" "$(sql_escape "$1")"
}

sql_optional_text() {
  if [[ "$1" == "null" || "$1" == "NULL" ]]; then
    printf "NULL"
  else
    sql_text "$1"
  fi
}

input_signals_value() {
  if [[ "$1" == "" || "$1" == "null" || "$1" == "NULL" ]]; then
    printf "[]"
  else
    printf "%s" "$1"
  fi
}

sql_optional_metric() {
  if [[ "$1" == "" || "$1" == "null" || "$1" == "NULL" ]]; then
    printf "NULL"
  elif [[ "$1" =~ ^(0|1)([.][0-9]+)?$ || "$1" =~ ^0[.][0-9]+$ ]]; then
    awk -v value="$1" 'BEGIN { if (value >= 0 && value <= 1) print value; else exit 1 }' || die "metrics must be between 0 and 1"
  else
    die "metrics must be numeric values between 0 and 1 or null"
  fi
}

validate_status() {
  case "$1" in
    planned|training-pending|evaluated|failed|archived) ;;
    *) die "status must be one of: planned, training-pending, evaluated, failed, archived" ;;
  esac
}

column_for_field() {
  case "$1" in
    modelName|model_name) printf "model_name" ;;
    datasetName|dataset_name) printf "dataset_name" ;;
    inputSignals|input_signals) printf "input_signals" ;;
    splitType|split_type) printf "split_type" ;;
    accuracy) printf "accuracy" ;;
    macroF1|macro_f1) printf "macro_f1" ;;
    balancedAccuracy|balanced_accuracy) printf "balanced_accuracy" ;;
    status) printf "status" ;;
    notes) printf "notes" ;;
    *) die "unsupported update field: $1" ;;
  esac
}

sql_value_for_field() {
  local field="$1"
  local value="$2"

  case "$field" in
    modelName|model_name)
      [[ -n "$value" && "$value" != "null" && "$value" != "NULL" ]] || die "modelName is required"
      sql_text "$value"
      ;;
    datasetName|dataset_name)
      [[ -n "$value" && "$value" != "null" && "$value" != "NULL" ]] || die "datasetName is required"
      sql_text "$value"
      ;;
    inputSignals|input_signals)
      sql_text "$(input_signals_value "$value")"
      ;;
    splitType|split_type)
      [[ -n "$value" && "$value" != "null" && "$value" != "NULL" ]] || die "splitType is required"
      sql_text "$value"
      ;;
    accuracy|macroF1|macro_f1|balancedAccuracy|balanced_accuracy)
      sql_optional_metric "$value"
      ;;
    status)
      validate_status "$value"
      sql_text "$value"
      ;;
    notes)
      sql_optional_text "$value"
      ;;
    *) die "unsupported update field: $field" ;;
  esac
}

now_utc() {
  date -u +"%Y-%m-%dT%H:%M:%SZ"
}

createModelResult() {
  [[ $# -eq 11 ]] || die "createModelResult requires 11 arguments after the command"

  local db_path="$1"
  local id="$2"
  local model_name="$3"
  local dataset_name="$4"
  local input_signals="$5"
  local split_type="$6"
  local accuracy="$7"
  local macro_f1="$8"
  local balanced_accuracy="$9"
  local status="${10}"
  local notes="${11}"
  local created_at
  created_at="$(now_utc)"

  [[ -n "$id" ]] || die "id is required"
  [[ -n "$model_name" ]] || die "modelName is required"
  [[ -n "$dataset_name" ]] || die "datasetName is required"
  [[ -n "$split_type" ]] || die "splitType is required"
  validate_status "$status"
  ensure_db "$db_path"

  sqlite3 "$db_path" <<SQL
INSERT INTO model_results (
  id, model_name, dataset_name, input_signals, split_type,
  accuracy, macro_f1, balanced_accuracy, status, notes, created_at
) VALUES (
  $(sql_text "$id"),
  $(sql_text "$model_name"),
  $(sql_text "$dataset_name"),
  $(sql_text "$(input_signals_value "$input_signals")"),
  $(sql_text "$split_type"),
  $(sql_optional_metric "$accuracy"),
  $(sql_optional_metric "$macro_f1"),
  $(sql_optional_metric "$balanced_accuracy"),
  $(sql_text "$status"),
  $(sql_optional_text "$notes"),
  $(sql_text "$created_at")
);
SQL
}

listModelResults() {
  [[ $# -eq 1 ]] || die "listModelResults requires <db>"
  local db_path="$1"
  ensure_db "$db_path"
  sqlite3 -header -column "$db_path" "SELECT id, model_name, dataset_name, split_type, accuracy, macro_f1, balanced_accuracy, status, created_at FROM model_results ORDER BY created_at, id;"
}

getModelResultById() {
  [[ $# -eq 2 ]] || die "getModelResultById requires <db> <id>"
  local db_path="$1"
  local id="$2"
  ensure_db "$db_path"
  sqlite3 -header -column "$db_path" "SELECT * FROM model_results WHERE id = $(sql_text "$id");"
}

updateModelResult() {
  [[ $# -eq 4 ]] || die "updateModelResult requires <db> <id> <field> <value|null>"
  local db_path="$1"
  local id="$2"
  local field="$3"
  local value="$4"
  local column
  local sql_value

  column="$(column_for_field "$field")"
  sql_value="$(sql_value_for_field "$field" "$value")"
  ensure_db "$db_path"

  sqlite3 "$db_path" <<SQL
UPDATE model_results
SET $column = $sql_value
WHERE id = $(sql_text "$id");
SQL
}

deleteModelResult() {
  [[ $# -eq 2 ]] || die "deleteModelResult requires <db> <id>"
  local db_path="$1"
  local id="$2"
  ensure_db "$db_path"
  sqlite3 "$db_path" "DELETE FROM model_results WHERE id = $(sql_text "$id");"
}

main() {
  require_sqlite
  local command="${1:-}"
  shift || true

  case "$command" in
    create|createModelResult) createModelResult "$@" ;;
    list|listModelResults) listModelResults "$@" ;;
    get|getModelResultById) getModelResultById "$@" ;;
    update|updateModelResult) updateModelResult "$@" ;;
    delete|deleteModelResult) deleteModelResult "$@" ;;
    ""|help|--help|-h) usage ;;
    *) usage; die "unknown command: $command" ;;
  esac
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  main "$@"
fi
