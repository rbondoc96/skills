---
name: codex-implementation
description: Delegate a bounded, clear-spec implementation task to gpt-5.5 via the Codex CLI (`codex exec`). Use when routing bulk/mechanical work per the model table in CLAUDE.md — spec-slice implementation, migrations, mechanical refactors — where the spec/card is explicit enough that taste is not the bottleneck. Not for UI/copy/API design (Taste >= 7 work) or ambiguous architecture.
---

# Codex Implementation

Run gpt-5.5 as a non-interactive implementer. Codex starts **cold** — no conversation
context, no memory of the session. Everything it needs must be in the prompt or in files
it's told to read.

## Quick start

```sh
# 1. Write the prompt to a file (heredocs get unwieldy past ~20 lines)
# 2. Run against the repo, capturing the final report
codex exec -s workspace-write -C /path/to/repo \
  -o /tmp/codex-report.md "$(cat /tmp/codex-prompt.md)"
```

`~/.codex/config.toml` already defaults to gpt-5.5 — don't pass `-m` unless overriding.

## Prompt contract (what makes a delegation succeed)

A self-contained prompt has all five; missing any one produces flailing:

1. **Task** — one paragraph, the observable outcome.
2. **Required reads** — exact file paths (spec/slice card first, then the code files);
   say *why* each matters. Never "read relevant files".
3. **Constraints** — repo rules that apply (test conventions, style, what not to touch).
   Codex reads `AGENTS.md` in the repo root automatically; only restate rules living
   elsewhere.
4. **Done condition** — the exact check/test commands that must pass, run by Codex before
   reporting.
5. **Stop conditions + report format** — "if <ambiguity X>, stop and write the question in
   the report instead of improvising. End with: files changed, test output, open questions."

Vulcan slice cards already carry 1–5 — the prompt can be as thin as: card path +
"execute this card; its Required reads, stop conditions, and Verification are binding."

## Mechanics

- **Sandbox**: `-s workspace-write` for implementation. Never
  `--dangerously-bypass-approvals-and-sandbox`.
- **Long runs**: Bash tool timeout caps at 10 min. Run in the background and poll the
  `-o` report file; treat an empty report + dead process as failure, not success.
- **Parallel tasks**: each Codex instance gets its own git worktree (`isolation:
  'worktree'` when wrapped in an agent) — concurrent edits to a shared checkout collide.
- **From a workflow/subagent**: wrap in a thin sonnet agent per CLAUDE.md
  ("Using gpt-5.5 inside workflows and subagents"); prefix its label/description with
  `gpt-5.5:`.

## After it returns (non-negotiable)

- **Verify, don't trust**: rerun the workspace checks/tests yourself before accepting.
  The report is a claim, not evidence.
- Diff-read the changes at normal review standard; gpt-5.5's taste is a 5 — expect
  correct-but-plain code, and fix taste locally rather than re-prompting for it.
- If the output misses the bar: escalate to a smarter model (standing permission per
  CLAUDE.md) instead of iterating prompts more than once.
