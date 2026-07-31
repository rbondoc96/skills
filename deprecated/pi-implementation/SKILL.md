---
name: pi-implementation
description: Ask the Pi coding agent CLI (`pi`, print mode) to implement scoped code changes in the current repository, then inspect the resulting diff and verification. Use when the user asks to delegate implementation to Pi.
---

# Pi Implementation

Load the installed `orchestration` skill first for route selection, dispatch approval, model choice, isolation, verification, and fallback policy. This skill owns Pi-specific mechanics.

Pi has no built-in sandbox. Its tools receive the full permissions of the `pi` process. Keep the approved scope tight; do not route machine-level or credential-adjacent work to Pi without explicit authorization.

## Run

Resolve `MODEL` and `THINKING` from the approved route. Always pass the model; omit thinking only when the route says `default`.

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

The dispatch card names the goal, acceptance criteria, files to avoid, verification, stop conditions, and report format. Pi must preserve unrelated user changes and must not commit, push, deploy, or edit global config unless explicitly authorized.

If `pi` fails, report the error and apply the approved fallback route.
