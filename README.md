# Skills

Personal coding-agent skills for software design, review, refactoring, and implementation workflows.

## Skills

- `coding-standards/` — model-invoked TypeScript coding standards and design taste. A thin `SKILL.md` router plus topic files (vocabulary, domain modeling, error handling, boundaries/parsing, module design, async, testing, TypeScript contracts, frontend components, React, Vue, Effect, observability) loaded on demand via progressive disclosure. Covers Node/backend and React/Vue frontends.
- `prose/` — model-invoked skill for writing human-facing text in a consistent personal voice. A `SKILL.md` holding the core voice plus per-mode files (Slack, commits, pull requests, email) loaded on demand. Use when drafting or editing anything another person will read.
- `orchestration/` — model-invoked routing for delegation, provider/model/executor selection, dispatch approval, verification, and Claude/Codex/Pi/T3 mechanics. Dated research supports the active subscription-aware policy; calibration instructions remain separate.
- `pr-review/` — user-invoked orchestrated review of a GitHub PR. Dispatches two independent reviewers from different model providers, then consolidates their findings into one Markdown file under `~/.pr-reviews`. Strictly read-only; never edits the PR. Depends on `orchestration`. Detailed findings format (scopes, line-range URLs, suggestion blocks) lives in `FINDINGS.md`, loaded on demand.

## Install

```sh
scripts/link-skills.sh
```

Edit `COMMON_SKILLS_DIR` and `TARGET_DIRS` at the top of `scripts/link-skills.sh` to change install targets. The script copies skill folders into `~/.agents/skills`, then symlinks target skill dirs to those common clones.
