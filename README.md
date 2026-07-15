# Skills

Personal coding-agent skills for software design, review, refactoring, and implementation workflows.

## Skills

- `coding-standards/` — model-invoked TypeScript coding standards and design taste. A thin `SKILL.md` router plus topic files (vocabulary, domain modeling, error handling, boundaries/parsing, module design, async, testing, TypeScript contracts, frontend components, React, Vue, Effect, observability) loaded on demand via progressive disclosure. Covers Node/backend and React/Vue frontends.
- `prose/` — model-invoked skill for writing human-facing text in a consistent personal voice. A `SKILL.md` holding the core voice plus per-mode files (Slack, commits, pull requests, email) loaded on demand. Use when drafting or editing anything another person will read.
- `orchestration/` — model-invoked routing for delegation, model selection, dispatch approval, verification, and Claude/Codex/Pi mechanics.
- `pr-review/` — model-invoked orchestrated review of a GitHub PR. Dispatches two independent reviewers from different model providers, then consolidates their findings into one Markdown file under `~/.pr-reviews`. Strictly read-only; never edits the PR. Depends on `orchestration`. Detailed findings format (scopes, line-range URLs, suggestion blocks) lives in `FINDINGS.md`, loaded on demand.
- `codex-implementation/` — delegate bounded, clear-spec implementation work to gpt-5.5 via `codex exec`. Prompt contract for cold-start delegation, sandbox/timeout/worktree mechanics, and the verify-don't-trust rule for accepting results.
- `codex-review/` — independent gpt-5.5 review of diffs (`codex review --uncommitted/--base/--commit`) or plans/specs (`codex exec -s read-only`), with calibration guidance for weighing correctness vs taste findings.

## Install

```sh
scripts/link-skills.sh
```

Edit `COMMON_SKILLS_DIR` and `TARGET_DIRS` at the top of `scripts/link-skills.sh` to change install targets. The script copies skill folders into `~/.agents/skills`, then symlinks target skill dirs to those common clones.
