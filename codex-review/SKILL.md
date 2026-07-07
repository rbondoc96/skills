---
name: codex-review
description: Get an independent gpt-5.5 review of code changes, plans, or specs via the Codex CLI (`codex review` / `codex exec -s read-only`). Use when CLAUDE.md's review routing calls for an extra independent perspective beside a fable-5/opus-4.8 review, or to sanity-check a diff, branch, commit, plan, or spec before merging or building.
---

# Codex Review

Run gpt-5.5 as a second, independent reviewer. Its value is independence and correctness
hunting, not taste — weigh its findings accordingly.

## Quick start

```sh
# Working-tree changes (staged + unstaged + untracked)
codex review -C /path/to/repo --uncommitted

# Branch against its base / a single commit
codex review -C /path/to/repo --base main
codex review -C /path/to/repo --commit <sha>

# Focused pass: add custom instructions as the prompt argument
codex review -C /path/to/repo --base main \
  "Focus on the Zod schema refinements and the 422 error paths. Ignore style."
```

`~/.codex/config.toml` already defaults to gpt-5.5 — don't pass `-m` unless overriding.

## Reviewing non-diff artifacts (plans, specs, ADRs)

`codex review` only reviews git diffs. For documents, use read-only exec with a
self-contained prompt (Codex starts cold — name exact paths and the questions to answer):

```sh
codex exec -s read-only -C /path/to/repo -o /tmp/codex-review.md \
  "Review docs/specs/<feature>/spec.md as a skeptical senior engineer.
   Read the spec, its slice cards under slices/, and the ADRs it links.
   Answer: (1) contradictions or underspecified contracts, (2) slices whose
   done-condition can't fail a test, (3) risks the spec doesn't name.
   Cite file:line. End with a severity-ordered findings list."
```

## Mechanics

- **Sandbox**: reviews never need write access — `codex review` is read-only by design;
  always pass `-s read-only` to `codex exec` review prompts.
- **Long runs**: Bash tool timeout caps at 10 min — background + poll the `-o` file for
  big diffs.
- **From a workflow/subagent**: wrap in a thin sonnet agent per CLAUDE.md; prefix its
  label/description with `gpt-5.5:`.

## Weighing the findings (calibration)

- **Correctness findings** (bugs, edge cases, broken invariants): take seriously, but
  *verify each against the code* before acting — independent reviewers confidently flag
  code they've misread.
- **Taste findings** (naming, structure, API shape): gpt-5.5's taste is a 5; treat as
  prompts for your own judgment, not directives. The fable-5/opus-4.8 review owns taste.
- Disagreement between reviewers is signal — resolve it by reading the code, not by
  majority vote.
