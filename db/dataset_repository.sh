#!/usr/bin/env bash
set -euo pipefail

# Local Dataset metadata CRUD repository for Phase 12C.
# Uses the existing raw SQLite approach. No UI connection, API routes,
# real EDF files, Sleep-EDF preprocessing, dataset upload, or model training.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCHEMA_FILE="$SCRIPT_DIR/schema.sql"

usage() {
  cat <<'USAGE'
Usage:
  dataset_repository.sh create <db> <id> <name> <source|null> <file_format> <signal_types_json> <annotation_type> <epoch_length|null> <task> <status> <notes|null>
  dataset_repository.sh list <db>
  dataset_repository.sh get <db> <id>
  dataset_repository.sh update <db> <id> <field> <value|null>
  dataset_repository.sh delete <db> <id>

Fields accepted by update:
  name source fileFormat file_format signalTypes signal_types
  annotationType annotation_type epochLength epoch_length task status notes

Status values:
  planned, metadata-only, raw-files-pending, preprocessing-planned, processed, archived

Unknown metadata values should be recorded as:
  to be confirmed
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

metadata_value() {
  if [[ "$1" == "" || "$1" == "null" || "$1" == "NULL" ]]; then
    printf "to be confirmed"
  else
    printf "%s" "$1"
  fi
}

signal_types_value() {
  if [[ "$1" == "" || "$1" == "null" || "$1" == "NULL" ]]; then
    printf "[]"
  else
    printf "%s" "$1"
  fi
}

validate_status() {
  case "$1" in
    planned|metadata-only|raw-files-pending|preprocessing-planned|processed|archived) ;;
    *) die "status must be one of: planned, metadata-only, raw-files-pending, preprocessing-planned, processed, archived" ;;
  esac
}

column_for_field() {
  case "$1" in
    name) printf "name" ;;
    source) printf "source" ;;
    fileFormat|file_format) printf "file_format" ;;
    signalTypes|signal_types) printf "signal_types" ;;
    annotationType|annotation_type) printf "annotation_type" ;;
    epochLength|epoch_length) printf "epoch_length" ;;
    task) printf "task" ;;
    status) printf "status" ;;
    notes) printf "notes" ;;
    *) die "unsupported update field: $1" ;;
  esac
}

sql_value_for_field() {
  local field="$1"
  local value="$2"

  case "$field" in
    name)
      [[ -n "$value" && "$value" != "null" && "$value" != "NULL" ]] || die "name is required"
      sql_text "$value"
      ;;
    status)
      validate_status "$value"
      sql_text "$value"
      ;;
    fileFormat|file_format|annotationType|annotation_type|task)
      sql_text "$(metadata_value "$value")"
      ;;
    signalTypes|signal_types)
      sql_text "$(signal_types_value "$value")"
      ;;
    source|epochLength|epoch_length|notes)
      sql_optional_text "$value"
      ;;
    *) die "unsupported update field: $field" ;;
  esac
}

createDataset() {
  [[ $# -eq 11 ]] || die "createDataset requires 11 arguments after the command"

  local db_path="$1"
  local id="$2"
  local name="$3"
  local source="$4"
  local file_format="$5"
  local signal_types="$6"
  local annotation_type="$7"
  local epoch_length="$8"
  local task="$9"
  local status="${10}"
  local notes="${11}"

  [[ -n "$id" ]] || die "id is required"
  [[ -n "$name" ]] || die "name is required"
  validate_status "$status"
  ensure_db "$db_path"

  sqlite3 "$db_path" <<SQL
INSERT INTO datasets (
  id, name, source, file_format, signal_types, annotation_type,
  epoch_length, task, status, notes
) VALUES (
  $(sql_text "$id"),
  $(sql_text "$name"),
  $(sql_optional_text "$source"),
  $(sql_text "$(metadata_value "$file_format")"),
  $(sql_text "$(signal_types_value "$signal_types")"),
  $(sql_text "$(metadata_value "$annotation_type")"),
  $(sql_optional_text "$epoch_length"),
  $(sql_text "$(metadata_value "$task")"),
  $(sql_text "$status"),
  $(sql_optional_text "$notes")
);
SQL
}

listDatasets() {
  [[ $# -eq 1 ]] || die "listDatasets requires <db>"
  local db_path="$1"
  ensure_db "$db_path"
  sqlite3 -header -column "$db_path" "SELECT id, name, file_format, annotation_type, task, status FROM datasets ORDER BY name, id;"
}

getDatasetById() {
  [[ $# -eq 2 ]] || die "getDatasetById requires <db> <id>"
  local db_path="$1"
  local id="$2"
  ensure_db "$db_path"
  sqlite3 -header -column "$db_path" "SELECT * FROM datasets WHERE id = $(sql_text "$id");"
}

updateDataset() {
  [[ $# -eq 4 ]] || die "updateDataset requires <db> <id> <field> <value|null>"
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
UPDATE datasets
SET $column = $sql_value
WHERE id = $(sql_text "$id");
SQL
}

deleteDataset() {
  [[ $# -eq 2 ]] || die "deleteDataset requires <db> <id>"
  local db_path="$1"
  local id="$2"
  ensure_db "$db_path"
  sqlite3 "$db_path" "DELETE FROM datasets WHERE id = $(sql_text "$id");"
}

main() {
  require_sqlite
  local command="${1:-}"
  shift || true

  case "$command" in
    create|createDataset) createDataset "$@" ;;
    list|listDatasets) listDatasets "$@" ;;
    get|getDatasetById) getDatasetById "$@" ;;
    update|updateDataset) updateDataset "$@" ;;
    delete|deleteDataset) deleteDataset "$@" ;;
    ""|help|--help|-h) usage ;;
    *) usage; die "unknown command: $command" ;;
  esac
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  main "$@"
fi
