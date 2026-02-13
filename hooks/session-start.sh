#!/usr/bin/env bash
# SessionStart: load digital avatar (identity, preferences, goals).
set -euo pipefail

# Guard: skip if orchestration directory doesn't exist
ORCH="${FORGE_USER_ROOT:-$HOME/Data/Vaults/Personal}/Orchestration"
[ -d "$ORCH" ] || exit 0

# Source strip_front: forge-core shared lib > inline fallback
if [ -n "${FORGE_LIB:-}" ] && [ -f "$FORGE_LIB/strip-front.sh" ]; then
  source "$FORGE_LIB/strip-front.sh"
elif ! type strip_front &>/dev/null; then
  strip_front() {
    awk '
      /^---$/ && !started { started=1; skip=1; next }
      /^---$/ && skip     { skip=0; next }
      skip                { next }
      !body && /^# /      { body=1; next }
      { body=1; print }
    ' "$1"
  }
fi

for file in Identity.md Preferences.md Goals.md; do
  if [ -f "$ORCH/$file" ]; then
    section="${file%.md}"
    echo "## $section"
    strip_front "$ORCH/$file"
    echo
  fi
done
