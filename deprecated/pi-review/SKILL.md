---
name: pi-review
description: Ask the Pi coding agent CLI (`pi`, print mode) for an independent review of uncommitted changes, a branch diff, or a commit. Use when the user asks for Pi review.
---

# Pi Review

Load the installed `orchestration` skill first for route selection, dispatch approval, model choice, target choice, verification, and fallback policy. This skill owns Pi-specific mechanics.

## Run

Resolve `MODEL` and `THINKING` from the approved route. Generate the approved diff without changing the index.

```bash
ARTIFACT_DIR="$(mktemp -d "${TMPDIR:-/tmp}/pi-review.XXXXXX")"
DIFF="${ARTIFACT_DIR}/diff.patch"
REPORT="${ARTIFACT_DIR}/report.md"
PROMPT="${ARTIFACT_DIR}/prompt.md"

# Uncommitted changes, including untracked files:
git diff HEAD > "$DIFF"
while IFS= read -r -d '' file; do
  git diff --no-index -- /dev/null "$file" || true
done < <(git ls-files --others --exclude-standard -z) >> "$DIFF"

ARGS=(-p --no-session --no-tools --model "$MODEL")
if [[ "$THINKING" != "default" ]]; then
  ARGS+=(--thinking "$THINKING")
fi

(cat "$PROMPT" "$DIFF") | pi "${ARGS[@]}" > "$REPORT"
```

Use `--no-tools` for review. Omit `--thinking` when the route says `default`. Ask for severity, file and line, concrete failure mode, suggested fix direction, and residual test gaps. Pi findings are evidence; the orchestrator verifies material claims before reporting them.

If `pi` fails, report the error and apply the approved fallback route.
