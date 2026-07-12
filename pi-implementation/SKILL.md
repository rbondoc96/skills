---
name: pi-implementation
description: Ask the Pi coding agent CLI (`pi`, RPC/print mode) to implement scoped code changes in the current repository, then have Claude inspect the resulting diff and verification. Use when the user asks Claude to delegate implementation to Pi, when a bounded task would benefit from another coding agent producing a patch, and Pi is the requested or configured agent.
---

# Pi Implementation

Use Pi as a separate implementation agent for bounded code changes. Claude remains responsible for scoping the task, reviewing the diff, running or checking verification, and explaining the final result.

Use this when the user asks for Pi or delegation to Pi specifically. Do not let Pi commit, push, deploy, or edit global config unless the user explicitly asked for that.

**Pi has no built-in sandbox.** Built-in tools read files, write files, edit files, and run shell commands with the full permissions of the `pi` process — there is no `workspace-write` vs `danger-full-access` distinction. Keep the prompt scope tight and never delegate work touching machine-level or credential-adjacent state without the user's explicit go-ahead.

## Model Selection

Pass both `--model <provider>/<id>` and `--thinking <level>`.

| Task shape | Model | Thinking | Why |
|---|---|---|---|
| Default implementation, general coding throughput | `opencode-go/kimi-k2.7-code` | always-on (no override) | optimized for coding throughput |
| Repo-heavy or architecture-aware change | `opencode-go/glm-5.2` | `high` | long-context repo synthesis |
| Reasoning-heavy change (tricky logic, algorithms, debugging) | `opencode-go/deepseek-v4-pro` | `high` | stronger reasoning lane than Kimi for non-obvious logic |
| Trivial or disposable edit (small, low-risk, mechanical) | `opencode-go/deepseek-v4-flash` | off | fast and cost-efficient for low-stakes work |

If the task doesn't clearly match a row, stick with the configured default rather than guessing.

## Workflow

1. Pin the current state with `git status --short` and note any user changes already present.
2. Define the implementation scope: files or behavior to change, files to avoid, constraints, and verification commands.
3. Create a temporary artifact directory for the Pi report.
4. Run `pi -p` (one-shot print mode) with the repo as the working directory.
5. After Pi exits, inspect `git status` and `git diff`.
6. Run the cheapest reliable verification yourself when practical.
7. Report what Pi changed, what Claude verified, and any remaining risks.

Use this command shape:

```bash
ARTIFACT_DIR="$(mktemp -d "${TMPDIR:-/tmp}/pi-implementation.XXXXXX")"
REPORT="${ARTIFACT_DIR}/report.md"
PROMPT="${ARTIFACT_DIR}/prompt.md"

# Write a self-contained prompt to $PROMPT, then run:
(cd "$PWD" && pi -p --no-session "$(cat "$PROMPT")") > "$REPORT"
```

`-p`/`--print` runs a single prompt to completion and exits — no trust prompt appears in this mode. `--no-session` skips writing a persisted session file for a one-off delegation; drop it if the user wants the Pi session kept around. Pick the model per the Model Selection table above; pass `--model <provider>/<id>` and `--thinking <level>` when overriding the configured default.

## Prompt Requirements

Tell Pi:

- The exact implementation goal and acceptance criteria.
- The repo path and current branch context if relevant.
- Which existing patterns, files, or tests to inspect first.
- Files or behavior that must not be changed.
- That it must preserve unrelated user changes.
- That it must not commit, push, deploy, or edit global config.
- Which verification commands to run, or to explain why they were skipped.
- To write a concise final report with files changed, verification, and unresolved questions.

Keep the task bounded. If the requested work bundles several substantial changes, split it into separate Pi runs or ask the user to choose the first scope.

## Example Prompt

```text
You are implementing a scoped change for Claude.

Repository: /absolute/path/to/repo

Goal:
- Add keyboard navigation to the command palette.

Acceptance criteria:
- ArrowUp and ArrowDown move the highlighted item.
- Enter selects the highlighted item.
- Escape closes the palette
- Existing mouse behavior keeps working.

Constraints:
- Preserve unrelated user changes.
- Do not commit, push, deploy, or edit global config.
- Follow existing component and test patterns.

Verification
- Run the focused component tests if available.
- Otherwise, run the nearest relevant typecheck or test command and explain the choice.

Report:
- Files changed
- Behavioral summary
- Verification run and result
- Anything blocked or uncertain
```

## Review After Pi

Always inspect Pi's diff before telling the user the work is done. Revert only Pi-created mistakes when you are sure they are not user changes. If Pi leaves the repo in a worse state or changes unrelated files, stop and report the issue with the diff summary.

If `pi` is not installed or the command fails, report the error and offer to implement the change directly instead.
