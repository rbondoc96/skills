# Pi adapter

Pi has no sandbox: its tools have the `pi` process permissions. Use a separate worktree or external isolation for every writer. Resolve `MODEL`, `THINKING`, `WORKDIR`, `PROMPT`, and `REPORT` from the approved route. Always pass `--model`; omit `--thinking` only for `default`. Otherwise use only `off`, `minimal`, `low`, `medium`, `high`, `xhigh`, or `max`.

## Pi host

When invoked from Pi, the current Pi agent remains the orchestrator. Run
approved workers through `pi -p` or another selected executor; do not imply a
native isolated subagent capability unless the current Pi surface advertises
one.

## Implementation

Use a disposable session and stdin rather than command substitution.

```bash
args=(
  pi
  --model "$MODEL"
  --no-session
  --tools read,bash,edit,write,grep,find,ls
  -p
  "Complete the task in standard input. Do not delegate or re-orchestrate."
)

if [[ "$THINKING" != "default" ]]; then
  args=(pi --model "$MODEL" --no-session --thinking "$THINKING" --tools read,bash,edit,write,grep,find,ls -p "Complete the task in standard input. Do not delegate or re-orchestrate.")
fi

(cd "$WORKDIR" && "${args[@]}" < "$PROMPT") > "$REPORT"
status=$?
```

## Read-only review

Restrict tools and project-local execution. Do not treat tool restrictions as process isolation.

```bash
args=(
  pi
  --model "$MODEL"
  --no-approve
  --no-context-files
  --no-extensions
  --no-session
  --tools read,grep,find,ls
  -p
  "Review the repository and task in standard input. Do not modify files or delegate."
)

if [[ "$THINKING" != "default" ]]; then
  args=(pi --model "$MODEL" --no-approve --no-context-files --no-extensions --no-session --thinking "$THINKING" --tools read,grep,find,ls -p "Review the repository and task in standard input. Do not modify files or delegate.")
fi

(cd "$WORKDIR" && "${args[@]}" < "$PROMPT") > "$REPORT"
status=$?
```

Preserve `status`. `--no-context-files` prevents an external repository from
steering the reviewer; omit it only when loading repository instructions is an
approved part of the route. Use `--mode json` only when the report consumer
parses JSONL rather than Markdown.
