# Codex adapter

Use Codex for the approved `gpt-5.6-terra` route. The model is configured by Codex; the route selects its role and sandbox.

## Implementation

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

Use `workspace-write` by default. Escalate to `danger-full-access` only when the approved route needs machine-level access.

## Review

```bash
ARTIFACT_DIR="$(mktemp -d "${TMPDIR:-/tmp}/codex-review.XXXXXX")"
REPORT="${ARTIFACT_DIR}/report.md"
PROMPT="${ARTIFACT_DIR}/prompt.md"

codex -C "$PWD" review --uncommitted - < "$PROMPT" > "$REPORT"
```

Choose `--base <branch>` or `--commit <sha>` for the approved target. Codex reviews are evidence; the orchestrator verifies material findings.
