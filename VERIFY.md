# forge-avatar — Verification

> **For AI agents**: Complete this checklist after installation. Every check must pass before declaring the module installed.

## Quick check

```bash
bash tests/test.sh
```

## Manual checks

### SessionStart hook
```bash
bash hooks/session-start.sh
# Should emit Identity, Preferences, Goals sections (if AVATAR_ROOT exists)
```

## Expected test results

- Tests covering structure, session-start.sh, avatar loading
- All tests PASS
