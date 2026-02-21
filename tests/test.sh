#!/usr/bin/env bash
# forge-avatar module tests.
# Run: bash tests/test.sh
set -uo pipefail

MODULE_ROOT="$(command cd "$(dirname "$0")/.." && pwd)"
PASS=0 FAIL=0

# --- Helpers ---

_tmpdirs=()
setup() {
  _tmpdir=$(mktemp -d)
  _tmpdirs+=("$_tmpdir")
}
cleanup_all() {
  command rm -f "$MODULE_ROOT/config.yaml"
  for d in "${_tmpdirs[@]}"; do
    [ -d "$d" ] && command rm -rf "$d"
  done
}
trap cleanup_all EXIT

assert_eq() {
  local label="$1" expected="$2" actual="$3"
  if [ "$expected" = "$actual" ]; then
    printf '  PASS  %s\n' "$label"
    PASS=$((PASS + 1))
  else
    printf '  FAIL  %s\n' "$label"
    printf '    expected: %s\n' "$(echo "$expected" | head -5)"
    printf '    actual:   %s\n' "$(echo "$actual" | head -5)"
    FAIL=$((FAIL + 1))
  fi
}

assert_contains() {
  local label="$1" needle="$2" haystack="$3"
  if echo "$haystack" | grep -qF "$needle"; then
    printf '  PASS  %s\n' "$label"
    PASS=$((PASS + 1))
  else
    printf '  FAIL  %s\n' "$label"
    printf '    expected to contain: %s\n' "$needle"
    printf '    actual: %s\n' "$(echo "$haystack" | head -5)"
    FAIL=$((FAIL + 1))
  fi
}

assert_not_contains() {
  local label="$1" needle="$2" haystack="$3"
  if echo "$haystack" | grep -qF "$needle"; then
    printf '  FAIL  %s\n' "$label"
    printf '    should not contain: %s\n' "$needle"
    FAIL=$((FAIL + 1))
  else
    printf '  PASS  %s\n' "$label"
    PASS=$((PASS + 1))
  fi
}

echo "=== forge-avatar tests ==="

# ============================================================
# Structure tests
# ============================================================
printf '\n--- Structure ---\n'

# module.yaml has required fields
if [ -f "$MODULE_ROOT/module.yaml" ]; then
  printf '  PASS  module.yaml exists\n'; PASS=$((PASS + 1))
else
  printf '  FAIL  module.yaml missing\n'; FAIL=$((FAIL + 1))
fi

mod_yaml=$(cat "$MODULE_ROOT/module.yaml")
assert_contains "module.yaml has name" "name:" "$mod_yaml"
assert_contains "module.yaml has version" "version:" "$mod_yaml"
assert_contains "module.yaml has events" "events:" "$mod_yaml"
assert_contains "module.yaml has metadata" "metadata:" "$mod_yaml"

# hooks.json is valid JSON
if [ -f "$MODULE_ROOT/hooks/hooks.json" ] && python3 -c "import json; json.load(open('$MODULE_ROOT/hooks/hooks.json'))" 2>/dev/null; then
  printf '  PASS  hooks.json is valid JSON\n'; PASS=$((PASS + 1))
else
  printf '  FAIL  hooks.json invalid or missing\n'; FAIL=$((FAIL + 1))
fi

# plugin.json is valid JSON
if [ -f "$MODULE_ROOT/.claude-plugin/plugin.json" ] && python3 -c "import json; json.load(open('$MODULE_ROOT/.claude-plugin/plugin.json'))" 2>/dev/null; then
  printf '  PASS  plugin.json is valid JSON\n'; PASS=$((PASS + 1))
else
  printf '  FAIL  plugin.json invalid or missing\n'; FAIL=$((FAIL + 1))
fi

# SessionStart.sh exists and is executable
if [ -x "$MODULE_ROOT/hooks/SessionStart.sh" ]; then
  printf '  PASS  SessionStart.sh exists and is executable\n'; PASS=$((PASS + 1))
