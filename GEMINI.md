# GEMINI.md

This file provides instructional context for the Gemini AI agent when working with the **forge-avatar** module.

## Project Overview

**forge-avatar** is the "Identity Layer" (Layer 1) of the Forge Framework. It maintains a structured digital representation of the user—their background, preferences, goals, and self-knowledge—as a collection of plain markdown files. These files are injected into AI sessions at startup to align the AI with the user's identity and objectives.

### Key Concepts
- **Digital Avatar:** A set of markdown files that define the user's identity.
- **TELOS Framework:** The organizational structure for self-knowledge (Beliefs, Strategies, Models, etc.).
- **Injection:** The process of reading avatar files, stripping frontmatter, and presenting them as context to the AI.

## Architecture

### Component Structure
- **Core Identity:** `Identity.md` (who you are), `Preferences.md` (how you work), `Goals.md` (what you want).
- **Self-Knowledge (TELOS):** Directories (`Beliefs/`, `Faultlines/`, `Strategies/`, etc.) containing individual item files.
- **Templates:** Scaffolds in `scaffold/` for initializing a user's avatar.
- **Skill:** Located in `skills/Avatar/SKILL.md`, providing logic for interviews and refinement.

### Hook System
- **SessionStart:** The `hooks/session-start.sh` script is executed when a new AI session begins. It aggregates the avatar files into a single context block.

## Building and Running

### Key Commands
- **Test:** `bash tests/test.sh` runs the module's test suite.
- **Manual Injection Test:** `bash hooks/session-start.sh` (Requires `FORGE_USER_ROOT` or `AVATAR_ROOT` to be set).
- **Update Adapters:** `bash Core/bin/forge-update.sh` (from `forge-core`) to regenerate plugin configurations.

### Environment Variables
- `FORGE_USER_ROOT`: Path to the user's vault/data.
- `AVATAR_ROOT`: Direct override for the location of avatar files (defaults to `$FORGE_USER_ROOT/Resources/Avatar`).

## Development Conventions

### File Formatting
- **Frontmatter:** All avatar files use YAML frontmatter for metadata (title, aliases, tags).
- **Item IDs:** Items in self-knowledge directories use stable aliases (e.g., `B1` for Belief 1). These must NEVER be renumbered.
- **Stripping:** The `strip_front` function in `hooks/session-start.sh` is used to remove YAML frontmatter before presenting content to the AI.

### TLP (Traffic Light Protocol)
- **AMBER/RED:** Respect access controls. Avatar files are often `TLP:AMBER`. Use `safe-read` and `safe-write` when applicable.

### Avatar Refinement
- When updating the avatar, prioritize **Precision**, **Consistency**, and **Connections** (linking items via `root:` or `related:`).
- Maintain the stable ID system—append new items rather than reordering existing ones.

## Key Files
| File | Purpose |
| :--- | :--- |
| `module.yaml` | Module metadata and event definitions. |
| `hooks/session-start.sh` | Logic for context injection. |
| `skills/Avatar/SKILL.md` | Expert guidance for avatar interviews and management. |
| `scaffold/` | The "golden copy" of the avatar structure for new users. |
