#!/usr/bin/env bash
set -euo pipefail

# Local WeeklyLog and Decision CRUD repository for Phase 18C.
# Uses the existing raw SQLite approach. No UI connection, API routes,
# fake progress, external automation, AI summarisation, or semantic search.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCHEMA_FILE="$SCRIPT_DIR/schema.sql"

usage() {
  cat <<'USAGE'
Usage:
  weekly_decision_repository.sh createWeeklyLog <db> <id> <week_start> <completed_json> <in_progress_json> <blocked_json> <literature_added_json> <dataset_progress> <coding_progress> <decisions_json> <next_actions_json>
  weekly_decision_repository.sh listWeeklyLogs <db>
  weekly_decision_repository.sh getWeeklyLogById <db> <id>
  weekly_decision_repository.sh updateWeeklyLog <db> <id> <field> <value|null>
  weekly_decision_repository.sh deleteWeeklyLog <db> <id>

  weekly_decision_repository.sh createDecision <db> <id> <date> <decision> <reason> <related_phase|null> <related_module|null>
  weekly_decision_repository.sh listDecisions <db>
  weekly_decision_repository.sh getDecisionById <db> <id>
  weekly_decision_repository.sh updateDecision <db> <id> <field> <value|null>
  weekly_decision_repository.sh deleteDecision <db> <id>

WeeklyLog fields accepted by update:
  weekStart week_start completed inProgress in_progress blocked
  literatureAdded literature_added datasetProgress dataset_progress
  codingProgress coding_progress decisions nextActions next_actions

Decision fields accepted by update:
  date decision reason relatedPhase related_phase relatedModule related_module

Array-like fields should be stored as JSON text.
Unknown values should be recorded as:
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

required_text() {
  local field="$1"
  local value="$2"
  [[ -n "$value" && "$value" != "null" && "$value" != "NULL" ]] || die "$field is required"
  printf "%s" "$value"
}

array_text() {
  if [[ "$1" == "" || "$1" == "null" || "$1" == "NULL" ]]; then
    printf "[]"
  else
    printf "%s" "$1"
  fi
}

weekly_column_for_field() {
  case "$1" in
    weekStart|week_start) printf "week_start" ;;
    completed) printf "completed" ;;
    inProgress|in_progress) printf "in_progress" ;;
    blocked) printf "blocked" ;;
    literatureAdded|literature_added) printf "literature_added" ;;
    datasetProgress|dataset_progress) printf "dataset_progress" ;;
    codingProgress|coding_progress) printf "coding_progress" ;;
    decisions) printf "decisions" ;;
    nextActions|next_actions) printf "next_actions" ;;
    *) die "unsupported WeeklyLog update field: $1" ;;
  esac
}

weekly_value_for_field() {
  local field="$1"
  local value="$2"

  case "$field" in
    weekStart|week_start)
      sql_text "$(required_text "weekStart" "$value")"
      ;;
    completed|inProgress|in_progress|blocked|literatureAdded|literature_added|decisions|nextActions|next_actions)
      sql_text "$(array_text "$value")"
      ;;
    datasetProgress|dataset_progress|codingProgress|coding_progress)
      sql_text "$value"
      ;;
    *) die "unsupported WeeklyLog update field: $field" ;;
  esac
}

decision_column_for_field() {
  case "$1" in
    date) printf "date" ;;
    decision) printf "decision" ;;
    reason) printf "reason" ;;
    relatedPhase|related_phase) printf "related_phase" ;;
    relatedModule|related_module) printf "related_module" ;;
    *) die "unsupported Decision update field: $1" ;;
  esac
}

decision_value_for_field() {
  local field="$1"
  local value="$2"

  case "$field" in
    date)
      sql_text "$(required_text "date" "$value")"
      ;;
    decision)
      sql_text "$(required_text "decision" "$value")"
      ;;
    reason)
      sql_text "$(required_text "reason" "$value")"
      ;;
    relatedPhase|related_phase|relatedModule|related_module)
      sql_optional_text "$value"
      ;;
    *) die "unsupported Decision update field: $field" ;;
  esac
}

