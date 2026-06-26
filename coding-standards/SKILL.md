---
name: coding-standards
description: TypeScript coding standards and design taste. Use when working on TypeScript code; when adding or changing domain models, modules, adapters, parsers, typed errors, async workflows, tests, TypeScript contracts, React/Vue components, or Effect code; or when another engineering skill needs these coding standards.
---

# Coding Standards

Use these standards while designing and editing TypeScript. They encode a specific design taste: correctness first, precise domain modeling, typed failures, deep modules, explicit boundaries, real-seam tests, strict TypeScript, and boring operational safety. They apply equally to Node/backend services and to React and Vue frontends.

This skill is standalone. Load the topic files that match the code you are touching; do not treat the top-level summary as the whole standard.

## Core tenets

- Correctness, safety, debuggability, boundary integrity, and test integrity come before convenience.
- Local conventions matter when they are compatible with these standards.
- Parse boundary input before it reaches core logic; pass refined/domain values inward.
- Model invariants in types, constructors, parsers, and transitions.
- Model expected failures as typed, tagged values — whether the channel is a `Result`, Effect, or a typed thrown error. Reserve undocumented throws for defects.
- Design deep modules — including components — with intentional seams, small interfaces, and explicit dependencies.
- Verify observable behavior through real seams.
- Keep TypeScript contracts strict, local, documented, and boring.
- Improve changed paths without forcing broad migrations unless explicitly requested.
- Do not design for backwards compatibility, migrations, rollout, backfill, dual-write/read paths, or deployment sequencing unless the user explicitly asks. Treat new designs as the desired target state, not a migration plan.

## Non-negotiables

These are not aesthetic preferences. When they conflict with existing code, preserve compatibility at the seam and improve the changed path rather than copying the violation.

- Untrusted, serialized, persisted, or framework-shaped input is parsed before core/service logic sees it.
- Decoded data is not trusted with `as SomeType`.
- Expected failures are represented as typed, tagged values (not bare strings, context-free `Error`, or untyped rejects), regardless of idiom.
- Defects stay loud (throw / `Panic`); they are never silently swallowed or returned as ordinary expected failures.
- Secrets do not enter errors, logs, traces, metrics, snapshots, or panic summaries.
- Raw platform bindings and framework types stay at composition seams or tightly local External Adapter Modules.
- Dependencies are explicit; hidden globals and ambient time/randomness/IDs do not drive service behavior.
- Tests prove observable behavior through module interfaces or real seams; module mocks and method spies are out.
- Type escape hatches are local, justified with `SAFETY:`, and hidden behind precise interfaces.
- Strict equality (`===`) only; never loose equality (`==`).
- `as any` is banned except as a justified, `SAFETY:`-commented, lint-suppressed escape hatch (see [`TYPESCRIPT_CONTRACTS.md`](TYPESCRIPT_CONTRACTS.md)).
- Never declare a native TypeScript `enum`; use a POJO `as const` object instead (see [`DOMAIN_MODELING.md`](DOMAIN_MODELING.md)).
- Promises are owned: awaited, returned, collected, or handed to explicit detached-work machinery.
- Broad migrations require explicit user intent.
- Backwards compatibility, rollout, deployment sequencing, data backfills, and dual-write/read migration paths require explicit user intent; do not add them as default design concerns.

## Error idiom: audit first

These standards support both **errors-as-values** (greenfield default, via `better-result` or Effect) and **throw-style**. Before changing error handling: audit the touched module's idiom and match it on the changed path. Default new/greenfield code to errors-as-values. Never mix idioms within one layer. Full rules in [`ERROR_HANDLING.md`](ERROR_HANDLING.md).

## How to apply the standards

1. **Audit the local codebase.** Before choosing a library, pattern, External Adapter Module shape, schema style, error representation, error idiom, test strategy, observability mechanism, component/state pattern, or module layout, inspect until the existing choice for each touched concern is identified or confirmed absent.
2. **Classify the change.** Identify the concerns touched: domain state, parsing, errors, observability, modules, async, tests, TypeScript contracts, frontend components, React, Vue, or Effect.
3. **Load every relevant topic file.** The top-level summary is only the routing layer.
4. **Apply safety standards before local convention.** Follow established architecture where compatible. When local convention violates a non-negotiable, isolate compatibility at the boundary and improve the changed path.
5. **Prefer the smallest coherent improvement.** Do not start unrelated migrations, backwards-compatibility paths, rollout plans, backfill plans, or deployment sequencing. Do not add abstractions, External Adapter Modules, Service Modules, libraries, workflows, or config layers without a concrete reason.
6. **Verify through the right seam.** Tests should observe outcomes at the module or system interface that callers use.
7. **Name trade-offs.** If a standard cannot be fully applied without broad migration, state the compatibility constraint and the local improvement made.

