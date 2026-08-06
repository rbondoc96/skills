# Skills

Personal coding-agent skills for software design, review, refactoring, and implementation workflows.

## Skills

- `coding-standards/` — model-invoked TypeScript coding standards and design taste. A thin `SKILL.md` router plus topic files (vocabulary, domain modeling, error handling, boundaries/parsing, module design, async, testing, TypeScript contracts, frontend components, React, Vue, Effect, observability) loaded on demand via progressive disclosure. Covers Node/backend and React/Vue frontends.
- `prose/` — model-invoked skill for writing human-facing text in a consistent personal voice. A `SKILL.md` holding the core voice plus per-mode files (Slack, commits, pull requests, email) loaded on demand. Use when drafting or editing anything another person will read.
- `orchestration/` — model-invoked routing for delegation, provider/model/executor selection, dispatch approval, verification, and Claude/Codex/Pi/T3 mechanics. Dated research supports the active subscription-aware policy; calibration instructions remain separate.
- `issue-triage/` — model-invoked triage workflow that moves issues through a five-role state machine (`needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`). Tracker-agnostic: label strings, disclaimer format, and templates are resolved from the project's own agent docs rather than hardcoded. `AGENT-BRIEF.md` holds the guidance for writing durable agent briefs, loaded on demand.
- `pr-review/` — user-invoked orchestrated review of a GitHub PR. Dispatches two independent reviewers from different model providers, then consolidates their findings into one Markdown file under `~/.pr-reviews`. Strictly read-only; never edits the PR. Depends on `orchestration`. Detailed findings format (scopes, line-range URLs, suggestion blocks) lives in `FINDINGS.md`, loaded on demand.
- `pr-summary/` — user-invoked workflow that stages a structured PR description under `~/.pr-drafts`, optionally maps Linear issues and acceptance criteria, and updates GitHub only after approval.
- `pr-feedback-resolve/` — user-invoked workflow that retrieves complete review threads, stages an editable resolution plan, implements approved commit slices, and optionally replies to or resolves threads.
- `gh-pr/` — model-invoked GitHub CLI mechanics for complete PR reads and explicitly approved writes, including review-thread replies, resolutions, and submitted reviews.

## Install

```sh
scripts/link-skills.sh
```

Edit `COMMON_SKILLS_DIR` and `TARGET_DIRS` at the top of `scripts/link-skills.sh` to change install targets. The script copies skill folders into `~/.agents/skills`, then symlinks target skill dirs to those common clones.
