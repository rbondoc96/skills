---
name: codex-implementation
description: Ask Codex CLI (gpt-5.6-terra) to implement scoped code changes in the current repository, then inspect the resulting diff and verification. Use when the user asks to delegate implementation to Codex or gpt-5.6-terra.
---

# Codex Implementation

Load the installed `orchestration` skill first for route selection, dispatch approval, isolation, verification, and fallback policy. This skill owns Codex-specific mechanics.

## Run

1. Write the approved dispatch card to a temporary prompt file.
2. Run Codex with the approved worktree.
3. Return its report to the orchestrator.

```bash
ARTIFACT_DIR="$(mktemp -d "${TMPDIR:-/tmp}/codex-implementation.XXXXXX")"
REPORT="${ARTIFACT_DIR}/report.md"
PROMPT="${ARTIFACT_DIR}/prompt.md"

codex exec \
  -C "$PWD" \
  --add-dir "$ARTIFACT_DIR" \
  -s workspace-write \
  -o "$REPORT" \
  "$(cat "$PROMPT")"
```

Use `workspace-write` by default. Use `danger-full-access` only when the approved route needs machine-level access.

The dispatch card names the goal, acceptance criteria, files to avoid, verification, stop conditions, and report format. Codex must preserve unrelated user changes and must not commit, push, deploy, or edit global config unless explicitly authorized.

If `codex` fails, report the error and apply the approved fallback route.
