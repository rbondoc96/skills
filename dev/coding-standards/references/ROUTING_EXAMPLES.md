# Routing examples

Use these cases when changing [the router](../SKILL.md). For each, identify the evidence, list the required references and prerequisites, and explain why unrelated branches stay unloaded. These are manual routing checks, not a claim of automated agent evaluation.

All cases start with the shared principles. Add topic files whenever the task also changes their concern; the lists below describe the stated scope.

| Case and local evidence | Expected selection | Guard against |
|---|---|---|
| TypeScript React form changing props, validation, and submission errors | TypeScript contracts, Frontend, TypeScript components, React, Boundaries and parsing, Error handling; module guidance required by components | Loading Python or Laravel from unrelated packages |
| Python FastAPI endpoint changing model calls and persisted results, with Pydantic and SQLAlchemy in the touched path | Python and its matching tool sections, Backend, AI integrations, Persistence | Treating provisional Python idioms as settled package defaults |
| Python CSV transformation with rejected-record reporting, no server or database | Python, Data processing | Loading Backend, Persistence, or AI merely because the repository contains them |
| Laravel endpoint creating related records | PHP, Laravel, Backend, Persistence | Applying the TypeScript enum ban or requiring Eloquent to sit behind a repository interface |
| Plain PHP immutable value object, no framework | PHP | Assuming all PHP is Laravel or backend work |
| Laravel Blade form and its request handler, no TypeScript | PHP, Laravel, Frontend, Backend | Loading React, Zod, or TypeScript component rules |
| TypeScript React client and Python API changed together | Each area's language, domain, framework, and touched-topic references | Applying either area's library defaults to the other |
| TypeScript Effect service changing schemas, failures, and tests | TypeScript contracts, Effect, Boundaries and parsing, Error handling, Testing and verification; Designing modules if service wiring changes | Introducing a parallel schema/result/test convention inside Effect |
| Python database adapter inside a repository that also contains React and AI packages | Python and its applicable database section, Persistence | Loading frontend, Backend, or AI without a matching responsibility |
| Uncovered language implementing a database-writing HTTP handler | Backend, Persistence, shared principles, and local conventions; report missing language coverage | Translating TypeScript syntax or PHP framework patterns by analogy |

After editing, also check relative links, YAML metadata, standalone copy contents, and the README's coverage description. Names and examples must remain generic; public language/framework/tool identifiers may remain when needed to apply a rule.
