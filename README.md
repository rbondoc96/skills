# Skills

Personal coding-agent skills for software design, review, refactoring, and implementation workflows.

## Invocation

### Explicit only

These skills run only when the user invokes them directly.

- `dev/bro/` — restates the previous response in plain human language.
- `dev/codex/` — delegates a review or implementation task to the Codex CLI.
- `dev/easy-mode/` — enables a persistent, low-energy communication style.
- `dev/issue-triage/` — moves issues through a tracker-independent triage state machine.
- `dev/merge-blockers/` — triages review findings against the merge-blocker bar.
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

- `dev/review-panel/` — reviews changes with a confirmed or named roster of 12 available specialists; saves individual reports, finding decisions, and a combined report.
- `dev/coding-standards/` — coding standards routed by language, domain, framework, and tool. Covers TypeScript, PHP/Laravel, and a provisional Python baseline; shared topics cover frontend, backend, persistence, data processing, and AI integrations. Detailed guidance and routing checks live in `references/`.
- `dev/file-linear-issue/` — files clear, lean issues in Linear.
- `dev/gh-pr/` — GitHub CLI mechanics for complete PR reads and approved writes.
- `dev/html-communication/` — publishes reports, visual explainers, and UI mock variants on Postplan. Branch guidance and a Carbon, Tufte CSS, and Red Blob Games inspiration guide live in `references/`; `assets/document.css` and `assets/components.html` provide the approved progression, nearby notes, compact evidence, responsive sidebar/top navigation, and guided section links.
- `dev/orchestration/` — cross-host delegation, model routing, isolation, and verification policy.
- `writing-for-humans/` — standalone writing guidance with a shared foundation and selective references for developers, stakeholders, and mixed audiences; covers assistant replies and written deliverables.

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
