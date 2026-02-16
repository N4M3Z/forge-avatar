# forge-avatar

Digital avatar loader — identity, preferences, goals, and self-knowledge. Content module (markdown + shell hooks, no Rust).

## Testing

```bash
bash tests/test.sh
```

## Structure

- `scaffold/` — template files for new users (Identity.md, Preferences.md, Goals.md, etc.)
- `hooks/session-start.sh` — loads avatar content at session start
- `skills/Avatar/` — guided interview for avatar refinement

## Code Style

- Shell hooks: `set -euo pipefail`, double-quoted variables
- Content files: Obsidian-compatible YAML frontmatter, wikilinks
