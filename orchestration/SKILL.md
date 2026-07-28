---
name: orchestration
description: Route delegation, model selection, subagents, workflows, parallel work, and multi-slice execution. Use whenever the user or another skill requests delegation, independent agents, model routing, or a dispatch policy.
---

# Orchestration

Use this skill before dispatching work. A route proposes work; it never grants dispatch permission.

## Terms

- **Host:** the current runtime: Claude Code, Codex, Pi, or T3.
- **Provider:** the model provider, distinct from the host and executor.
- **Executor:** a native host agent or a spawned CLI transport such as `codex exec`, `pi -p`, or `claude -p`.
- **Route:** role + provider + model + effort + executor + isolation + verification + fallback + subscription allowance/burn.

Provider independence and executor independence are separate properties. Two executors using one provider are not provider-independent.

## Route

1. Classify each slice: investigate, plan, implement, review, or integrate. Load [`ROUTING.md`](ROUTING.md).
2. Detect the current host and its advertised callable capabilities. Check the selected provider, model, effort, and executor are available. Mark unknown when they cannot be checked; never infer reachability from an executable name or silently substitute.
3. Load every adapter the proposed mixed route uses: [`CLAUDE.md`](CLAUDE.md), [`CODEX.md`](CODEX.md), [`PI.md`](PI.md), and/or [`T3.md`](T3.md).
4. Record the dirty-worktree baseline and check planned files for overlap. Stop on overlapping user changes unless those exact changes are in scope.
5. Show this table and wait for approval:

   | Slice | Role | Provider | Model / effort | Executor | Why | Isolation | Verification | Fallback | Subscription allowance / burn |
   |---|---|---|---|---|---|---|---|---|---|

   Include independent-review rows when required. Approval covers one attempt and its listed execution-failure fallback.
6. Dispatch only approved cards. Inspect every implementation diff, run in-scope verification, and accept integration yourself.

Complete only when every approved slice reports, every changed diff is inspected, verification is recorded, and unresolved risks are surfaced.

## Dispatch card

Include these fields in every prompt:

- Goal and role; approved route; current baseline
- Scope and explicit avoid list
- Acceptance and stop criteria; verification commands
- Report: files changed, verification, unresolved questions

Tell workers not to commit or re-orchestrate. The orchestrator alone owns integration, diff inspection, verification, and final acceptance.

## Concurrency and failure

- Parallelize only independent slices after checking files, migrations, public contracts, and verification paths.
- Concurrent writers require separate worktrees. Native agents sharing a filesystem may run read-only in parallel.
- Preserve dirty worktrees. Never reset, stash, revert, or silently merge user changes.
- Stop for ambiguous acceptance, product choices, permissions, scope expansion, merge conflicts, user-change overlap, or a card stop condition. Propose the next action; do not improvise.
- On execution failure, use the approved fallback once. On a quality miss, propose a reroute and wait for approval.

## Adapters

Load the adapter for each selected executor or native-host route:

- [`CLAUDE.md`](CLAUDE.md): Claude native agents and `claude -p`
- [`CODEX.md`](CODEX.md): Codex native subagents and `codex exec`
- [`PI.md`](PI.md): Pi native work and `pi -p`
- [`T3.md`](T3.md): T3 native collaboration

Load [`CALIBRATION.md`](CALIBRATION.md) only when the user asks to benchmark,
revalidate, or change route evidence.
