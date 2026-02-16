# Sample: Project File

> Output of `/Interview project` — uploaded once to a Claude/ChatGPT Project.
> PII included (user chose "include" for their private project).

---

# About Me

Software engineer with a background in distributed systems. Currently leading a platform team at a mid-size tech company, driving a multi-quarter billing migration affecting millions of users. Also building a personal AI infrastructure framework as a side project.

Expertise: backend systems, payment integrations, zero-downtime migrations, team scaling. Interests: fintech, open-source tooling.

## How I Communicate

- Direct and concise — no filler or flattery
- Plain language over jargon
- Ask one question at a time and wait for my answer
- Push back when my answers are vague — ask for specifics
- Summarize before moving to the next topic
- If I say something that contradicts my stated beliefs or goals, call it out

## What I'm Working On

### Goals
- G1: Ship billing migration at current employer
- G2: Build personal AI framework (daily logging, plugin system, session reflection)
- G3: Learn Rust through real projects

### Challenges
- C1: Time scarcity — multiple commitments competing for attention
- C2: Information overload — too much noise, not enough signal

## How I Think

### Beliefs
- B1: Simple beats clever — complexity is the enemy
- B2: Ship and iterate — perfect is the enemy of done
- B3: Self-trust is foundational

### Strategies
- S1: Break complex problems into independently shippable pieces
- S2: Writing to think — articulating problems often solves them

### Mental Models
- MD1: First principles — decompose to fundamentals, rebuild
- MD2: Cost-benefit analysis — weigh tradeoffs explicitly

## What Matters to Me

### Faultlines
- FL1: Knowledge fragmentation — hard-won insights get siloed and lost

### Frames
- F1: Short-term vs long-term — defaults to long-term
- F2: Ownership vs delegation — constantly deciding what to keep vs hand off

---

# Sample: Interview Brief

> Output of `/Interview billing migration risks` — pasted as a conversation message.
> PII anonymized (user chose "anonymize" for shared brief).

---

# Interview: Billing Migration Risks

## Background Context

### Migration Status
Core billing flows live on the new platform for new signups. Legacy user migration phased by plan tier, with enterprise accounts scheduled for Q2. Team has capacity constraints: 4 backend engineers, one on leave returning next month.

### Previous Retrospective (Imperative)
Decision from last quarter: migration planning should be time-boxed to one week, not spread across a month. Extended planning creates analysis paralysis.

### Team Capacity Insight
The team consistently overcommits by 20-30% when estimating quarterly scope. Actual throughput is ~70% of planned story points across three consecutive quarters.

## Interview Guide

### Goal
Identify the top 3 risks to the Q2 migration phase and decide on mitigation strategies for each. Output should be concrete enough to present to stakeholders.

### Key Questions
1. Given the team delivers 70% of planned scope, what happens if you plan for 70% from the start — what would you cut?
2. The enterprise tier is the most complex migration. What's the one thing that could derail it?
3. If a critical team member is unavailable mid-migration, what's the fallback?
4. Are there dependencies on other teams that could block progress?
5. What's the rollback strategy if the enterprise migration hits a showstopper?

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
