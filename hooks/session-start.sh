#!/usr/bin/env bash
# SessionStart hook: load digital avatar (identity, preferences, goals).
# Dual-mode: works standalone (CLAUDE_PLUGIN_ROOT) or as forge-core module (FORGE_MODULE_ROOT).
set -euo pipefail

MODULE_ROOT="${FORGE_MODULE_ROOT:-${CLAUDE_PLUGIN_ROOT:-$(builtin cd "$(dirname "$0")/.." && pwd)}}"

# Configurable paths (environment variables with sensible defaults)
AVATAR_ROOT="${AVATAR_ROOT:-$HOME/Data/Vaults/Personal/Orchestration}"

# Guard: skip if avatar root doesn't exist
[ -d "$AVATAR_ROOT" ] || exit 0

# Source strip_front: forge-core shared lib > local > inline fallback
if [ -n "${FORGE_LIB:-}" ] && [ -f "$FORGE_LIB/strip-front.sh" ]; then
  source "$FORGE_LIB/strip-front.sh"
elif [ -f "$MODULE_ROOT/lib/strip-front.sh" ]; then
  source "$MODULE_ROOT/lib/strip-front.sh"
else
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
  [ -f "$AVATAR_ROOT/$file" ] && {
    section="${file%.md}"
    echo "## $section"
    strip_front "$AVATAR_ROOT/$file"
    echo
  }
done
