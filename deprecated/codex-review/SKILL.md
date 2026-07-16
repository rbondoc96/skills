---
name: codex-review
description: Ask Codex CLI (gpt-5.6-terra) for an independent review of uncommitted changes, a branch diff, a commit, or a specific implementation. Use when the user asks for Codex or gpt-5.6-terra review.
---

# Codex Review

Load the installed `orchestration` skill first for route selection, dispatch approval, target choice, verification, and fallback policy. This skill owns Codex review mechanics.

## Run

1. Write the approved review prompt to a temporary file.
2. Run Codex against the approved target.
3. Return its report to the orchestrator.

```bash
ARTIFACT_DIR="$(mktemp -d "${TMPDIR:-/tmp}/codex-review.XXXXXX")"
REPORT="${ARTIFACT_DIR}/report.md"
PROMPT="${ARTIFACT_DIR}/prompt.md"

# Uncommitted changes:
codex -C "$PWD" review --uncommitted - < "$PROMPT" > "$REPORT"

# Branch or commit:
codex -C "$PWD" review --base main - < "$PROMPT" > "$REPORT"
codex -C "$PWD" review --commit <SHA> - < "$PROMPT" > "$REPORT"
```

Ask for severity, file and line, concrete failure mode, suggested fix direction, and residual test gaps. Codex findings are evidence; the orchestrator verifies material claims before reporting them.

If `codex` fails, report the error and apply the approved fallback route.
