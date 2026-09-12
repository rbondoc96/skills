---
name: codex
description: Delegate a review or implementation task to the Codex CLI with explicit model, reasoning, isolation, and worktree controls.
argument-hint: "<review|implement> [options] [-- task]"
disable-model-invocation: true
---

# Codex

Run one disposable Codex CLI session from a non-Codex harness. This skill is
standalone: the invoking agent owns scope, authorization, result inspection,
and final acceptance.

Requested input: `$ARGUMENTS`

## Input

The first token selects `review` or `implement`. Parse only these options:

- `--model <model>` and `--effort <effort>`
- `--isolation nested|host` (default: `nested`)
- `--worktree <path>` selects an existing checkout or linked Git worktree
- Review only: exactly one of `--uncommitted`, `--base <branch>`, or `--commit <sha>`
- `--` ends options; the remaining text is the task or review focus

Reject unknown options. Omit model or effort flags when the caller omits them,
so Codex inherits its configured value. Default a missing review target to
`--uncommitted`.

## Prepare

1. Confirm `codex` is available. Without `--worktree`, resolve `WORKDIR` from
   `git rev-parse --show-toplevel`. With it, canonicalize the supplied path and
   confirm `git -C "$WORKDIR" rev-parse --show-toplevel` equals it. This makes
   an existing linked worktree a first-class execution root. Treat `--worktree`
   as this skill's path-valued option; do not pass Codex's managed `--worktree`
   flag, because the invoking harness owns worktree creation and integration.
2. Record `git -C "$WORKDIR" status --short` and
   `git -C "$WORKDIR" rev-parse HEAD`. For implementation, stop when existing
   changes overlap the requested files or make the resulting diff ambiguous.
3. Create an artifact directory with `mktemp -d`, containing `prompt.md` and
   `report.md`. Write the complete request to `prompt.md`; never interpolate it
   into a shell command.
4. Build command arguments as a shell array. Pass user values as separate array
   elements. Never evaluate input or forward arbitrary Codex flags.

The prompt must state the goal, scope, acceptance criteria, files to avoid,
verification, and report format. Tell Codex to preserve unrelated changes and
leave commits, pushes, deployments, global configuration, and worktree
integration to the invoking harness unless the request explicitly authorizes
them.

## Isolation

With `nested`, use Codex `read-only` for review and `workspace-write` for
implementation. Use `--ask-for-approval never` because the child process cannot
complete interactive approvals.

With `host`, require both an explicit `--isolation host` argument and evidence
that the invoking harness provides OS-level filesystem isolation for `WORKDIR`.
Then use `--dangerously-bypass-approvals-and-sandbox` instead of Codex sandbox
and approval flags. If external isolation is absent or unknown, stop. Never
fall back from nested to host isolation silently.

## Run

Start with this shared command shape:

```bash
args=(codex --cd "$WORKDIR")

if [[ "$ISOLATION" == nested ]]; then
  args+=(--ask-for-approval never --sandbox "$SANDBOX")
else
  args+=(--dangerously-bypass-approvals-and-sandbox)
fi

args+=(exec --ephemeral --output-last-message "$REPORT")
[[ -n "$MODEL" ]] && args+=(--model "$MODEL")
[[ -n "$EFFORT" ]] && args+=(--config "model_reasoning_effort=\"$EFFORT\"")
```

For review, append `review`, then the selected target as separate arguments,
then `-`. For implementation, append only `-`.

Run the command with `"${args[@]}" < "$PROMPT"` and immediately preserve its
exit status. A nonzero status is a failed delegation even when `report.md`
exists. Return the error and stop; do not change isolation or retry implicitly.

## Accept

For review, verify material findings against the selected worktree before
reporting them. Require severity, file and line, concrete failure mode, fix
direction, and remaining test gaps.

For implementation, inspect `git -C "$WORKDIR" status --short` and the full
diff relative to the recorded baseline. Run the requested verification inside
`WORKDIR`. When `WORKDIR` is a linked worktree, leave its branch and files there;
the invoking harness owns integration into another checkout.

Complete only after the Codex status, report, resulting diff, verification, and
unresolved risks are recorded. Remove the temporary artifacts after consuming
the report unless they are needed to diagnose a failure.
