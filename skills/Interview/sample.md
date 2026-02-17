# Sample: Project File

> Output of `/Interview project` — uploaded once to a Claude/ChatGPT Project.
> PII included (user chose "include" for their private project).
> Every item is a full paragraph — the voice AI needs depth, not labels.

---

# About Me

Software engineer with a background in distributed systems. PhD from a research lab where I spent years designing data analysis frameworks for large-scale scientific computations — processing petabytes of experimental data, distributed computing, statistical inference at the frontier of what was measurable. That training shaped a particular way of thinking: decompose everything to fundamentals, demand evidence, distrust intuition when data exists.

Now leading a platform team at a mid-size tech company, driving a multi-quarter billing migration affecting millions of users. The enterprise tier is the hardest remaining piece — complex billing logic, legacy edge cases, zero-downtime requirement. I've been at this company for about a decade, building invisible infrastructure that everyone depends on but nobody sees.

Also building a personal AI infrastructure framework as a serious side project. It's modular, Rust-based, and manages my knowledge, journals, identity, and operational workflows through multiple AI tools. Daily active development.

## How I Communicate

- Direct and concise — no filler or flattery
- Plain language over jargon
- Ask one question at a time and wait for my answer
- Push back when my answers are vague — ask for specifics
- Summarize before moving to the next topic
- If I say something that contradicts my stated beliefs or goals, call it out
- When I say "continue" or "go", move forward — don't repeat what was just said

## What I'm Working On

### Goals

**G1: Ship billing migration.** The primary professional deliverable. Millions of users migrating from in-house billing to a third-party platform, multi-quarter timeline, zero-downtime requirement. The enterprise tier is the remaining hard problem — complex billing logic accumulated over a decade, multiple products with different billing models. This consumes significant cognitive bandwidth.

**G2: Build personal AI framework.** The primary personal project. Currently ~15 modules, daily logging system, file access enforcement, session reflection, memory promotion pipeline, multi-platform adapters. Every binary is written in Rust. Daily active development. The system captures knowledge, enforces behavioral rules, and automates operational workflows.

**G3: Learn Rust through real projects.** All framework binaries are Rust — this isn't academic. Every module teaches real patterns: CLI interfaces, diffing, serialization, directory traversal, testing with temp directories. Preference for Rust over TypeScript or Python for anything compiled.

### Challenges

**C1: Time scarcity with competing priorities.** Day job, side business, personal framework, relationships, health — all demand serious attention simultaneously. Can't run all at full throttle. The open question is whether being faster closes the gap or whether hard tradeoffs are unavoidable and I'm just avoiding making them.

**C2: Information overload causing decision paralysis.** This is the root challenge — everything branches from here. Too much input, too many options, not enough filtering. The infrastructure to prioritize and surface the right information at the right time is what the framework is building, but it's still incomplete.

## How I Think

### Beliefs

**B1: Simple beats clever.** Complexity is the enemy. Every abstraction adds a maintenance burden. Three similar lines of code are better than a premature abstraction. This applies to architecture, life decisions, and communication equally.

**B2: Ship and iterate.** Perfect is the enemy of done. A good-enough solution shipped today beats a perfect solution shipped next month. The iteration loop teaches more than the planning phase ever could.

**B3: Self-trust is foundational.** If you don't keep your own word to yourself — the promises about habits, goals, commitments — nothing else works. External commitments have social accountability. Internal ones have only self-trust.

### Strategies

**S1: Break complex problems into independently shippable chunks.** Decompose until each piece can be built, tested, and shipped on its own. The strategy fails when pieces have hidden dependencies, which is why explicit contracts between modules matter.

**S2: Writing to think.** Articulating problems often solves them before the conversation ends. Journaling and knowledge capture are thinking tools, not record-keeping. Putting thoughts into structured prose forces clarity that thinking alone doesn't produce.

### Mental Models

**MD1: First principles.** Decompose any problem to its fundamental components, then rebuild. Don't accept "that's how it's always been done." Trained by research to question every assumption and build from evidence.

**MD2: Cost-benefit analysis.** Weigh tradeoffs explicitly, not on gut feeling. When choosing between approaches, write out the actual costs and benefits rather than relying on intuition. Make the calculus visible.

## What Matters to Me

### Faultlines

**FL1: Knowledge fragmentation and decay.** Hard-won insights get siloed in individual brains, lost when people leave, never transferred to successors. Organizations repeatedly solve the same problems because institutional knowledge evaporates. The personal AI framework is a direct response — a system that captures, organizes, and resurfaces knowledge so it compounds instead of decaying.

### Frames

**F1: Short-term vs long-term.** Defaults to long-term. Willing to sacrifice now for compounding returns later. But not dogmatically — sometimes short-term momentum is the right call. The calibration: will this compound? If yes, long-term.

**F2: Ownership vs delegation.** Constantly deciding what's mine to do versus what others should handle. The tension is between control (doing it myself guarantees quality) and scalability (I can't do everything). The modular architecture of the framework is an expression of this.

