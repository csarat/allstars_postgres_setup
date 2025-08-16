#!/usr/bin/env bash
set -euo pipefail

ENV_FILE="${1:-envs/dev.env}"
if [[ ! -f "$ENV_FILE" ]]; then
  echo "Env file not found: $ENV_FILE"; exit 1
fi
set -a; source "$ENV_FILE"; set +a   # exports PG* vars for psql

PSQL_COMMON_FLAGS=(-v ON_ERROR_STOP=1 -X -q)

run_dir () {
  local d="$1"
  if [[ -d "$d" ]]; then
    for f in $(ls "$d"/*.sql 2>/dev/null | sort); do
      echo ">> psql: $f"
      psql "${PSQL_COMMON_FLAGS[@]}" -f "$f"
    done
  fi
}

# optional per-session settings
[[ -f scripts/psqlrc.sql ]] && psql "${PSQL_COMMON_FLAGS[@]}" -f scripts/psqlrc.sql || true

run_dir sql/00_extensions
run_dir sql/01_roles
run_dir sql/02_databases
run_dir sql/03_schemas
run_dir sql/04_ownership
run_dir sql/05_grants
run_dir sql/99_verify

echo "Bootstrap complete."
