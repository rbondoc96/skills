
# Review triage and the merge-blocker bar

Decide which review findings must be fixed before merge and which may be deferred. This is the single source of truth for triage judgment, not transport or edits. Read it before classifying feedback in any workflow.

The triage pass is read-only. No edit, commit, push, reply, resolution, issue, or merge happens until the user approves the reported dispositions.

## Triage each finding

1. **Prove it is real.** Reproduce or trace the reported behavior far enough to know whether it is reachable through a supported path. Invoke `$diagnose` when reproduction is disputed or expensive.
2. **State the mechanics.** Concrete cause, affected consumers, user or operator impact, and failure mode.
3. **Locate the owner.** Identify the earliest branch or commit that introduces or owns the behavior.
4. **Load the repository's stance.** Read the repository's `AGENTS.md`, plus `CONTEXT.md` and relevant ADRs when present. Supported operating modes, rollback and migration policy, and deployment stage are repository facts. A workflow the repository does not support cannot produce a blocker.
5. **Apply the blocker bar** below and assign exactly one disposition.

## Dispositions

- `address`: the PR introduces a reachable problem that meets the bar and must be correct when merged on its own.
- `defer to follow-up`: the concern is real but sits outside this change's contract and does not make it unsafe. Propose a focused scope and a revisit condition. Create nothing without approval.
- `reply`: current code disproves the claim, or an existing guard already handles it. Carry the reproduction or call path that proves it.
- `clarify`: the report is missing information needed to judge it.
- `no action`: understood, accepted, and safe as written.

## Blocker bar

A finding blocks when it is reachable through a supported path and causes one or more of:

- silent corruption, data loss, misleading success, or incomplete durable state;
- a security, privacy, authorization, or isolation failure;
- a forward migration or full-reset failure;
- a concurrency, atomicity, retry, or recovery defect under plausible load;
- an irreversible external action;
- a broken current user flow, public contract, or required check;
- a foundational schema, storage, or serialized-contract defect that later work would make materially harder to change.

A finding does not block merely because:

- the reviewer labeled it P1 or P2;
- fixing it later may require work;
- it concerns an unsupported operating mode or threat actor;
- it proposes defense in depth without a demonstrated failure;
- it is cleanup, style, naming, or optional refactoring;
- it raises a theoretical performance concern without a plausible supported workload or resource limit.

Reviewer severity is evidence, not the decision. Silent failures outrank visible recoverable ones, because the cost of discovering and repairing them after merge is higher. A cheap fix is still optional when the finding misses the bar.

Read [`CLOSURE_MODE.md`](CLOSURE_MODE.md) when the PR is heading to merge, review rounds are piling up, or the user says to draw the line.

## Report before any mutation

Present the complete triage first. One compact block per finding:

```text
Thread:
Disposition: address | defer to follow-up | reply | clarify | no action
Cause and evidence:
Affected consumers and impact:
Why this blocks or remains safe:
Proposed fix or response:
Focused regression coverage:
```

For a fix, propose the smallest robust change and the exact behavior its regression test must prove. For a deferral, name the proposed scope and the condition that should cause a revisit. For a rejected finding, include the reproduction or call path that disproves it.

Ask for approval once, covering the whole reported set. Do not make the user approve the same listed change twice.

## Completion

Complete when every finding carries an evidence-backed disposition, the report states which findings meet the bar, deferred work has a named scope and revisit condition, and nothing has been written locally or remotely.