createWeeklyLog() {
  [[ $# -eq 11 ]] || die "createWeeklyLog requires 11 arguments after the command"

  local db_path="$1"
  local id="$2"
  local week_start="$3"
  local completed="$4"
  local in_progress="$5"
  local blocked="$6"
  local literature_added="$7"
  local dataset_progress="$8"
  local coding_progress="$9"
  local decisions="${10}"
  local next_actions="${11}"

  [[ -n "$id" ]] || die "id is required"
  required_text "weekStart" "$week_start" >/dev/null
  ensure_db "$db_path"

  sqlite3 "$db_path" <<SQL
INSERT INTO weekly_logs (
  id, week_start, completed, in_progress, blocked, literature_added,
  dataset_progress, coding_progress, decisions, next_actions
) VALUES (
  $(sql_text "$id"),
  $(sql_text "$week_start"),
  $(sql_text "$(array_text "$completed")"),
  $(sql_text "$(array_text "$in_progress")"),
  $(sql_text "$(array_text "$blocked")"),
  $(sql_text "$(array_text "$literature_added")"),
  $(sql_text "$dataset_progress"),
  $(sql_text "$coding_progress"),
  $(sql_text "$(array_text "$decisions")"),
  $(sql_text "$(array_text "$next_actions")")
);
SQL
}

listWeeklyLogs() {
  [[ $# -eq 1 ]] || die "listWeeklyLogs requires <db>"
  local db_path="$1"
  ensure_db "$db_path"
  sqlite3 -header -column "$db_path" "SELECT id, week_start, dataset_progress, coding_progress FROM weekly_logs ORDER BY week_start, id;"
}

getWeeklyLogById() {
  [[ $# -eq 2 ]] || die "getWeeklyLogById requires <db> <id>"
  local db_path="$1"
  local id="$2"
  ensure_db "$db_path"
  sqlite3 -header -column "$db_path" "SELECT * FROM weekly_logs WHERE id = $(sql_text "$id");"
}

updateWeeklyLog() {
  [[ $# -eq 4 ]] || die "updateWeeklyLog requires <db> <id> <field> <value|null>"
  local db_path="$1"
  local id="$2"
  local field="$3"
  local value="$4"
  local column
  local sql_value

  column="$(weekly_column_for_field "$field")"
  sql_value="$(weekly_value_for_field "$field" "$value")"
  ensure_db "$db_path"

  sqlite3 "$db_path" <<SQL
UPDATE weekly_logs
SET $column = $sql_value
WHERE id = $(sql_text "$id");
SQL
}

deleteWeeklyLog() {
  [[ $# -eq 2 ]] || die "deleteWeeklyLog requires <db> <id>"
  local db_path="$1"
  local id="$2"
  ensure_db "$db_path"
  sqlite3 "$db_path" "DELETE FROM weekly_logs WHERE id = $(sql_text "$id");"
}

createDecision() {
  [[ $# -eq 7 ]] || die "createDecision requires 7 arguments after the command"

  local db_path="$1"
  local id="$2"
  local date="$3"
  local decision="$4"
  local reason="$5"
  local related_phase="$6"
  local related_module="$7"

  [[ -n "$id" ]] || die "id is required"
  required_text "date" "$date" >/dev/null
  required_text "decision" "$decision" >/dev/null
  required_text "reason" "$reason" >/dev/null
  ensure_db "$db_path"

  sqlite3 "$db_path" <<SQL
INSERT INTO decisions (
  id, date, decision, reason, related_phase, related_module
) VALUES (
  $(sql_text "$id"),
  $(sql_text "$date"),
  $(sql_text "$decision"),
  $(sql_text "$reason"),
  $(sql_optional_text "$related_phase"),
  $(sql_optional_text "$related_module")
);
SQL
}

listDecisions() {
  [[ $# -eq 1 ]] || die "listDecisions requires <db>"
  local db_path="$1"
  ensure_db "$db_path"
  sqlite3 -header -column "$db_path" "SELECT id, date, decision, related_phase, related_module FROM decisions ORDER BY date, id;"
}

getDecisionById() {
  [[ $# -eq 2 ]] || die "getDecisionById requires <db> <id>"
  local db_path="$1"
  local id="$2"
  ensure_db "$db_path"
  sqlite3 -header -column "$db_path" "SELECT * FROM decisions WHERE id = $(sql_text "$id");"
}

updateDecision() {
  [[ $# -eq 4 ]] || die "updateDecision requires <db> <id> <field> <value|null>"
  local db_path="$1"
  local id="$2"
  local field="$3"
  local value="$4"
  local column
  local sql_value

  column="$(decision_column_for_field "$field")"
  sql_value="$(decision_value_for_field "$field" "$value")"
  ensure_db "$db_path"

  sqlite3 "$db_path" <<SQL
UPDATE decisions
SET $column = $sql_value
WHERE id = $(sql_text "$id");
SQL
}

deleteDecision() {
  [[ $# -eq 2 ]] || die "deleteDecision requires <db> <id>"
  local db_path="$1"
  local id="$2"
  ensure_db "$db_path"
  sqlite3 "$db_path" "DELETE FROM decisions WHERE id = $(sql_text "$id");"
}

main() {
  require_sqlite
  local command="${1:-}"
  shift || true

  case "$command" in
    createWeeklyLog) createWeeklyLog "$@" ;;
    listWeeklyLogs) listWeeklyLogs "$@" ;;
    getWeeklyLogById) getWeeklyLogById "$@" ;;
    updateWeeklyLog) updateWeeklyLog "$@" ;;
    deleteWeeklyLog) deleteWeeklyLog "$@" ;;
    createDecision) createDecision "$@" ;;
    listDecisions) listDecisions "$@" ;;
    getDecisionById) getDecisionById "$@" ;;
    updateDecision) updateDecision "$@" ;;
    deleteDecision) deleteDecision "$@" ;;
    ""|help|--help|-h) usage ;;
    *) usage; die "unknown command: $command" ;;
  esac
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  main "$@"
fi
