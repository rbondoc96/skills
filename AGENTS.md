# Repo Instructions

This repo stores personal coding-agent skills. Optimize changes for editing, maintaining, and extending skills, not for installing or executing them.

## Repo shape

- `coding-standards/` contains the `coding-standards` skill.
  - `SKILL.md` is the router and high-level contract.
  - Topic files hold the detailed standards and should be loaded progressively.
- `prose/` contains the `prose` skill.
  - `SKILL.md` defines the core voice.
  - Mode files define channel-specific rules.
- `pr-review/` contains the `pr-review` skill.
  - `SKILL.md` is the orchestration flow and read-only contract.
  - `FINDINGS.md` holds the findings format, scopes, and line-range URL recipe; it doubles as the output contract handed to each reviewer.
  - Depends on the `orchestration` skill for dispatch mechanics.
- `codex-implementation/` and `codex-review/` contain the Codex CLI delegation skills (single `SKILL.md` each; they pair with the model-routing table in the user CLAUDE.md).
- `pi-implementation/` and `pi-review/` contain the Pi CLI delegation skills (single `SKILL.md` each; same pattern as `codex-implementation`/`codex-review` but for the Pi coding agent).
- `scripts/link-skills.sh` installs skills by copying and symlinking outside this repo.

## Hard rules

- Never run `scripts/link-skills.sh`, except in `--dry-run` mode.
- Do not make source edits during audit/planning tasks unless the user explicitly asks.
- Keep skills and descriptions concise and scannable.
- Prefer progressive disclosure over large all-in-one skill files.
- Do not duplicate detailed rules across files. Link or route to the owning topic file instead.
- Preserve existing skill frontmatter fields: `name` and `description`.

## Editing skills

When changing a skill:

1. Read the relevant `SKILL.md` first.
2. Read any topic or mode files the change touches.
3. Keep `SKILL.md` focused on routing, purpose, non-negotiables, and when to load deeper files.
4. Put detailed guidance in the narrowest matching topic or mode file.
5. Update routing tables when adding, removing, or renaming topic files.
6. Keep descriptions trigger-focused so agents know when to load the skill.

## Style

- Use direct, imperative language.
- Use short headings and bullets.
- Keep examples small, concrete, and valuable.

For human-facing writing style, follow `prose/SKILL.md` instead of duplicating those rules here.
