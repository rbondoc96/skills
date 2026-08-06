# Repository guidance

This repository is the source of truth for personal coding-agent skills used by Codex, Claude, and Pi. Optimize changes for authoring and maintenance. Do not edit installed copies.

## Structure

- Each active top-level skill directory contains `SKILL.md`.
- Put detailed, selectively loaded guidance in `references/`.
- Put deterministic or repeatedly rewritten operations in `scripts/`.
- Put OpenAI UI and invocation metadata in `agents/openai.yml` or an existing `agents/openai.yaml`.
- Keep retired skills under `deprecated/`.
- Use `scripts/scaffold-skill.sh` to start a skill and `scripts/link-skills.sh` to install skills.

Some source resources are relative symlinks to a canonical file in another skill. The installer dereferences them so every installed skill remains standalone. Edit the canonical target, not a generated installed copy.

## Ownership

- `coding-standards/SKILL.md` routes to its topic files.
- `prose/` owns human-facing voice, including canonical PR description and reply guidance.
- `gh-pr/` owns reusable GitHub CLI and API mechanics.
- `pr-summary/` and `pr-feedback-resolve/` own their workflow decisions, templates, and staged artifacts; they link shared prose and GitHub mechanics from their owners.
- `orchestration/` owns dispatch policy, model/provider routing, host adapters, and approval mechanics. Dated research is evidence, not active policy.
- `issue-triage/` owns the tracker-independent state machine. Consuming projects own tracker, label, and template details.

## Hard rules

- Never run `scripts/link-skills.sh` except with `--dry-run`.
- Do not edit skill source during an audit or planning task unless the user explicitly requests implementation.
- Preserve unrelated work and existing frontmatter fields.
- Keep one authoritative copy of each rule. Link or route to it instead of duplicating it.
- Update routing references and the README when adding, removing, or renaming skills or supporting files.

## Invocation policy

Choose one policy deliberately:

| Policy | `SKILL.md` | `agents/openai.yml` |
|---|---|---|
| Implicit and explicit | Omit invocation restriction fields | `allow_implicit_invocation: true` or omit the policy |
| Explicit only | `disable-model-invocation: true` | `allow_implicit_invocation: false` |
| Model only where supported | `user-invocable: false` | `allow_implicit_invocation: true` or omit the policy |

`user-invocable: false` is not enforced consistently by every host. Do not promise portable user-invocation restriction without verifying the target host.

## Authoring

1. Read the target `SKILL.md` and every directly affected reference or script.
2. Keep `SKILL.md` focused on purpose, ordered workflow, boundaries, completion criteria, and routing to deeper files.
3. Write descriptions as concise trigger contracts: what the skill does and when it should load.
4. Use direct, imperative language, short headings, and small concrete examples.
5. Give fragile operations specific commands or scripts; leave contextual judgment as guidance.
6. State expected inputs, outputs, stop conditions, prohibited inferences, and checkable completion criteria.
7. Keep references one level from `SKILL.md` when practical. Explain when each reference should be read.
8. Remove scaffold comments, placeholders, unused directories, stale guidance, and duplicated rules before completion.

## Frontmatter and metadata

- `name` must match the directory and use lowercase letters, numbers, and hyphens.
- `description` is required and must be trigger-focused.
- Use `license`, `compatibility`, and string-valued `metadata` only when they record useful distribution or environment facts.
- Use `argument-hint` and `arguments` only when the workflow accepts positional input.
- Treat `allowed-tools` as experimental. Avoid active permission, model, context, or other host-specific fields unless the workflow requires them and their consequences are understood.
- Keep `agents/openai.yml` interface text consistent with `SKILL.md`.
- Quote interface strings. A `default_prompt` must mention `$<skill-name>` explicitly.

## Verification

- Run every new or changed script with representative valid and invalid input.
- Run `bash -n` for Bash scripts and `git diff --check` for all changes.
- Parse changed YAML frontmatter and `agents/openai.yml` files.
- Run `scripts/link-skills.sh --dry-run` after changing skill discovery, symlinks, or installation behavior.
- Verify every source symlink resolves and test that installer copy semantics produce regular files.
- Avoid checks that mutate unrelated files or start long-running services.

After changes, report the files modified, verification performed, and any remaining limitations.
