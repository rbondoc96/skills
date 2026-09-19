# Python

Scope: Python code. Status: provisional. The shared principles are settled; the idioms below are starting guidance to refine against concrete examples, not evidence that an existing Python repository is the preferred style.

## Baseline

- Keep public parameters, return values, and boundary representations precise. Preserve configured type-checker strictness. Parse external values before narrowing; `cast` and annotations do not establish runtime validity.
- Give a cohesive operation a named input/output shape instead of spreading loosely typed dictionaries through the application. Keep `Any`, broad `object` values, and unavoidable third-party typing gaps at the smallest boundary with an explanation of what establishes safety.
- Distinguish absence from false or empty values. Use `is None` when absence is the condition; an `or` fallback also replaces valid zero, false, and empty values.
- Match the established exception or result convention. Catch specific failures where recovery or translation is owned, and preserve useful causes without exposing raw payloads.
- Give acquired clients, files, and sessions explicit cleanup through context managers or the application's lifecycle. Keep imports free of connection creation and background execution.

## Candidate idioms

Use these when they fit the local design; do not rewrite existing modules merely to adopt them:

- Frozen dataclasses for immutable application values; account for mutable values held inside them.
- `Protocol` for a narrow capability consumed by a service and implemented by production and test adapters.
- Domain-specific exception classes where callers need to distinguish failures.
- Explicit constructor/function parameters for dependencies, with framework dependency injection at entry points.

Selecting a new schema library, object-relational mapper, error-channel style, or async architecture remains a project decision. This reference does not prescribe a default package for a new Python project. If the choice materially affects the task and neither user intent nor local evidence settles it, ask rather than presenting a candidate as an established preference.

## Conditional tool guidance

Apply only the sections matching tools used by the changed responsibility. Read the corresponding shared domain topics independently; a Python dependency does not imply backend or AI work.

### Pydantic

When Pydantic owns a boundary, express field constraints, variants, and cross-field rules in the boundary model. Pass the validated model or an explicit application value onward. Choose coercion and extra-field behavior for the actual input contract; strictness and rejection of extra fields are separate decisions. Internal values do not all need to become Pydantic models.

### FastAPI

When changing FastAPI handlers, keep transport validation and response translation at routes/dependencies. Supply application collaborators through the established dependency mechanism. Manage client and storage cleanup through the application/dependency lifecycle. Select sync or async dependency APIs deliberately so blocking I/O does not occupy an async handler's event loop.

### SQLAlchemy

When SQLAlchemy is established, preserve the local Core or ORM choice. Make connection/session and transaction lifetimes explicit. Map database results into the application's established types; isolate gaps in third-party row typing at that mapping boundary. Read [Persistence](PERSISTENCE.md) for transaction, concurrency, and verification rules.

### Asyncio

Await owned tasks and propagate cancellation after cleanup. Choose fail-fast cancellation or partial results deliberately; task groups and `gather` have different failure semantics. Bound concurrent work to the dependency and workload limits. Verify behavior against the project's Python version and [asyncio task documentation](https://docs.python.org/3/library/asyncio-task.html#task-cancellation).

### Tests and toolchain

Discover commands and versions from `pyproject.toml`, lockfiles, test configuration, and project scripts. Use existing pytest fixtures, dependency overrides, or injected fakes where they represent the real seam. Existing tools such as uv, Ruff, and mypy remain local choices; their presence in an example repository is not an adoption requirement.

Use representative database tests for storage semantics and fake provider responses for ordinary AI-integration tests. Live integrations require explicit task scope and suitable isolated credentials/data.
