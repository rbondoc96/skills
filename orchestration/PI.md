# Pi adapter

Pi has no sandbox. Its tools receive the full permissions of the `pi` process. Keep the approved scope tight; do not route machine-level or credential-adjacent work to Pi without explicit authorization.

## Implementation

Resolve `MODEL` and `THINKING` from the approved route. Always pass the model; pass thinking unless the route says `default`.

```bash
ARTIFACT_DIR="$(mktemp -d "${TMPDIR:-/tmp}/pi-implementation.XXXXXX")"
REPORT="${ARTIFACT_DIR}/report.md"
PROMPT="${ARTIFACT_DIR}/prompt.md"

ARGS=(-p --no-session --model "$MODEL")
if [[ "$THINKING" != "default" ]]; then
  ARGS+=(--thinking "$THINKING")
fi

(cd "$PWD" && pi "${ARGS[@]}" "$(cat "$PROMPT")") > "$REPORT"
```

## Review

Capture the approved diff without changing the index. Include untracked files explicitly.

```bash
ARTIFACT_DIR="$(mktemp -d "${TMPDIR:-/tmp}/pi-review.XXXXXX")"
DIFF="${ARTIFACT_DIR}/diff.patch"
REPORT="${ARTIFACT_DIR}/report.md"
PROMPT="${ARTIFACT_DIR}/prompt.md"

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

Use `--no-tools` for review. Omit `--thinking` only when the route says `default`.
