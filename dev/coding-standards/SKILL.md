---
name: coding-standards
description: Coding standards and design taste. Use when designing, implementing, refactoring, or reviewing code, including TypeScript, Python, and PHP; frontend and backend code; persistence, data processing, and AI integrations; or when another engineering skill needs coding standards. Routes to language, framework, and tool guidance for the touched code.
---

# Coding standards

Apply the shared principles below, then load the references selected by the task. This skill is standalone. References describe scoped preferences, not a requirement to adopt every listed library.

## Shared principles

- Establish domain invariants through types, constructors, parsing, and legal transitions. Static annotations alone do not validate external data; pass validated values onward.
- Expose cohesive behavior behind small interfaces. Make dependencies and side effects clear; introduce adapters where they own translation, policy, or real substitution. Framework isolation is a scoped architectural choice.
- Give callers meaningful failure contracts. Distinguish expected failures from defects, preserve useful causes safely, and match the established error channel on the changed path.
- Keep secrets and sensitive payloads out of errors, logs, traces, metrics, and snapshots. Preserve existing reporting and correlation through explicit safe fields.
- Give resources and background work an owner responsible for lifetime, cleanup, cancellation, and failure reporting.
- Test observable behavior through caller-facing interfaces. Substitute external behavior through intentional seams or framework testing facilities; verify database and runtime claims in representative environments.
- Improve the smallest coherent changed path. Broad migrations, compatibility layers, rollout plans, backfills, and deployment sequencing require explicit user intent.

## Apply the standards

1. **Inspect the touched area.** Read applicable project instructions, representative neighboring code, imports, and the nearest manifests/configuration. Identify languages, execution environments, responsibilities, dependencies, error conventions, and verification commands, or confirm that a choice is absent.
2. **Select references per responsibility.** Match all applicable rows below and read their linked prerequisites. A dependency elsewhere in the repository is not enough evidence. For a new project, use the requested stack; ask only when an unresolved choice materially affects the work.
3. **Apply rules within scope.** Language, domain, and framework references combine; they do not compete by load order. A framework reference supplies its own implementation of a shared principle. Explicit user and applicable project instructions take precedence. Compatible local conventions take precedence over defaults. Surface unresolved conflicts rather than silently inventing an exception.
4. **Revisit routing when scope expands.** In mixed-language changes, retain which rules govern each area. Apply shared principles and matching domain topics to uncovered languages/tools; name the coverage gap and use local conventions rather than borrowing another language's syntax or library defaults.
5. **Verify the changed behavior.** Use the project's commands and proportionate checks at the affected boundaries. Finish when every touched responsibility has its applicable standards accounted for and every material changed behavior has evidence, or a stated verification limitation.

## Language routing

| Touched code | Read |
|---|---|
| TypeScript, including typed component scripts | [TypeScript contracts](references/TYPESCRIPT_CONTRACTS.md), plus matching TypeScript topics below |
| Python | [Python](references/PYTHON.md), a provisional baseline with conditional tool guidance |
| PHP | [PHP](references/PHP.md) |

## Domain and framework routing

These topics apply across languages unless their trigger says otherwise. A language does not imply a domain: a Python script or PHP value object is not automatically backend work.

| Touched responsibility | Read |
|---|---|
| User interfaces, templates, forms, interaction, or client state | [Frontend](references/FRONTEND.md) |
| Server request handling, authorization, service orchestration, or background jobs | [Backend](references/BACKEND.md) |
| Database queries, persisted invariants, transactions, or concurrent writes | [Persistence](references/PERSISTENCE.md) |
| Batch imports, exports, record transformation, or partial-data failures | [Data processing](references/DATA_PROCESSING.md) |
| Model calls, generated output, model-requested tool execution, model-call retries, or model usage accounting | [AI integrations](references/AI_INTEGRATIONS.md) |
| Laravel controllers, requests, actions, Eloquent, resources, templates, jobs, or framework tests | [Laravel](references/LARAVEL.md), alongside PHP and matching domain topics |
| TypeScript components, props, client/server state, data fetching, or styling | [TypeScript components](references/FRONTEND_COMPONENTS.md) |
| TypeScript React components, hooks, effects, context, or server components | [React](references/REACT.md) |
| Vue components using TypeScript, reactivity, composables, or Pinia | [Vue](references/VUE.md) |
| TypeScript responsibilities already using Effect services, schemas, error channels, resources, or tests | [Effect](references/EFFECT.md) |

FastAPI, Pydantic, SQLAlchemy, and Python test/tool choices are conditional sections in the Python reference. Read the applicable section when that tool is used or being selected for the touched responsibility. Tool presence alone does not authorize adoption or migration. Check installed versions before applying version-specific APIs.

## TypeScript topic routing

These existing topics retain TypeScript-specific architecture, syntax, error, and library preferences. Their broader-sounding titles do not make them standards for Python or PHP.

| TypeScript concern | Read |
|---|---|
| Shared terms used by the TypeScript topic files | [Vocabulary](references/VOCABULARY.md) |
| Domain values, invariants, brands, value classes, variants, or lifecycle transitions | [Domain modeling](references/DOMAIN_MODELING.md) |
| Error channels, custom errors, catch/classification, absence, or cancellation failures | [Error handling](references/ERROR_HANDLING.md) |
| Logging, tracing, diagnostics, redaction, or reporting hooks | [Observability](references/OBSERVABILITY.md) |
| Module interfaces, adapters, dependency injection, functional core/shell, or resource ownership | [Designing modules](references/DESIGNING_MODULES.md) |
| HTTP, queue, storage, configuration, or runtime payload parsing and projection | [Boundaries and parsing](references/BOUNDARIES_AND_PARSING.md) |
| Cancellation, promises, concurrency, retries, or workflow ownership | [Async and workflows](references/ASYNC_AND_WORKFLOWS.md) |
| Tests, generators, database/runtime verification, or test strategy | [Testing and verification](references/TESTING_AND_VERIFICATION.md) |

## Maintaining this skill

Keep each rule with its owning language, domain, or tool; link to it from consumers. Add a separate reference when its trigger represents a distinct branch with enough guidance to justify loading it independently. Use generic examples, public framework APIs, and project-local concepts rather than names or dependencies from a particular organization.

When changing routing, check the [routing examples](references/ROUTING_EXAMPLES.md). They are maintenance cases, not prerequisites for ordinary coding tasks.
