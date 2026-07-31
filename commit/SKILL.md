---
name: commit
description: Commit code changes according to the user's preferences.
disable-model-invocation: true
---

# Commit

## Pattern

- **Match the repo's existing pattern first.** Skim recent history (`git log`) before writing. If the repo has a convention, follow it exactly.
- **Otherwise, Conventional Commits:** `type(scope): summary`, where type is one of `feat`, `fix`, `refactor`, `chore`, `docs`, `test`, `perf`, `build`, `ci`.
- Summary in the imperative mood, lowercase, no trailing period: "add retry to webhook dispatch", not "Added..." or "Adds...".
- Keep the summary under ~72 chars.

## Grouping

- **Group related changes into one commit.** One coherent change per commit.
- If the work spans unrelated concerns, split it into separate commits rather than one grab-bag.

## Body

- Add a body only when it preserves important context that cannot be inferred from the subject or diff.
- Use the body to explain why the change was necessary, a non-obvious constraint, or an important consequence.
- Don't use the body to summarize changed files, narrate the implementation, or restate the diff.
- Keep the body brief. Omit it if it adds no durable value.

## Examples

`fix(auth): reject tokens missing the exp claim`

```
refactor(parser): pull boundary decode out of the service layer

The service was trusting raw webhook payloads. Move parsing to the boundary so core logic only ever sees refined values.
```
