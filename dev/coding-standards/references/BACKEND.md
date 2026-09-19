# Backend

Scope: server entry points, application services, authorization, and background jobs in any language. Framework-specific mechanisms come from the matching reference.

## Request and service boundaries

- Keep protocol handling separate from reusable use-case decisions. Parse input, establish caller identity, and enforce authorization before protected work. Authentication alone is not authorization.
- Give reusable operations enough actor and resource context to enforce their policy across HTTP, command-line, and job callers.
- Choose explicit public outcomes for invalid input, denied access, absent resources, conflicts, and dependency failures. Translate failures at the transport boundary without changing their meaning or exposing internal diagnostics.
- Pass request-scoped collaborators through the established injection mechanism. Framework-managed access is valid where the framework reference permits it; introducing a wrapper requires a concrete responsibility.

## Jobs and long-running work

- Define retryable failures, attempt/deadline limits, and what happens after exhaustion. Cancellation stops scheduling additional work and reaches dependencies that support it.
- Make retried side effects safe against duplicate delivery. Read [Persistence](PERSISTENCE.md) when writes, deduplication, or database-to-queue delivery are involved.
- Keep background work attached to a queue, runtime, or application lifecycle that observes completion and failures. A response finishing does not prove that detached work finished.
- Reset request/job-local mutable state in long-lived workers. Give shared clients an explicit owner and shutdown path.

## Verification

Exercise the affected public entry point and its use case at the level that proves the change. Include relevant authorization denials, invalid inputs, failure translation, cancellation, and retry exhaustion. Control external services through intentional substitutes; use [Persistence](PERSISTENCE.md) for database claims.
