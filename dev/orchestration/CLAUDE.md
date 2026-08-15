# Claude adapter

## Choose the executor

Use Claude host-native agents or workflows for approved Claude-native routes. Native model settings reach Claude only.

Run approved Codex and Pi routes through `codex exec` and `pi -p` directly. Use a thin Claude wrapper only when native backgrounding or lifecycle control is required; it must not claim external-model control or rewrite the route.

## `claude -p`

Resolve `MODEL`, `EFFORT`, `WORKDIR`, `ARTIFACT_DIR`, `PROMPT`, and `REPORT` from the approved route. Use `--effort` only when the route pins a supported effort. Claude's permission modes are not OS sandboxing; concurrent writers still need separate worktrees.

```bash
args=(
  claude
  --add-dir "$ARTIFACT_DIR"
  --model "$MODEL"
  --no-session-persistence
  --permission-mode acceptEdits
  -p
  "Read $PROMPT, implement only its task, and report completed work and verification."
)

if [[ "$EFFORT" != "default" ]]; then
  args=(claude --effort "$EFFORT" "${args[@]:1}")
fi

(cd "$WORKDIR" && "${args[@]}") > "$REPORT"
status=$?
```

`acceptEdits` can still require approval. Use a host-native worker or an explicitly approved, externally isolated `bypassPermissions` route for unattended writes. Do not combine `--background` with `--print`.

## Read-only review

Use `plan`, restricted tools, and a prompt-file reference. Do not rely on undocumented raw-stdin text behavior.

```bash
args=(
  claude
  --add-dir "$ARTIFACT_DIR"
  --model "$MODEL"
  --no-session-persistence
  --permission-mode plan
  --tools "Glob,Grep,Read"
  -p
  "Read $PROMPT and review the current repository. Do not modify files."
)

if [[ "$EFFORT" != "default" ]]; then
  args=(claude --effort "$EFFORT" "${args[@]:1}")
fi

(cd "$WORKDIR" && "${args[@]}") > "$REPORT"
status=$?
```

Preserve `status`. Use `--safe-mode` for external or untrusted repositories so
project instructions and customizations cannot steer the reviewer. Include any
required repository conventions in the dispatch card instead. For structured
reports, use `--output-format json` with an inline `--json-schema`; do not parse
it as Markdown.
