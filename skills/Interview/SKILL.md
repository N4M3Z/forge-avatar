---
name: Interview
description: Compile topic context into a portable voice-interview document and process results back. USE WHEN voice brief, voice prep, prepare for voice, interview prep, compile context for voice, export for ChatGPT voice, export for Claude voice, process voice output, import voice results, voice project file, project context.
argument-hint: "[project | prepare <topic> | process]"
---

# Interview

Compile vault context about any topic into a self-contained document optimized for voice-mode AI conversations (Claude voice, ChatGPT voice, Gemini). The receiving AI gets identity context, background material, an interview guide, and a structured output specification — enabling a round-trip: prepare here, interview there, process results back.

## Workflow Routing

| Workflow | Trigger | Section |
|----------|---------|---------|
| **Project** | `/Interview project` | [Project](#project-workflow) |
| **Prepare** | `/Interview <topic>`, `/Interview prepare <topic>` | [Prepare](#prepare-workflow) |
| **Process** | `/Interview process` | [Process](#process-workflow) |

---

## Project Workflow

Generate a persistent project-level context file for upload to a Claude Project or ChatGPT Project. This is the baseline the voice AI reads before every conversation — who you are, how you think, what you're working on. Upload once, update when your identity or goals shift significantly.

### Step 1: PII check

Ask: "Should the project file include your real name and personal details, or anonymize?"

- **Include** (default for project files — these are uploaded to your own private project)
- **Anonymize** — replace real name with "the user", strip team member names, generalize company references

### Step 2: Read full avatar

Read all files from `Resources/Avatar/` via `safe-read`:
- `Identity.md` — full content (background, role, expertise, interests)
- `Preferences.md` — full content (communication style, code style, decision making)
- All self-knowledge directories: Goals, Faultlines, Beliefs, Strategies, Models, Narratives, Challenges, Frames — every item, not topic-filtered

### Step 3: Compile the project file

Assemble a single document following the [Project File Format](#project-file-format). Apply these rules:

- **Strip all frontmatter** and wikilinks — convert to plain text
- **Keep item IDs inline** (e.g., "G2: Ship Chargebee migration") so the voice AI can reference them and they appear in interview output
- **Organize by section** with clear headings
- **Include behavioral instructions** — how the voice AI should interact (derived from Preferences.md but expanded for voice)
- **Target 1000-2000 words** — project context windows are generous, but concise is still better
- **No topic-specific content** — this is the stable baseline, not per-session

### Step 4: Write and report

Write to `Scratch/interview-project.md`.

Report:
- File path and word count
- Instructions: "Upload this file to your Claude Project (Project Knowledge) or ChatGPT Project (Project Instructions). Update it when your goals or identity change significantly. Then use `/Interview <topic>` to prepare per-session briefs."

---

## Prepare Workflow

### Step 1: PII and project file check

Ask two questions:

1. **Project file**: "Did you upload the project file to your voice AI project?" (or check if `Scratch/interview-project.md` exists as a proxy).
2. **PII**: "Should this brief include your real name and personal details, or anonymize?" Default to **anonymize** for interview briefs — these are pasted into conversations that may be shared or logged by third-party services.

- **Project file uploaded**: Skip the avatar summary entirely. The interview brief only needs topic-specific content — the voice AI already knows who you are.
- **No project file**: Read `Identity.md` and `Preferences.md` from `Resources/Avatar/` via `safe-read`. Scan avatar subdirectories (Goals, Beliefs, Strategies, Challenges, Faultlines, Models, Narratives, Frames) but only include items relevant to the topic. Target: 150-300 words of avatar summary. Strip all frontmatter and wikilinks — convert `[[Note Name]]` to plain `Note Name`.

### Step 2: Search vault and read matching content

Two passes — search first, then read. **Every item that makes it into the brief must have its content read, not just its filename.**

**Pass 1 — Search**: Find matching files across these locations:

| Location | Tool | What to look for |
|----------|------|------------------|
| `Orchestration/Memory/Insights/` | Grep | Insights related to the topic |
| `Orchestration/Memory/Imperatives/` | Grep | Decisions related to the topic |
| `Orchestration/Memory/Ideas/` | Grep | Open ideas related to the topic |
| `Orchestration/Backlog.md` | safe-read + scan | Backlog items mentioning the topic |
| Recent daily journals (last 7 days) | safe-read | Journal entries mentioning the topic |
| Vault-wide | Grep (filenames) | Project notes, reference material matching topic |

Follow wikilinks found in matching content (one hop only) if they look relevant.

**Pass 2 — Read and summarize**: For every matched file, `safe-read` the full content and extract a 2-4 sentence summary (20 content words minimum — excluding a, the, and, or, of, in, to, for, is, it) capturing: what was decided/learned/proposed, why it matters, and current status. Titles alone are never sufficient — the voice AI has no vault access, so everything it needs to discuss must be in the brief.

**Cap at 15-20 items**. If the search returns more, curate the most relevant subset. Depth beats breadth — 15 well-summarized items are worth more than 50 titles.

### Step 3: Present findings and refine scope

Show the user a summary of **what was found and what the brief will contain** — not just counts, but the actual items with one-line summaries so the user can confirm scope:

```
Found context for "Q2 planning" — 8 items for the brief:

  Insights:
  - Team capacity overcommit: team delivers ~70% of planned scope consistently
  - Planning cadence shift: weekly standups replaced by async daily updates

  Imperatives:
  - Quarterly review process: time-box planning to one week, not spread across a month

  Ideas:
  - Cross-team sync ritual: proposed bi-weekly alignment meeting with platform team

  Backlog: 3 items tagged Q2 (kickoff scheduling, OKR draft, capacity planning)
  Journal: 2 recent entries (retrospective notes, headcount discussion)

  Anything to add or remove? Specific [[wikilinks]] or file paths?
```

The user may add specific notes, remove irrelevant hits, or adjust the scope. Items removed here won't appear in the brief.

### Step 4: Design the interview guide

Based on the gathered context, draft 5-8 topic-specific questions for the interview guide. Each question must:

- **Embed the context it references** — the voice AI can't look anything up, so the question itself must contain enough detail for a meaningful discussion. Bad: "The Skills Architecture cluster has 5 imperatives. What replaces them?" Good: "You have 5 overlapping imperatives about skills: (1) skills use canon+sidecar pattern for upstream portability, (2) two directories — Upstream for shared, Skills for local, (3) agents reference skills as single source of truth, (4) vault is the source of truth not adapters, (5) promotion/drafting are scripts with AI wrappers. These overlap heavily — what's the single rule?"
- **Reference actual content**, not just titles — cite specific numbers, dates, statuses, or findings from the items read in Step 2
- **Target decision points** — contradictions, outdated items, merge candidates, or promotion-ready items

Present the draft questions to the user. They may adjust, reorder, add, or remove questions. This is where the user's domain knowledge shapes the interview.

### Step 5: Compile the interview document

Assemble the four-section document (see [Output Format](#output-format)). Apply these rules:

- **Strip all frontmatter** from included content
- **Convert wikilinks** to plain text (`[[Note]]` becomes `Note`)
- **Substantive summaries, not titles** — every item in the Background Context section must be a paragraph (2-4 sentences, 20 content words minimum — excluding a, the, and, or, of, in, to, for, is, it) capturing the what, why, and current status. A list of titles is a failure mode — the voice AI cannot discuss items it knows nothing about.
- **Enforce word budget** — total document under 2000 words. If context exceeds this, **cut items, don't shorten summaries**. 10 well-described items beat 30 titles. Prioritize: interview guide (with embedded context) > most relevant background > avatar summary > remaining background
- **Questions are self-contained** — each interview question must include enough inline context that the voice AI can discuss it without referring back to the Background section. Redundancy between Background and Interview Guide is acceptable and expected.
- **Plain text only** — no Obsidian syntax, no YAML, no code blocks in the background section

### Step 6: Write and report

Write the compiled document to `Scratch/interview-<slug>.md` where `<slug>` is the topic lowercased with spaces replaced by hyphens.

Report:
- File path
- Word count
- Tip: "Paste the full document into your voice AI as the first message or system prompt. When done, run `/Interview process` to import results."

---

## Process Workflow

### Step 1: Receive voice output

Ask the user to paste the structured output from their voice session. The output should follow the format specified in the interview document's Output Specification section.

### Step 2: Parse and map to destinations

Parse the pasted output by `###` section headings and map to vault locations:

| Output Section | Vault Destination | Write Method |
|----------------|-------------------|-------------|
| Decisions | `Orchestration/Memory/Imperatives/<title>.md` | safe-write write |
| Insights | `Orchestration/Memory/Insights/<title>.md` | safe-write write |
| Ideas | `Orchestration/Memory/Ideas/<title>.md` | safe-write write |
| Updated Beliefs | `Resources/Avatar/Beliefs/<existing>.md` | safe-write edit |
| Action Items | `Orchestration/Backlog.md` | safe-write insert |
| Raw Notes | `Scratch/interview-<slug>-notes.md` | Write tool |

For memory files (Decisions, Insights, Ideas), use the templates from `/SessionReflect` — matching frontmatter schema with `title:`, `tags:`, `keywords:`, `collection:`, `created:`, `status:`.

### Step 3: Present reconciliation table

Show the user exactly what will be created or updated:

```
| Action | Title | Destination |
|--------|-------|-------------|
| Create | Defer hiring until Q3 | Memory/Imperatives/ |
| Create | Planning works better bottom-up | Memory/Insights/ |
| Create | Cross-team sync ritual | Memory/Ideas/ |
| Update | B5: Self-trust | Avatar/Beliefs/ |
| Append | Schedule Q2 kickoff | Backlog (task) |
| Append | Draft Q2 OKRs by Feb 20 | Backlog (task) |
| Write  | Session raw notes | Scratch/ |
```

Never auto-apply. The user confirms, adjusts individual items, or skips entries.

### Step 4: Execute writes

For each confirmed item:
- **Memory files**: Create via `safe-write write` with full frontmatter (see SessionReflect templates)
- **Avatar updates**: Update via `safe-write edit` — change body text, bump `updated:` date
- **Backlog items**: Append via `safe-write insert --before` the appropriate section marker
- **Raw notes**: Write to `Scratch/` via Write tool

### Step 5: Report

List everything that was created or updated, with full file paths.

---

## Project File Format

The persistent context file compiled by the Project workflow:

```
# About Me

<Full identity: name, background, current role, expertise, interests.
Expanded from Identity.md — not a summary, the full picture.>

## How I Communicate

<From Preferences.md: communication style, decision-making approach.
Plus voice-specific additions:>

- I prefer direct, concise exchanges — no filler or flattery
- Ask one question at a time and wait for my answer
- Push back when my answers are vague — ask for specifics
- Summarize before moving to the next topic
- If I say something that contradicts my stated beliefs, call it out

## What I'm Working On

### Goals
- G1: <goal> — <one-line context>
- G2: <goal> — <one-line context>
...

### Challenges
- C1: <challenge>
...

## How I Think

### Beliefs
- B1: <belief>
- B2: <belief>
...

### Strategies
- S1: <strategy>
...

### Mental Models
- MD1: <model>
...

## What Matters to Me

### Faultlines
<Civilization-level tensions that drive my mission>
- FL1: <faultline>
...

### Narratives
- N1: <how I describe what I do>

### Frames
- F1: <decision lens I apply>
...
```

---

## Interview Brief Format

The per-topic document compiled by the Prepare workflow:

```
# Interview: <Topic>

## Who You Are Talking To
<Only if no project file is uploaded.
Compact avatar: name, role, relevant goals and beliefs.
150-300 words. Plain text, no markup.
Omit this section entirely when the project file is active.>

## Background Context

<Summarized vault content about the topic.
Each source as a short subsection with a descriptive heading.
One SUBSTANTIVE paragraph per source (2-4 sentences, 20 content words minimum: what, why, current status).
Never list titles without summaries — the voice AI has no vault access.
Group related items into single entries rather than listing separately.
Plain text.>

## Interview Guide

### Goal
<What this session should accomplish — 2-3 sentences.>

### Key Questions
1. <Question with embedded context — include enough detail that the voice AI
   can discuss it without looking anything up>
2. <Question about a gap or contradiction found — cite the specific data>
3. <Question about a decision — state the options and tradeoffs inline>
...up to 8 questions

### Communication Style
- Ask one question at a time, wait for the answer
- Push back if answers are vague — ask for specifics
- Summarize each topic before moving to the next
- Capture ideas that emerge naturally — tag them for later

## Output Specification

When the interview concludes, produce a summary in this exact format:

### Decisions
- D1: <decision statement> — Rationale: <why> — Action: <next step>

### Insights
- I1: <factual finding or learning> — Origin: <what prompted this>

### Ideas
- IDEA1: <idea title> — <one-line description>

### Updated Beliefs
- <existing ID, e.g. B5>: <revised statement> — Changed from: <previous version>

### Action Items
- [ ] <task> — <owner or context>

### Raw Notes
<Anything else notable from the conversation>
```

---

## Constraints

- **PII gate**: Always ask about PII before compiling. Project files default to include (private upload). Interview briefs default to anonymize (shared context). When anonymizing: replace real name with "the user", strip team member names, generalize company names to role descriptions ("current employer" not the company name), omit location details beyond country
- Always use `safe-read` for AMBER files (Avatar, Journals, Backlog, Memory)
- Never include raw AMBER content verbatim — summarize and transform
- Strip all frontmatter, wikilinks, and tags from compiled output
- Keep total interview document under 2000 words
- Output file always goes to `Scratch/` (ephemeral, gitignored)
- The Process workflow never auto-writes — always present reconciliation table first
- If topic search finds nothing relevant, ask the user for specific files or wikilinks rather than producing an empty brief
- **Content density over coverage** — the voice AI has no vault access. Everything it needs to discuss must be in the brief with enough substance to hold a conversation. Never list titles without summaries. Never reference content that isn't included. If you can't fit substantive summaries within the word budget, include fewer items — not thinner summaries
- **Cap brief items at 15-20** — if the search finds more matches, curate the most relevant subset. Group related items (e.g., "5 imperatives about skills architecture") into a single entry with all the detail inline, rather than listing 5 separate titles
- Include avatar context filtered by topic relevance, not the full export
- Decision/Insight/Idea IDs (D1, I1, IDEA1) are session-local — distinct from avatar IDs (B1, FL3)
- The interview document is platform-agnostic — one format for Claude, ChatGPT, Gemini, or any voice AI
