#!/usr/bin/env bash
# Loads your digital avatar into an AI session.
# Outputs identity, preferences, and goals as structured markdown.

set -euo pipefail

# Configurable paths (environment variables with sensible defaults)
AVATAR_ROOT="${AVATAR_ROOT:-$HOME/Data/Vaults/Personal/Orchestration}"

# Guard: skip if avatar root doesn't exist
[ -d "$AVATAR_ROOT" ] || exit 0

# Strip YAML frontmatter (--- delimited block) and leading H1
strip_front() {
  awk '
    /^---$/ && !started { started=1; skip=1; next }
    /^---$/ && skip     { skip=0; next }
    skip                { next }
    !body && /^# /      { body=1; next }
    { body=1; print }
  ' "$1"
}

for file in Identity.md Preferences.md Goals.md; do
  [ -f "$AVATAR_ROOT/$file" ] && {
    section="${file%.md}"
    echo "## $section"
    strip_front "$AVATAR_ROOT/$file"
    echo
  }
done
