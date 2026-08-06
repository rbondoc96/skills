# Skills

Personal coding-agent skills for software design, review, refactoring, and implementation workflows.

## Invocation

### Explicit only

These skills run only when the user invokes them directly.

- `bro/` — restates the previous response in plain human language.
- `easy-mode/` — enables a persistent, low-energy communication style.
- `issue-triage/` — moves issues through a tracker-independent triage state machine.
- `pr-feedback-resolve/` — stages and executes a thread-aware PR feedback plan.
- `pr-review/` — dispatches two read-only PR reviewers and consolidates their findings.
- `pr-summary/` — stages a structured PR description with optional Linear issue coverage.
- `prose/` — writes human-facing text in a consistent personal voice.
- `tldr/` — explains practical impact without technical jargon.

### Implicit by default

Agents may load these skills automatically when the request matches their description. Users may also invoke them explicitly.

- `coding-standards/` — TypeScript coding standards and design taste.
- `gh-pr/` — GitHub CLI mechanics for complete PR reads and approved writes.
- `orchestration/` — cross-host delegation, model routing, isolation, and verification policy.

### Not user-invocable

None.

This category is for model-only background skills marked with `user-invocable: false`. Host support varies; Codex currently documents implicit-invocation policy but not a matching user-invocation restriction.

## Create a skill

Run the interactive scaffolder from the repository root:

```sh
scripts/scaffold-skill.sh
```

It creates `<skill-name>/SKILL.md` and `<skill-name>/agents/openai.yml`. The default invocation policy allows both implicit and explicit use.

## Install

```sh
scripts/link-skills.sh
```

Edit `COMMON_SKILLS_DIR` and `TARGET_DIRS` at the top of `scripts/link-skills.sh` to change install targets. The script copies skill folders into `~/.agents/skills`, then symlinks target skill directories to those standalone copies.
