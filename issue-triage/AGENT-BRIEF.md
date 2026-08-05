# Writing Agent Briefs

An agent brief is a comment posted when an issue moves to `ready-for-agent`. It's the authoritative specification the AFK agent works from — the issue body and discussion are context, the brief is the contract.

This file covers **how to write a good one**. If the project supplies an agent-brief template, take the exact shape from there; otherwise use the structure below.

## Principles

### Durability over precision

The issue may sit in `ready-for-agent` for weeks while the codebase moves. Write so it survives that.

- **Do** describe interfaces, types, and behavioral contracts.
- **Do** name the specific types, function signatures, or config shapes to look for.
- **Don't** reference file paths or line numbers — they go stale.
- **Don't** assume today's implementation structure holds.

### Behavioral, not procedural

Describe **what** the system should do, not **how** to build it. The agent explores fresh and makes its own implementation calls.

- **Good:** "The `SkillConfig` type should accept an optional `schedule` field of type `CronExpression`."
- **Bad:** "Open `src/types/skill.ts` and add a schedule field on line 42."

### Complete acceptance criteria

The agent needs to know when it's done. Every criterion independently verifiable.

- **Good:** "Descriptions over 1024 chars are truncated at the last word boundary."
- **Bad:** "Truncation should work correctly."

Don't write criteria for anything the type system already guarantees.

### Explicit scope boundaries

State what's out of scope. This is what stops an agent gold-plating or wandering into adjacent features.

## A good brief

```markdown
**Summary:** Skill description truncation drops mid-word, producing broken output

**Current behavior:**
When a skill description exceeds 1024 characters it's truncated at exactly 1024,
regardless of word boundaries, producing descriptions that end mid-word
(e.g. "Use when the user wants to confi").

**Desired behavior:**
Truncation breaks at the last word boundary before 1024 characters and appends
"..." to signal truncation.

**Key interfaces:**

- The `SkillMetadata` type's `description` field — no type change, but the logic
  that populates it must respect word boundaries.
- Any function reading SKILL.md frontmatter to extract the description.

**Acceptance criteria:**

- [ ] Descriptions under 1024 chars are unchanged
- [ ] Longer ones are truncated at the last word boundary before 1024 chars
- [ ] Truncated descriptions end with "..."
- [ ] Total length including "..." never exceeds 1024 chars

**Out of scope:**

- Changing the 1024 char limit itself
- Multi-line description support
```

## A bad brief

```markdown
**Summary:** Fix the triage bug

**What to do:**
The triage thing is broken. Look at the main file and fix it.
The function around line 150 has the issue.

**Files to change:**

- src/triage/handler.ts (line 150)
- src/types.ts (line 42)
```

Vague summary, no current-vs-desired split, file paths and line numbers that will go stale, no acceptance criteria, no scope boundaries.
