#!/usr/bin/env bash
# Loads your digital avatar into an AI session.
# Outputs identity, preferences, and goals as structured markdown.

set -euo pipefail

# Configurable paths (environment variables with sensible defaults)
AVATAR_ROOT="${AVATAR_ROOT:-$HOME/Data/Vaults/Personal/Orchestration}"

# Guard: skip if avatar root doesn't exist
[ -d "$AVATAR_ROOT" ] || exit 0

# Source strip_front from forge-core (graceful fallback to inline)
_FORGE_CORE="${CLAUDE_PROJECT_ROOT:-$(builtin cd "$(dirname "$0")/../.." && pwd)}/Plugins/forge-core"
if [ -f "$_FORGE_CORE/lib/strip-front.sh" ]; then
  source "$_FORGE_CORE/lib/strip-front.sh"
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
