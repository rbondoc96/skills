---
name: pi-review
description: Ask the Pi coding agent CLI (`pi`, print mode) for an independent code review of uncommitted changes, a branch diff, or a commit. Use when the user asks Claude to have Pi review work, when a change is broad enough that another agent's perspective is useful, and Pi is the requested or configured agent. For a review by Claude itself, use the normal review process instead.
---

# Pi Review

Use Pi as an independent reviewer when the user wants a second-pass review or when a change is broad enough that another agent's perspective is useful.

Prefer Claude's normal review process for small, local checks. Do not delegate review just to avoid reading the code yourself. Treat Pi's output as evidence, not authority.

Use this when the user asks for Pi or delegation to Pi specifically.

## Model Selection

Pass both `--model <provider>/<id>` and `--thinking <level>`.

| Task shape | Model | Thinking | Why |
|---|---|---|---|
| Default review | `opencode-go/deepseek-v4-pro` | `high` | strongest reasoning lane for catching subtle bugs |
| Repo-context-heavy review (tightly tied to codebase conventions) | `opencode-go/glm-5.2` | `high` | long-context repo awareness |
| High-stakes review (architecture, auth, security, data-loss, migrations) | `opencode-go/deepseek-v4-pro` | `xhigh` | matches the extra-thinking bump used for expensive-to-be-wrong decisions |

If the task doesn't clearly match a row, stick with the configured default rather than guessing.

## Workflow

1. Identify the review target: uncommitted changes, base branch, commit SHA, PR checkout, or specific files.
2. Generate the diff yourself with `git diff`.
3. Create a temporary artifact directory for the Pi report and diff.
4. Run `pi -p` with a focused review prompt, piping the diff in via stdin.
5. Read Pi's report and verify important claims against the code before presenting them.

Use this command shape:

```bash
ARTIFACT_DIR="$(mktemp -d "${TMPDIR:-/tmp}/pi-review.XXXXXX")"
REPORT="${ARTIFACT_DIR}/report.md"
PROMPT="${ARTIFACT_DIR}/prompt.md"
DIFF="${ARTIFACT_DIR}/diff.patch"

# Review uncommitted changes (staged + unstaged + untracked):
git add -N . && git diff HEAD > "$DIFF"

# Review current branch against a base branch:
git diff main...HEAD > "$DIFF"

# Review a specific commit:
git show <SHA> > "$DIFF"

# Write a focused review prompt to $PROMPT, then run:
(cat "$PROMPT" "$DIFF") | pi -p --no-session --no-tools > "$REPORT"
```

`--no-tools` keeps Pi read-only for review — it should critique the diff, not edit files. `--no-session` skips writing a persisted session file for a one-off review; drop it if the user wants the Pi session kept around. Pick the model per the Model Selection table above; pass `--model <provider>/<id>` and `--thinking <level>` when overriding the configured default.

## Review Prompt

Ask Pi to use a code-review stance:

```text
Review this diff for bugs, regressions, missing tests, security issues, and requirement mismatches.

Prioritize findings over summary. For each finding, include:
- Severity
- File and line reference
- Concrete failure mode
- Suggested fix direction

Do not edit files. If there are no substantive findings, say so and name any residual test gaps.

Diff follows:
```

Add task-specific context when useful: requirements, risky areas, expected behavior, relevant tests, or files Claude is unsure about.

## Reporting Back

Before relaying a Pi finding, inspect the cited code or diff enough to decide whether the finding is real. In the user-facing response, separate confirmed issues from Pi suggestions you did not verify.

If Pi finds nothing, say that clearly and mention what review target it inspected.

If `pi` is not installed or the command fails, report the error and offer to review the changes directly instead.
