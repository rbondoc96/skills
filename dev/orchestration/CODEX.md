# Codex adapter

## Choose the executor

Prefer Codex native subagents when the current Codex surface advertises them. Use `codex exec` or `codex exec review` for an approved CLI route. Resolve `MODEL`, `EFFORT`, `SANDBOX`, and `WORKDIR` from that route; never bind this adapter to Terra or inherit a model accidentally.

Native agents inherit the host sandbox and approval policy unless the host exposes an explicit per-agent override. Record inherited controls in the route; set an override only when advertised and approved.

## Implementation

Use ephemeral runs for disposable delegates. `--ask-for-approval` is a parent option; pass the approved model, sandbox, and pinned effort explicitly. `workspace-write` is the narrowest documented write-capable sandbox.

```bash
args=(
  codex
  --ask-for-approval never
  --cd "$WORKDIR"
  exec
  --add-dir "$ARTIFACT_DIR"
  --ephemeral
  --model "$MODEL"
  --output-last-message "$REPORT"
  --sandbox "$SANDBOX"
  -
)

if [[ "$EFFORT" != "default" ]]; then
  args=(codex --ask-for-approval never --cd "$WORKDIR" exec --add-dir "$ARTIFACT_DIR" --config "model_reasoning_effort=\"$EFFORT\"" --ephemeral --model "$MODEL" --output-last-message "$REPORT" --sandbox "$SANDBOX" -)
fi

"${args[@]}" < "$PROMPT"
status=$?
```

Use `danger-full-access` only when the approved route and external isolation justify it. `--add-dir` grants access; it does not isolate worktrees.

## Read-only review

Use `codex exec review`, not top-level `codex review`, when the route pins model, effort, report output, ephemeral mode, or sandbox. Select exactly one target: `--base`, `--commit`, or `--uncommitted`.

```bash
args=(
  codex
  --ask-for-approval never
  --cd "$WORKDIR"
  --sandbox read-only
  exec review
  --base "$BASE"
  --ephemeral
  --model "$MODEL"
  --output-last-message "$REPORT"
  -
)

if [[ "$EFFORT" != "default" ]]; then
  args=(codex --ask-for-approval never --cd "$WORKDIR" --sandbox read-only exec review --base "$BASE" --config "model_reasoning_effort=\"$EFFORT\"" --ephemeral --model "$MODEL" --output-last-message "$REPORT" -)
fi

"${args[@]}" < "$PROMPT"
status=$?
```

Preserve `status`. Do not combine `--json` with a Markdown report parser.
