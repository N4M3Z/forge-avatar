#!/usr/bin/env bash
# SessionStart: load digital avatar (identity, preferences, self-knowledge).
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

AVATAR="${FORGE_USER_ROOT:-$HOME/Data/Vaults/Personal}/Resources/Avatar"

# Root files: core identity
for file in Identity.md Preferences.md; do
  if [ -f "$AVATAR/$file" ]; then
    section="${file%.md}"
    echo "## $section"
    strip_front "$AVATAR/$file"
    echo
  fi
done

# Self-knowledge: one directory per category, one file per item
for dir in Goals Faultlines Beliefs Strategies Models Narratives Challenges Frames; do
  if [ -d "$AVATAR/$dir" ]; then
    echo "## $dir"
    for file in "$AVATAR/$dir"/*.md; do
      if [ -f "$file" ]; then
        # Skip folder notes (collection MoCs)
        basename="${file##*/}"
        if [ "${basename%.md}" = "$dir" ]; then continue; fi
        strip_front "$file"
        echo
      fi
    done
  fi
done