else
  printf '  FAIL  SessionStart.sh missing or not executable\n'; FAIL=$((FAIL + 1))
fi

# scaffold directory exists
if [ -d "$MODULE_ROOT/scaffold" ]; then
  printf '  PASS  scaffold/ directory exists\n'; PASS=$((PASS + 1))
else
  printf '  FAIL  scaffold/ directory missing\n'; FAIL=$((FAIL + 1))
fi

# scaffold has core files
for f in Identity.md Preferences.md Goals.md; do
  if [ -f "$MODULE_ROOT/scaffold/$f" ]; then
    printf '  PASS  scaffold/%s exists\n' "$f"; PASS=$((PASS + 1))
  else
    printf '  FAIL  scaffold/%s missing\n' "$f"; FAIL=$((FAIL + 1))
  fi
done

# ============================================================
# session-start.sh tests
# ============================================================
printf '\n--- session-start.sh ---\n'

# With a mock avatar root (hook reads FORGE_USER_ROOT, resolves Resources/Avatar/)
setup
mkdir -p "$_tmpdir/Resources/Avatar"
mkdir -p "$_tmpdir/Orchestration"
printf -- '---\ntitle: Test Identity\n---\n\n# Identity\n\nI am a test user.\n' > "$_tmpdir/Resources/Avatar/Identity.md"
printf -- '---\ntitle: Test Preferences\n---\n\n# Preferences\n\nI prefer tests.\n' > "$_tmpdir/Resources/Avatar/Preferences.md"
printf -- '---\ntitle: Test Goals\n---\n\n# Goals\n\nGoal: pass all tests.\n' > "$_tmpdir/Resources/Avatar/Goals.md"

result=$(FORGE_USER_ROOT="$_tmpdir" bash "$MODULE_ROOT/hooks/SessionStart.sh" 2>/dev/null) || true
assert_contains "session-start: emits Identity section" "## Identity" "$result"
assert_contains "session-start: emits Preferences section" "## Preferences" "$result"
assert_contains "session-start: Identity content" "I am a test user" "$result"
assert_not_contains "session-start: frontmatter stripped" "title: Test Identity" "$result"

# Self-knowledge sections should NOT be in hook output (on-demand via /LoadAvatar)
for section in Goals Faultlines Beliefs Strategies Models Narratives Challenges Frames; do
  assert_not_contains "session-start: no $section section" "## $section" "$result"
done

# Non-existent user root → exits 0 with no output
setup
result=$(FORGE_USER_ROOT="$_tmpdir/nonexistent" bash "$MODULE_ROOT/hooks/SessionStart.sh" 2>/dev/null) || true
assert_eq "session-start: missing user root → empty output" "" "$result"

exit_code=0
FORGE_USER_ROOT="$_tmpdir/nonexistent" bash "$MODULE_ROOT/hooks/SessionStart.sh" >/dev/null 2>&1 || exit_code=$?
assert_eq "session-start: missing user root → exits 0" "0" "$exit_code"

# ============================================================
# Naming consistency
# ============================================================
printf '\n--- Naming consistency ---\n'

mod_name=$(awk '/^name:/{print $2; exit}' "$MODULE_ROOT/module.yaml")
plugin_name=$(python3 -c "import json; print(json.load(open('$MODULE_ROOT/.claude-plugin/plugin.json'))['name'])" 2>/dev/null)
assert_eq "module.yaml name matches plugin.json name" "$mod_name" "$plugin_name"

mod_version=$(awk '/^version:/{print $2; exit}' "$MODULE_ROOT/module.yaml")
plugin_version=$(python3 -c "import json; print(json.load(open('$MODULE_ROOT/.claude-plugin/plugin.json'))['version'])" 2>/dev/null)
assert_eq "module.yaml version matches plugin.json version" "$mod_version" "$plugin_version"

# ============================================================
# Summary
# ============================================================
printf '\n=== Results ===\n'
printf '  %d passed, %d failed\n\n' "$PASS" "$FAIL"
[ "$FAIL" -eq 0 ] && exit 0 || exit 1