## Topic routing

Load the files whose triggers match the task.

| If the change touches... | Load... |
|---|---|
| Shared coding-standard terms, adoption language, failure/boundary/domain/module/runtime vocabulary | [`VOCABULARY.md`](VOCABULARY.md) |
| Domain values, invariants, branded types, value classes, state machines, lifecycle transitions, optionality, `Partial<T>`, boolean flags, POJO enums, operation inputs, exhaustive variants, persisted lifecycle constraints | [`DOMAIN_MODELING.md`](DOMAIN_MODELING.md) |
| Expected failures, error idiom selection (values vs throw), custom errors, `better-result`, not-found semantics, cancellation classification, startup config diagnostics, catch/classification | [`ERROR_HANDLING.md`](ERROR_HANDLING.md) |
| Tracing, logging, telemetry, safe summaries, secrets, redaction, preserving reporting/correlation hooks | [`OBSERVABILITY.md`](OBSERVABILITY.md) |
| Domain Modules, Service Modules, External Adapter Modules, interfaces, seams, dependency injection, functional core/shell, resource ownership | [`DESIGNING_MODULES.md`](DESIGNING_MODULES.md) |
| HTTP/RPC/queue/storage/env parsing, DTOs, codecs, Zod schemas, projections, config, runtime-hop payloads | [`BOUNDARIES_AND_PARSING.md`](BOUNDARIES_AND_PARSING.md) |
| Cancellation, promise ownership, concurrency, idempotency, transactions, retries, workflows, detached work | [`ASYNC_AND_WORKFLOWS.md`](ASYNC_AND_WORKFLOWS.md) |
| Tests, property tests, real seams, persistence/runtime verification, risk-matched evidence | [`TESTING_AND_VERIFICATION.md`](TESTING_AND_VERIFICATION.md) |
| Casts, `any`, catch values, thenables, readonly contracts, collections, optionality, object spread/projection/delete, guard clauses, member ordering, exports, imports, barrels, JSDoc, toolchain | [`TYPESCRIPT_CONTRACTS.md`](TYPESCRIPT_CONTRACTS.md) |
| Any component, props, component-local vs server vs global state, data fetching (TanStack Query), forms, Tailwind, accessibility — framework-agnostic | [`FRONTEND_COMPONENTS.md`](FRONTEND_COMPONENTS.md) |
| React components, hooks, effects, derived state, keys, memoization, context, server components | [`REACT.md`](REACT.md) |
| Vue SFCs, Composition API, `ref`/`reactive`/`computed`, props/emits, composables, Pinia stores | [`VUE.md`](VUE.md) |
| Established Effect responsibilities, Effect services/layers, typed errors, Schema, Redacted, Effect testing/RPC | [`EFFECT.md`](EFFECT.md) |

## Strong defaults

Use the repository's established choice when it exists and satisfies these standards. When no established choice exists, load the topic file that owns the concern and follow its strong defaults. Default libraries when nothing is established: `better-result` for Results, Zod at boundaries, TanStack Query for server state, Pinia (Vue) with minimal global state, Vitest, Oxlint + Oxfmt.

Do not treat this root file as enough context for library, runtime, schema, error, testing, frontend, Effect, or toolchain choices.

## Rejected framings

- **"The existing code throws, so new expected failures can throw bare strings."** Throw-style still requires typed, tagged error classes and `@throws` docs. Match the idiom, keep the rigor.
- **"Errors-as-values is the preferred style, so I'll convert this throw-style codebase."** Match the established idiom on the changed path; convert only with explicit intent.
- **"Validation is enough."** Parsing must return the refined value and pass it inward.
- **"A wrapper is architecture."** A pass-through module earns its keep only when it hides complexity, owns policy, or translates across a real seam.
- **"Mocks make tests isolated."** Module mocks isolate the wrong thing. Replace behavior through real seams.
- **"Types are proof."** Serialized data, DB rows, runtime-hop payloads, and API responses become less structured at runtime. Parse them.
- **"Future flexibility justifies an interface."** A seam is real when behavior varies, a boundary translates, or tests substitute through an intentional seam.
- **"A lint suppression is a fix."** Suppressions must be targeted and explain the safety invariant.
- **"A `useEffect` will sync it."** Most derived state is computed, not effect-synced. An effect is for external-system synchronization, not for deriving values (see [`REACT.md`](REACT.md)).