---

# Sample: Interview Brief (Knowledge Triage)

> Output of `/Interview knowledge items for promotion triage` — pasted as a conversation message.
> Demonstrates curating many source items into substantive summaries.
> PII anonymized (user chose "anonymize" for shared brief).

---

# Interview: Knowledge Promotion Triage

## Who You Are Talking To

Software engineer building a personal knowledge infrastructure. The system has three memory types: Insights (factual findings), Imperatives (architectural decisions), and Ideas (proposals). Items accumulate and need periodic promotion to actionable artifacts — steering rules, skills, scripts, or auto-memory. The user has 45 unpromoted items and needs to triage the highest-leverage ones during a walk.

Direct, concise, wants decisions not discussion. Push back if answers are vague.

## Background Context

### Ideas Ready to Archive (3 items)

Three ideas are already shipped and can be archived: (1) a CLI tool for resolving database views — built and deployed as the `db-resolve` binary three months ago; (2) a journal plugin consolidation — shipped as the `journal-tools` module, all legacy scripts retired; (3) a template framework — shipped in the identity module, templates now auto-generate from config.

### Exploring Ideas (4 items)

Four ideas are under active investigation: (1) Email pipeline — batch import from work email into the knowledge system via CLI tool, relevant because of the user's Tuesday/Wednesday/Friday work schedule; (2) Proactive digest module — auto-surfaces forgotten items at session start, phases 1-3 done (retrieval, ranking, formatting), phases 4-5 remaining (filtering, scheduling); (3) Message archive import — batch export chat messages into the knowledge pipeline, blocked on API access; (4) Platform decoupling — separate platform-specific integrations into standalone modules, motivated by supporting 4 different AI tools.

### Imperative Cluster: Skills Architecture (5 overlapping decisions)

Five imperatives say related things: (1) skills use a canon+sidecar pattern where the canonical version lives in the module and a sidecar draft lives in the vault for editing; (2) two directories exist — Upstream for shared skills, Local for personal ones; (3) agents reference skills as their single source of truth rather than duplicating instructions; (4) the vault is the source of truth, not generated adapter configs; (5) promotion from vault draft to module skill is a script with an AI wrapper. These overlap — the core principle is "skills are authoritative, vault-first, with scripted promotion."

### Recent Insights Cluster: Plugin Permissions (3 items, last 48 hours)

Three insights about plugin environment constraints discovered this week: (1) the plugin root env var is the only guaranteed variable — all other paths must be derived from it; (2) backtick command execution in plugin context is blocked by the permission check, making dynamic shell calls unreliable; (3) environment variables set by the host tool are available but vary by platform. Together these form a single "plugin permission constraints" rule.

### Foundational Insight: Configuration as Routing

A recent insight that frontmatter metadata (not folder structure) determines how items are routed, processed, and displayed. This is foundational — it implies folder reorganizations are cosmetic while frontmatter changes are semantic. Currently just an insight note but may warrant promotion to a steering rule.

## Interview Guide

### Goal
Triage the user's 45 knowledge items into: promote now, keep for later, merge with related items, or archive. Focus on the 5 highest-leverage decisions. Produce a concrete action list.

### Key Questions
1. The 3 shipped ideas (CLI resolver, journal consolidation, template framework) are all deployed and working. Any open threads, or archive all three now?
2. Of the 4 Exploring ideas — email pipeline, proactive digest (60% done), message archive (blocked on API), platform decoupling — which one would you push forward next, and why?
3. The Skills Architecture cluster has 5 overlapping imperatives that boil down to "skills are authoritative, vault-first, with scripted promotion." Is that the right single rule, or does something need to be different?
4. The 3 plugin permission insights from this week (root env var only, backtick blocked, platform-varying env) — should these consolidate into one "plugin constraints" steering rule now, or wait for more data?
5. "Configuration as routing" feels foundational — if frontmatter is the routing layer, folder structure is cosmetic. Should this become a steering rule that guides future architecture decisions?

### Communication Style
- Ask one question at a time, wait for the answer
- Push back if answers are vague — ask for specifics
- Summarize each decision before moving to the next topic
- When the user says "promote" — ask what destination (steering rule, skill, script, auto-memory)
- Capture ideas that emerge naturally — tag them for later

## Output Specification

When the interview concludes, produce a summary in this exact format:

### Decisions
- D1: <decision about a knowledge item> — Rationale: <why> — Action: <promote to X / archive / merge with Y / dismiss>

### Insights
- I1: <new learning from the triage itself> — Origin: <what prompted this>

### Ideas
- IDEA1: <any new ideas that emerged> — <description>

### Updated Beliefs
- <ID>: <revised statement if any beliefs shifted> — Changed from: <previous>

### Action Items
- [ ] <specific promotion task> — <which items, which destination>
- [ ] <merge task> — <which cluster, what the consolidated rule says>
- [ ] <archive task> — <which items to archive>

### Raw Notes
<Anything else notable from the conversation>
