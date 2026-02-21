---
name: RefineIdentity
description: "Refine, interview, and export the user's digital identity — goals, beliefs, challenges, strategies, and self-knowledge. USE WHEN refine identity, sharpen beliefs, interview identity, update goals, export identity, import identity, refine goals, challenge assumptions, identity interview, identity export."
argument-hint: "[interview | refine | export | import | section-name]"
---

# Avatar

Iterative self-knowledge interviews — with Claude, ChatGPT, Gemini, or any AI — that progressively sharpen the digital avatar into a high-fidelity identity model. Section structure inspired by [[TELOS]].

## Workflow Routing

| Workflow | Trigger | Section |
|----------|---------|---------|
| **Interview** | "avatar interview", "identity interview", `/Avatar interview` | [Interview](#interview-workflow) |
| **Refine** | "sharpen avatar", "refine beliefs", `/Avatar refine` | [Refine](#refine-workflow) |
| **Export** | "export avatar", "avatar for chatgpt", `/Avatar export` | [Export](#export-workflow) |
| **Import** | "import avatar", "chatgpt said...", `/Avatar import` | [Import](#import-workflow) |
| **Section** | `/Avatar beliefs`, `/Avatar faultlines`, section name as argument | [Section Deep-Dive](#section-deep-dive) |

## Avatar Sections

Each section is a directory under `Resources/Avatar/` with one file per item plus a folder note.

| Section | Directory | Prefix | Content |
|---------|-----------|--------|---------|
| Mission | `Goals/` | M# | Core life missions — ultimate purposes |
| Goals | `Goals/` | G# | Specific objectives supporting missions |
| Faultlines | `Faultlines/` | FL# | Civilization-level tensions driving mission and values |
| Challenges | `Challenges/` | C# | Personal obstacles and operational constraints |
| Strategies | `Strategies/` | S# | Approaches to problems and challenges |
| Beliefs | `Beliefs/` | B# | Core convictions guiding decisions |
| Models | `Models/` | MD# | Mental frameworks for understanding |
| Narratives | `Narratives/` | N# | How you describe yourself to the world |
| Frames | `Frames/` | F# | Decision lenses applied contextually |

---

## Interview Workflow

### Step 1: Read existing Avatar files

Read all files from `Resources/Avatar/` via `safe-read` to understand current state. Note gaps, incomplete sections, and items marked as draft.

### Step 2: Determine scope

Ask the user:

| Scope | Duration | Description |
|-------|----------|-------------|
| **Full** | ~60 min | All 9 sections from scratch or major revision |
| **Update** | ~20 min | Only sections that changed or feel incomplete |
| **Single** | ~10 min | Deep dive into one section |

### Step 3: Walk through sections

Process each section in this order: Mission → Goals → Faultlines → Challenges → Strategies → Beliefs → Models → Narratives → Frames.

For each section:

1. **Read back** what currently exists (summarize, don't recite)
2. **Ask 2-3 open questions** to draw out thinking
3. **Probe** with follow-ups based on answers (contradictions, unstated assumptions, connections to other sections)
4. **Synthesize** into structured format with item IDs and cross-references
5. **Confirm** with the user before writing

#### Probing Questions by Section

**Mission** — What would you work on if money were no object? What are you uniquely positioned to do? What's the difference between your mission and your job?

**Goals** — Which objective would you drop if forced to cut one? What's the difference between your stated goals and where you actually spend time? Which goal has the longest time horizon?

**Faultlines** — What civilization-level problems keep you up at night? Which ones does your work directly address? If you could move the needle on one global issue, which would cascade into the others? What's broken at scale that you feel personally responsible for fixing?

**Challenges** — What's the constraint you most wish you could just remove? Which challenges are permanent (manage) vs. temporary (solve)? What's the challenge you're avoiding because addressing it requires giving something up?

**Beliefs** — What do you believe that most people disagree with? What belief changed most in the last 5 years? What belief do you suspect might be wrong but can't let go of?

**Strategies** — When stuck, what's your first move? What's your relationship with procrastination? How do you decide when to push through vs. when to pivot?

**Models** — What mental model changed how you see the world? How do you think about tradeoffs? What framework do you reach for under pressure?

**Narratives** — In one sentence, what do you do? What's the gap between how others see you and how you see yourself? What story do you tell that reliably lands?

**Frames** — When facing a decision, what's the first lens you apply? Which frame do you over-rely on? Is there a frame you know you should use but resist?

### Step 4: Write Avatar files

Each item becomes an individual file in its section directory. Filename = descriptive title (no prefix). Item ID lives in the `aliases:` frontmatter field.

```yaml
---
title: Descriptive title of the item
aliases:
  - B1
tags:
keywords:
  - "[[Avatar]]"
  - "[[Beliefs]]"
description:
collection: "[[Beliefs]]"
icon:
image:
cssclasses:
created: YYYY-MM-DD
updated: YYYY-MM-DD
sources:
  - "[[Literature note with source.links]]"
related:
  - "[[Other note]]"
root:
  - "[[Parent item if causal derivation]]"
tlp: amber
---

Body text. Use full note names in wikilinks (e.g., [[Information overload]], not [[C4]]). Aliases are for token-efficient AI consumption only.
```

- `related:` = lateral association (this connects to)
- `root:` = causal derivation (this exists because of)
- `collection:` = parent section wikilink

Item IDs are **stable** — never renumber across sessions. Add new items at the end.

### Step 5: Verify

Run `/LoadAvatar` to confirm all self-knowledge sections load correctly via `safe-read`.

---

## Refine Workflow

Iterative sharpening of existing avatar content. Use after interviews (with any AI), when the user's thinking has evolved, or when public profiles have been updated.

### Step 1: Read current state

Read all Avatar files via `safe-read`. Build a mental model of the whole identity.

Check the `sources:` frontmatter field on Avatar files — it contains wikilinks to Literature notes in `Resources/Profiles/` (or `Resources/Articles/`) that document the original URLs and external data used to populate the content. Follow the wikilinks, read the Literature notes' `source.links` URLs, and re-fetch to catch upstream changes.

### Step 2: Challenge

For each item in scope, apply these lenses:

| Lens | Question |
|------|----------|
| **Precision** | Is this specific enough to act on, or is it a platitude? |
| **Consistency** | Does this contradict anything else in the avatar? |
| **Currency** | Is this still true? Has it changed since `updated:` date? |
| **Completeness** | What's implied but not stated? What's the shadow of this belief? |
| **Connections** | Should this link to other items via `root:` or `related:`? |

### Step 3: Propose changes

Present proposed edits as diffs — what currently exists vs. what would change. Group by:
- **Sharpen**: Same idea, more precise language
- **Evolve**: The idea itself has shifted
- **Merge**: Two items are really one
- **Split**: One item is really two
- **Retire**: No longer true or relevant

### Step 4: Apply confirmed changes

Update files. Bump `updated:` date. If merging or splitting, keep the lower-numbered ID and retire the other (set alias to retired ID, add note in body).

---

## Export Workflow

Produce a portable document for use with other AIs (ChatGPT, Gemini, etc.) or as a personal reference.

### Step 1: Read all Avatar files

Read all files from `Resources/Avatar/` via `safe-read`.

### Step 2: Produce combined document

Output a single document with all sections. Strip YAML frontmatter. Use `## Section` headings. Preserve item IDs as inline markers (e.g., `**B1**:`). Preserve cross-references as plain text (no wikilink syntax).

### Step 3: Append interview prompt

After the avatar content, append:

```
---

## Interview Instructions

You have just read my digital avatar — a structured self-knowledge document.
Your job: challenge, sharpen, and extend it.

For each section, tell me:
1. What rings true and specific (keep)
2. What sounds like a platitude or rationalization (sharpen or cut)
3. What's conspicuously absent (add)
4. What contradicts something else in the document (resolve)

Then interview me on the weakest section — ask 3-5 probing questions.
End with a revised version of that section incorporating your feedback.

Output format: use the same ## Section / **ID**: Item structure.
```

This creates a round-trip: export → external interview → import results.

---

## Import Workflow

Reconcile interview results from another AI back into Avatar files.

### Step 1: Receive external input

The user pastes or provides output from another AI's interview. This could be:
- A full revised avatar document
- Feedback on specific sections
- New items proposed by the external AI
- Contradictions or gaps identified

### Step 2: Diff against current state

Read current Avatar files via `safe-read`. Compare with external input:
- **Agreements**: External AI confirmed existing items → no change needed
- **Sharpened language**: Better phrasing for same idea → propose update
- **New items**: External AI surfaced something missing → propose addition with next available ID
- **Contradictions**: External AI disagrees → surface to user for resolution
- **Retirements**: External AI thinks something is wrong → surface to user

### Step 3: Present reconciliation

Show a clear table of proposed changes, grouped by type. Never auto-apply — the user decides what to keep.

### Step 4: Apply confirmed changes

Write new files, update existing ones. Bump `updated:` dates. Add `related:` links where the external AI identified connections.

---

## Section Deep-Dive

When invoked with a section name (`/Avatar beliefs`), run only that section through the Refine workflow: read existing items, challenge each one, propose changes, apply confirmed edits.

---

## Constraints

- Always use `safe-read` for AMBER Avatar files
- Never output AMBER content verbatim — synthesize and transform
- Keep item IDs stable across sessions (append, don't renumber)
- Preserve content the user hasn't explicitly asked to change
- Use full note names in wikilinks within files (e.g., `[[Information overload]]`, not `[[C4]]`)
- Aliases (B1, FL3, etc.) exist for token-efficient AI reference only
- Mark incomplete sections with `status: draft` in frontmatter
- The interview adapts to answers — don't rigidly follow the question bank
- This skill produces Avatar files, not Memory files (no imperatives/insights)
- Each item is a separate file — filename is the descriptive title, no ID prefix
