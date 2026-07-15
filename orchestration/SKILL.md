---
name: orchestration
description: Route delegation, model selection, subagents, workflows, parallel work, and multi-slice execution. Use when another skill needs a dispatch policy.
---

# Orchestration

A **route** is one role's model, harness, isolation, verification, fallback, and cost tier.

Use this skill before dispatching work. A route is a proposal, never permission to dispatch.

## Route

1. Classify each slice and role: investigate, plan, implement, review, or integrate. Load [`ROUTING.md`](ROUTING.md).
2. Check that every selected model is reachable. If not, revise the route; never silently substitute.
3. Load one harness adapter: [`CLAUDE.md`](CLAUDE.md), [`CODEX.md`](CODEX.md), or [`PI.md`](PI.md).
4. Show the user this Markdown table and wait for approval:

   | Slice | Role | Model | Harness | Why | Isolation | Verification | Fallback | Cost |
   |---|---|---|---|---|---|---|---|---|

   Include an independent-review row whenever the route requires one.
5. Dispatch only the approved plan. The approval covers one attempt plus one fallback on execution failure.
6. Inspect every implementation diff and rerun its in-scope checks. Report each slice's route, files, verification, and unresolved risks.

## Dispatch card

Every dispatched prompt contains:

- Goal and role
- Approved route
- Scope, files to avoid, and current-worktree baseline
- Acceptance criteria and stop conditions
- Verification commands
- Required report: files changed, verification, unresolved questions

## Rules

- Route each role independently.
- Parallelize only independent slices. The orchestrator may change parallelism without new approval after checking overlap in files, migrations, public contracts, and verification paths. Concurrent implementers use separate worktrees.
- Stop and surface ambiguous acceptance criteria, required product choices, scope expansion, permissions, conflicting user changes, merge conflicts, and slice-card stop conditions. Propose a fix; do not improvise.
- Record a dirty worktree. Never reset, stash, or revert user changes. Stop on overlap with planned files.
- Do not let dispatched agents commit unless the user explicitly authorized it. Pause after each accepted slice otherwise.
- On execution failure, run the approved fallback once. On a quality miss, report a proposed reroute and wait for approval.
- The orchestrator always performs diff inspection and verification. Add independent review when the user requests it or the route is high risk. Never dispatch a `fable-5` review when the orchestrating session is already `fable-5` — double cost, no independent perspective. Use `opus-4.8` or a Pi review route instead.

## Adapters

- Read [`CLAUDE.md`](CLAUDE.md) for Agent and Workflow dispatch.
- Read [`CODEX.md`](CODEX.md) for Codex CLI dispatch.
- Read [`PI.md`](PI.md) for Pi CLI dispatch.
