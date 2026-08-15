---
name: issue-triage
description: Move issues through a triage state machine, resolving all tracker specifics from the project's own agent docs. Use when the user wants to triage issues, review incoming bugs or feature requests, decide what needs their attention, or prepare an issue for an AFK agent.
disable-model-invocation: true
---

# Issue Triage

Move issues on the project's tracker through a small state machine.

This skill owns the **workflow only**. Every project-specific detail — tracker, label strings, disclaimer format, issue and comment templates — lives in the project's own docs. Never hardcode them here.

## Resolve the project's conventions first

Before touching the tracker, find these in the project's agent docs — usually `AGENTS.md`, `CLAUDE.md`, or a file they point to:

- **Tracker and CLI** — which tracker holds issues, and the command to read and write them.
- **Label mapping** — the tracker's label strings for each role below.
- **Disclaimer** — any AI authorship line required on agent-authored content.
- **Templates** — the issue and comment shapes to write into.

If you can't find them, ask the maintainer. Don't invent label names or issue formats.

## Roles

Five state roles:

- `needs-triage` — maintainer needs to evaluate
- `needs-info` — waiting on the reporter for more information
- `ready-for-agent` — fully specified, ready for an AFK agent
- `ready-for-human` — needs human implementation
- `wontfix` — will not be actioned

These are canonical names; the tracker's actual labels come from the project's mapping. Some trackers express a role as a state rather than a label — follow whatever the mapping says.

Issue **type** (bug, feature, improvement, task) is a separate axis owned by the project. Apply it from the project's taxonomy, not from this list.

Every triaged issue carries exactly one state role. If two conflict, flag it and ask before doing anything else.

Transitions: an untriaged issue goes to `needs-triage` first, then to `needs-info`, `ready-for-agent`, `ready-for-human`, or `wontfix`. `needs-info` returns to `needs-triage` once the reporter replies. The maintainer can override at any point — flag anything unusual and ask first.

## Invocation

The maintainer describes what they want in natural language. Interpret and act:

- "show me anything that needs my attention"
- "let's look at issue 42"
- "move 42 to ready-for-agent"
- "what's ready for agents to pick up?"

## Show what needs attention

Query the tracker and present three buckets, oldest first:

1. **Untriaged** — no state role yet.
2. **`needs-triage`** — evaluation in progress.
3. **`needs-info` with reporter activity since the last triage notes** — needs re-evaluation.

Show counts and a one-line summary per issue. Let the maintainer pick.

## Triage a specific issue

1. **Gather context.** Read the issue in full — body, comments, labels, reporter, dates. Parse prior triage notes so you don't re-ask resolved questions. Explore the codebase using the project's domain glossary, respecting any architectural decision records in the area.

2. **Recommend.** Give your type and state recommendation with reasoning, plus a short codebase summary relevant to the issue. Wait for direction.

3. **Reproduce (bugs only).** Before any grilling, attempt reproduction: follow the reporter's steps, trace the code, run tests. Report what happened — a confirmed repro with its code path, a failed repro, or insufficient detail. A confirmed repro makes a much stronger brief; insufficient detail is a strong `needs-info` signal.

4. **Grill (if needed).** If the issue needs fleshing out, interrogate it before writing anything down: what's actually being asked for, what's assumed, what breaks. If the project has a dedicated grilling skill, use it.

5. **Apply the outcome:**
   - `ready-for-agent` — post an agent brief comment. See [AGENT-BRIEF.md](AGENT-BRIEF.md) for how to write one; take the shape from the project's agent-brief template if it has one.
   - `ready-for-human` — same shape, plus why it can't be delegated (judgment calls, external access, design decisions, manual testing).
   - `needs-info` — post triage notes. Capture everything already established so the work isn't lost, and make every question specific and actionable — never "please provide more info".
   - `wontfix` — post a brief, polite explanation, then close using whatever the project's mapping specifies.
   - `needs-triage` — apply the role, with a comment only if there's partial progress.

## Quick state override

When the maintainer says "move 42 to ready-for-agent", trust them and apply it directly. Confirm what you're about to do — role changes, comments, closes — then act. Skip grilling. If moving to `ready-for-agent` without a grilling session, ask whether they want an agent brief.

## Resuming

If prior triage notes exist, read them, check whether the reporter answered any outstanding questions, and present an updated picture before continuing. Don't re-ask resolved questions.
