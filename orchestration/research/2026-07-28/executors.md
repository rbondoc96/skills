# Executor contracts

Research date: 2026-07-28. This is transport evidence, not a host-orchestration policy.

## Scope and evidence

| Executor | Installed version | Primary evidence consulted |
| --- | --- | --- |
| Codex | `codex-cli 0.145.0` | `codex --help`; `codex exec --help`; `codex exec review --help`; `codex review --help`; [Codex non-interactive mode](https://learn.chatgpt.com/docs/non-interactive-mode.md); [Codex models](https://learn.chatgpt.com/docs/models.md) |
| Pi | `0.80.10` | `pi --help`; installed `docs/usage.md`; [Pi usage](https://pi.dev/docs/latest/usage) |
| Claude Code | `2.1.220` | `claude --help`; `claude -p --help`; [CLI reference](https://code.claude.com/docs/en/cli-usage); [permission modes](https://code.claude.com/docs/en/permission-modes) |

Re-run the listed help commands whenever an adapter changes. CLI flags are version-specific.

## Boundary

The **host** owns dispatch, concurrency, worktrees, lifecycle, and report collection. Claude Code, Codex, Pi, and T3 can each be a host. An **executor** is the spawned process (`codex exec`, `pi -p`, or `claude -p`). Do not infer executor capabilities from the host: none of these commands creates an isolated worktree unless explicitly requested or provided by the launcher.

All three inherit the launcher process environment. Only Codex provides the documented sandbox selector below; Pi explicitly runs tools with the permissions of its process. Claude's permission modes are not OS sandboxing.

## Codex

### Commands and flag ownership

- `codex exec` is the non-interactive executor. Prompt argument omitted, or `-`, reads the prompt from stdin. If both a prompt argument and piped stdin are present, stdin is appended as context. Progress goes to stderr; the final message goes to stdout. `--ephemeral` disables session persistence. (`codex exec --help`; [non-interactive mode](https://learn.chatgpt.com/docs/non-interactive-mode.md))
- `codex exec review` is the preferred review executor: it has `--uncommitted`, `--base`, and `--commit` plus `--model`, `--ephemeral`, `--output-schema`, `--json`, and `--output-last-message`. (`codex exec review --help`)
- Top-level `codex review` accepts only the review target and `--config`/feature flags in this version. It does **not** list `--model`, `--ephemeral`, report output, JSON, or sandbox options. Prefer `codex exec review` when the route pins those settings. (`codex review --help`)
- Model: pass `--model "$MODEL"`. Reasoning has no dedicated CLI flag; use `--config "model_reasoning_effort=\"$EFFORT\""` when the approved route pins it. `model_reasoning_effort` is a documented config key. (`codex exec --help`; [Codex models](https://learn.chatgpt.com/docs/models.md))
- Working directory: `--cd`/`-C`. Extra writable paths: repeat `--add-dir`. Sandbox values: `read-only`, `workspace-write`, `danger-full-access`. Approval policy is a **parent `codex` option**; put `--ask-for-approval never` before `exec`. (`codex --help`; `codex exec --help`)
- Output: `--output-last-message FILE` writes the final message and still prints it; `--json` makes stdout JSONL; `--output-schema FILE` constrains the final response. Do not combine `--json` with a plain-text report parser. (`codex exec --help`; [non-interactive mode](https://learn.chatgpt.com/docs/non-interactive-mode.md))
- Sessions: `codex exec resume [SESSION_ID] [PROMPT]` or `--last` resumes persisted sessions. `--ephemeral` deliberately prevents this. No background flag is documented for `exec`; launch-process backgrounding is host responsibility. (`codex exec resume --help`)
- Failure: preserve and check the process exit status. With `--json`, treat `turn.failed` and `error` events as failures; exact numeric exit-code meanings are not documented in the consulted material.

Implementation template (prompt is stdin; no command substitution):

```bash
args=(
  codex
  --ask-for-approval never
  --cd "$WORKDIR"
  exec
  --add-dir "$ARTIFACT_DIR"
  --config "model_reasoning_effort=\"$EFFORT\""
  --ephemeral
  --model "$MODEL"
  --output-last-message "$REPORT"
  --sandbox workspace-write
  -
)

"${args[@]}" < "$PROMPT"
status=$?
```

Omit the config override only when the route explicitly selects default effort. `workspace-write` is the least documented write-capable sandbox; use `danger-full-access` only when the approved route and external isolation justify it.

Read-only review template:

```bash
args=(
  codex
  --ask-for-approval never
  --cd "$WORKDIR"
  --sandbox read-only
  exec review
  --base "$BASE"
  --config "model_reasoning_effort=\"$EFFORT\""
  --ephemeral
  --model "$MODEL"
  --output-last-message "$REPORT"
  -
)

"${args[@]}" < "$PROMPT"
status=$?
```

Select exactly one review target: `--base`, `--commit`, or `--uncommitted`. The CLI help does not state whether conflicting targets are rejected, so adapters must not combine them.

## Pi

- `-p`/`--print` is non-interactive: it processes the prompt and exits. `--no-session` is ephemeral. `--mode text` is default; `--mode json` emits event JSONL; `--mode rpc` is a persistent stdin/stdout JSON protocol, not a one-shot report mode. (`pi --help`; installed `docs/usage.md`)
- Model: use `--model "$MODEL"`; it accepts a provider-qualified ID and an optional `:<thinking>` suffix. Prefer a bare model plus `--thinking "$THINKING"` so route fields remain separate. Levels are `off`, `minimal`, `low`, `medium`, `high`, `xhigh`, `max`; actual availability is model-dependent. (`pi --help`; installed `docs/usage.md`)
- Prompt: positional messages and `@file` attachments are supported. In print mode, piped stdin is merged into the initial prompt. Use `< "$PROMPT"` plus a small positional instruction; do not use `$(cat "$PROMPT")`. (`pi --help`; installed `docs/usage.md`)
- Working directory: no `--cwd` option is listed; launch via `(cd "$WORKDIR" && ...)`. Pi stores sessions by working directory. (`pi --help`; installed `docs/usage.md`)
- Tools: `--tools` allowlists named tools; `--exclude-tools` denies them; `--no-tools` disables all. Built-ins are `read`, `bash`, `edit`, `write`, `grep`, `find`, `ls`. Pi has no sandbox: tool calls have the permissions of the `pi` process. (`pi --help`; installed `docs/usage.md`)
- Project trust: non-interactive modes do not prompt. Use `--no-approve` to ignore project-local settings/resources for a controlled run, or `--approve` only when the route explicitly trusts them. (`pi --help`; installed `docs/usage.md`)
- Sessions: `--continue`, `--resume`, `--session`, `--session-id`, and `--fork` use persisted state; `--no-session` disables it. No background option is documented. (`pi --help`; installed `docs/usage.md`)
- Failure: preserve and check the process exit status. No numeric exit-code contract was found. For structured capture, parse `--mode json` as JSONL; do not redirect it into a Markdown report.

Implementation template:

```bash
args=(
  pi
  --model "$MODEL"
  --no-session
  --thinking "$THINKING"
  --tools read,bash,edit,write,grep,find,ls
  -p
  "Complete the task in standard input."
)

(cd "$WORKDIR" && "${args[@]}" < "$PROMPT") > "$REPORT"
status=$?
```

Omit `--thinking` only for a route that selects the provider/model default. Keep Pi implementation work inside a worktree or external sandbox; its tool restriction is not process isolation.

Read-only review template:

```bash
args=(
  pi
  --model "$MODEL"
  --no-approve
  --no-extensions
  --no-session
  --thinking "$THINKING"
  --tools read,grep,find,ls
  -p
  "Review the repository and task in standard input. Do not modify files."
)

(cd "$WORKDIR" && "${args[@]}" < "$PROMPT") > "$REPORT"
status=$?
```

`--no-extensions` prevents discovered extensions, but context files still load unless `--no-context-files` is added. Choose that stricter flag only when the route intentionally excludes repository instructions.

## Claude Code

- `-p`/`--print` prints a response and exits. `--no-session-persistence` prevents session persistence and applies only with `--print`. `--output-format` supports `text`, `json`, and `stream-json`; `--json-schema` accepts a schema for structured output. (`claude --help`; [CLI reference](https://code.claude.com/docs/en/cli-usage))
- Model and effort: pass `--model "$MODEL"` and, when pinned, `--effort "$EFFORT"`. Supported CLI effort names are `low`, `medium`, `high`, `xhigh`, `max`; availability depends on the model. (`claude --help`; [CLI reference](https://code.claude.com/docs/en/cli-usage))
- Working directory: no `--cwd` option is listed in the installed CLI reference. Launch through `(cd "$WORKDIR" && ...)`; use `--add-dir` only for extra existing directories the executor must access. (`claude --help`; [CLI reference](https://code.claude.com/docs/en/cli-usage))
- Permissions: `plan` is read/plan oriented; `dontAsk` permits only pre-approved tools; `bypassPermissions` removes permission protection and is only appropriate in an isolated environment. `--tools` restricts available built-in tools; `--allowed-tools` and `--disallowed-tools` refine permissions. These are not OS sandboxing. (`claude --help`; [permission modes](https://code.claude.com/docs/en/permission-modes))
- Prompt input: a positional prompt is documented. `--input-format text` is default and `stream-json` is supported with `--print`; the consulted references do **not** establish raw-stdin-as-text semantics. Do not rely on it. For a file prompt, pass a file path in the positional prompt and allow read access, rather than using command substitution. (`claude --help`; [CLI reference](https://code.claude.com/docs/en/cli-usage))
- Background/session: `--background` starts a background agent, managed with `claude agents`; compatibility with `--print` is not established here, so do not combine them in an adapter. `--resume`/`--continue` need persistence. (`claude --help`)
- Failure: preserve and check process status. The consulted docs do not define numeric exit codes or a stable JSON failure schema.

Implementation template. `acceptEdits` may still require approval for some commands; for fully unattended writes, use a host-native worker or an explicitly approved externally sandboxed `bypassPermissions` route.

```bash
args=(
  claude
  --add-dir "$ARTIFACT_DIR"
  --effort "$EFFORT"
  --model "$MODEL"
  --no-session-persistence
  --permission-mode acceptEdits
  -p
  "Read $PROMPT, implement only its task, and report completed work and verification."
)

(cd "$WORKDIR" && "${args[@]}") > "$REPORT"
status=$?
```

Read-only review template:

```bash
args=(
  claude
  --add-dir "$ARTIFACT_DIR"
  --effort "$EFFORT"
  --model "$MODEL"
  --no-session-persistence
  --permission-mode plan
  --tools "Bash,Glob,Grep,Read"
  -p
  "Read $PROMPT and review the current repository. Do not modify files."
)

(cd "$WORKDIR" && "${args[@]}") > "$REPORT"
status=$?
```

For a machine-readable report, add `--output-format json --json-schema "$SCHEMA_JSON"` and capture stdout; `--json-schema` takes inline JSON in this CLI version, not a schema-file path.

## Adapter requirements

- Resolve and pass approved model and effort explicitly; never bind a transport to Terra.
- Keep host selection separate from executor selection. A host's native subagents are not a CLI transport.
- Run concurrent writers in separate worktrees. `--add-dir` grants access; it does not isolate changes.
- Use stdin/file redirection or file paths, never `$(cat ...)` for prompts.
- Use ephemeral/no-session mode for disposable delegates; use a named/session ID only when resumption is an approved requirement.
- Capture stdout/final report deliberately and preserve the exit status. Do not mix text parsing with JSON/JSONL modes.
- Pin the narrowest permission/sandbox controls available. Treat Pi and Claude permissions as insufficient isolation for untrusted or broad-scope work.

## Unresolved questions

- Validate actual model availability and supported effort per provider at dispatch time; CLI syntax does not guarantee entitlement or model support.
- Codex's precise numeric exit-code contract, Pi's precise numeric exit-code contract, and Claude's structured failure schema were not documented in the consulted sources.
- Claude raw stdin with `--input-format text`, and `--background` combined with `--print`, need a harmless empirical test or official confirmation before adapter support.
- If an adapter needs machine-readable Claude output from a schema file, it must read/validate the file and pass its JSON as one argument; no `--json-schema-file` flag was found.
