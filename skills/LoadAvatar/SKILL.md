---
name: LoadAvatar
description: "Load the user's goals, beliefs, challenges, strategies, mental models, narratives, faultlines, and frames into the current session. USE WHEN load goals, load beliefs, what are my goals, what do I believe, what are my challenges, what are my strategies, what are my mental models, load self-knowledge, load identity context, who am I beyond basics, full context about the user, what matters to me, what drives me."
argument-hint: "[goals | beliefs | challenges | strategies | models | narratives | faultlines | frames]"
---

# LoadAvatar

Load the user's self-knowledge into the current session. At session start, only basic identity and preferences are injected (~200 tokens). This skill loads the rest on demand — goals, beliefs, challenges, strategies, mental models, narratives, faultlines, and frames.

Use this when a task needs deeper understanding of the user: what they're working toward, how they think, what tensions they navigate, or what patterns they follow.

## Step 1: Determine scope

If an argument specifies a section, load only that section. Otherwise load all sections.

| Argument | What loads |
|----------|-----------|
| `goals` | What the user is working toward — missions and objectives |
| `beliefs` | Core convictions about how things work |
| `challenges` | Active difficulties and open problems |
| `strategies` | Approaches and tactics the user relies on |
| `models` | Mental models and frameworks for decision-making |
| `narratives` | Stories the user tells about themselves (current vs. target) |
| `faultlines` | Persistent tensions and tradeoffs |
| `frames` | Decision lenses and default behaviors |
| _(none)_ | All of the above |

## Step 2: Read content

Read files from `Resources/Avatar/<Section>/` via `safe-read`. Each section is a directory with one file per item.

Skip folder notes (files named same as their parent directory).

## Step 3: Present to session

Output each section under a `## Section` heading. Present item content directly — no synthesis, no transformation. This is context loading, not analysis.

## Constraints

- Always use `safe-read` (files are AMBER by default)
- Read-only — never modify files
- Skip frontmatter in output — content only
