# Skills

Personal coding-agent skills for software design, review, refactoring, and implementation workflows.

## Invocation

### Explicit only

These skills run only when the user invokes them directly.

- `dev/bro/` — restates the previous response in plain human language.
- `dev/easy-mode/` — enables a persistent, low-energy communication style.
- `dev/issue-triage/` — moves issues through a tracker-independent triage state machine.
- `dev/address-pr-feedback/` — addresses unresolved review threads on one non-stacked PR.
- `dev/address-stack-feedback/` — addresses unresolved review threads on one PR in a `gh-stack`.
- `dev/pr-feedback-resolve/` — compatibility alias for `address-pr-feedback`.
- `dev/pr-review/` — dispatches two read-only PR reviewers and consolidates their findings.
- `dev/pr-summary/` — stages a structured PR description with optional Linear issue coverage.
- `dev/tldr/` — explains practical impact without technical jargon.
- `tldr-jp/` — recaps the session in Japanese as a learning exercise.
- `prose/` — writes human-facing text in a consistent personal voice.

### Implicit by default

Agents may load these skills automatically when the request matches their description. Users may also invoke them explicitly.

- `dev/coding-standards/` — TypeScript coding standards and design taste.
- `dev/file-linear-issue/` — files clear, lean issues in Linear.
- `dev/gh-pr/` — GitHub CLI mechanics for complete PR reads and approved writes.
- `dev/orchestration/` — cross-host delegation, model routing, isolation, and verification policy.

### Not user-invocable

None.

This category is for model-only background skills marked with `user-invocable: false`. Host support varies; Codex currently documents implicit-invocation policy but not a matching user-invocation restriction.

## Create a skill

Run the interactive scaffolder from the repository root:

```sh
scripts/scaffold-skill.sh
```

It creates `<skill-name>/SKILL.md` and `<skill-name>/agents/openai.yaml`. You can move the generated skill into a domain directory such as `dev/`. The default invocation policy allows both implicit and explicit use.

## Install

```sh
scripts/link-skills.sh
```

Edit `COMMON_SKILLS_DIR` and `TARGET_DIRS` at the top of `scripts/link-skills.sh` to change install targets. The script discovers skills recursively, including domain paths such as `dev/pr-review/`. It copies each skill into the flat `~/.agents/skills/<skill-name>` namespace, then symlinks target skill directories to those standalone copies. Skill names must be unique across domains.
