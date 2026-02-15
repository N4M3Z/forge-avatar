# forge-avatar

Your digital avatar — the markdown files that tell AI tools who you are, what you prefer, and what you're working toward.

When an AI session starts, forge-avatar reads your identity files and injects them as context. The AI then operates as your digital representative: aligned with your goals, following your preferences, remembering your decisions.

Think of it as **dotfiles for AI identity**. Just as `.bashrc` configures your shell, avatar files configure your AI environment.

## Layer

**Identity** — the first of forge-core's three layers (Identity / Behaviour / Knowledge). Loaded once at session start via the `SessionStart` hook.

## What is an avatar?

Your avatar is defined by two core identity files plus eight self-knowledge directories (one file per item, inspired by the TELOS framework):

| File | Purpose |
|------|---------|
| `Identity.md` | Who you are — background, role, expertise, interests |
| `Preferences.md` | How you communicate — code style, decision-making principles |
| `Goals.md` | Mission and active objectives, principles |
| `Faultlines.md` | Civilization-level tensions driving mission (FL1–FL4) |
| `Beliefs.md` | Core convictions and values (B1–B12) |
| `Strategies.md` | Approaches to problem-solving (S1–S6) |
| `Models.md` | Mental frameworks for decision-making (MD1–MD7) |
| `Narratives.md` | Elevator pitch and self-description (draft) |
| `Challenges.md` | Personal obstacles and operational constraints (C1–C9) |
| `Frames.md` | Decision lenses applied contextually (F1–F5) |

Beyond the core three, your avatar can include:

- **Agents/** — specialist personas (researcher, reviewer, logger)
- **Patterns/** — reusable prompt templates with `{input}` placeholders
- **Memory/** — imperatives, insights, and ideas accumulated over time
- **Backlog.md** — persistent task list across sessions

The actual content lives in your workspace — never in this module. The module provides the loading framework; you fill it with your life.

## Quick start

1. Copy the scaffold to your workspace:
   ```bash
   cp -r scaffold/ ~/my-workspace/Orchestration/
   ```

2. Edit the core files:
   - `Identity.md` — replace placeholders with your info
   - `Preferences.md` — set your communication and code style
   - `Goals.md` — add your current objectives

3. Set `AVATAR_ROOT` if your files aren't at the default path:
   ```bash
   export AVATAR_ROOT="$HOME/my-workspace/Orchestration"
   ```

4. Test the loader:
   ```bash
   bash hooks/session-start.sh
   ```

## File reference

### Core identity (loaded at session start)

- **Identity.md** — Name, background, current role, expertise, interests. This is what the AI reads first.
- **Preferences.md** — Communication style, code conventions, decision-making principles. Shapes how the AI interacts with you.
- **Goals.md** — Mission, active objectives, completed goals, guiding principles. Gives the AI direction.

### Self-knowledge directories (loaded at session start, one file per item)

- **Faultlines/** — Civilization-level tensions driving mission and values (FL1–FL4). The big problems worth caring about.
- **Beliefs.md** — Core convictions and values (B1–B12). Non-negotiable principles that shape decisions.
- **Strategies.md** — Approaches to solving problems (S1–S6). How you attack challenges.
- **Models.md** — Mental frameworks for decision-making (MD1–MD7). First principles, systems thinking, Pareto, Range-Frequency Theory.
- **Narratives.md** — How you describe yourself to the world (draft). Elevator pitch, identity framing.
- **Challenges/** — Personal obstacles and operational constraints (C1–C9). Where Faultlines and life circumstances meet daily reality.
- **Frames.md** — Decision lenses (F1–F5). Contextual perspectives for evaluating choices.

### Templates (scaffolds for creating new items)

| Template | Creates |
|----------|---------|
| `Templates/Agent.md` | Specialist persona with role, expertise, personality, instructions, constraints |
| `Templates/Pattern.md` | Prompt template with system prompt, instructions, output format, `{input}` |
| `Templates/Imperative.md` | Imperative record with context, rationale, status |
| `Templates/Insight.md` | Insight record with origin, finding, actionable rule |
| `Templates/Idea.md` | Idea record with spark, description, status tracking |

### Agents (universal, work for anyone)

- **Researcher.md** — Investigates topics, finds sources, synthesizes findings

### Patterns (universal prompt templates)

- **Summarize.md** — Condense content to key points
- **Fix Grammar.md** — Grammar and spelling correction
- **Explain Simply.md** — Rewrite for clarity at a 6th-grade level
- **Extract Alpha.md** — Pull genuinely surprising insights (Shannon information theory)

### Memory (empty directories, schemas in Templates)

- `Memory/Imperatives/` — Individual imperative files
- `Memory/Insights/` — Individual insight files
- `Memory/Ideas/` — Individual idea files

## Configuration

**module.yaml** — checked into git:

```yaml
name: forge-avatar
version: 0.3.0
description: Digital avatar loader — identity, self-knowledge, goals. USE WHEN you need identity, preferences, goals, or self-knowledge context.
events:
  - SessionStart
```

## Environment variables

| Variable | Default | Description |
|----------|---------|-------------|
| `FORGE_USER_ROOT` | (set by forge-core dispatch) | User content root; avatar reads `$FORGE_USER_ROOT/Resources/Avatar/` |

## Extending your avatar

### Adding agents

Copy `Templates/Agent.md`, fill in the role, expertise, personality, and instructions. Save to `Agents/YourAgent.md`.

### Adding patterns

Copy `Templates/Pattern.md`, define system prompt, instructions, and output format. Save to `Patterns/YourPattern.md`. Always include `{input}` where the user's content goes.

### Adding memory

As you work, the AI (or you) creates files in `Memory/`:
- Imperatives go in `Memory/Imperatives/Title.md`
- Insights go in `Memory/Insights/Title.md`
- Ideas go in `Memory/Ideas/Title.md`

These accumulate over time and can be searched by future sessions.
