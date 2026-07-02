# Commit messages

Apply the voice from `SKILL.md`.

## Pattern

- **Match the repo's existing pattern first.** Skim recent history (`git log`) before writing. If the repo has a convention, follow it exactly.
- **Otherwise, Conventional Commits:** `type(scope): summary`, where type is one of `feat`, `fix`, `refactor`, `chore`, `docs`, `test`, `perf`, `build`, `ci`.
- Summary in the imperative mood, lowercase, no trailing period: "add retry to webhook dispatch", not "Added..." or "Adds...".
- Keep the summary under ~72 chars.

## Grouping

- **Group related changes into one commit.** One coherent change per commit.
- If the work spans unrelated concerns, split it into separate commits rather than one grab-bag.

## Body

- Add a body only when the *why* isn't obvious from the summary. Explain the reason for the change, not a restatement of the diff.
- Blank line between summary and body. Don't hard-wrap body paragraphs (see `SKILL.md`); write each paragraph as one line.
- Reference issues/tickets in the repo's established format.

## Examples

`fix(auth): reject tokens missing the exp claim`

```
refactor(parser): pull boundary decode out of the service layer

The service was trusting raw webhook payloads. Move parsing to the boundary so core logic only ever sees refined values.
```
