# Error Handling

Expected failures are part of the contract. Defects are not. Keep that line sharp so callers can handle normal failures and defects remain loud — regardless of whether the codebase represents failures as values or as thrown exceptions.

## Core vocabulary

**Expected Failure** — A normal-operation failure: domain rejection, parse failure, authorization denial, dependency unavailability, I/O/persistence failure, workflow failure, or modeled cancellation outcome.

**Unrecoverable Defect** — An impossible branch, violated invariant, startup misconfiguration, catastrophic condition, or explicit temporary unimplemented path.

**External Adapter Module** — The module that catches exception-based dependencies or framework behavior at a boundary, classifies unknown thrown values, and translates them into the local failure representation or protocol/framework responses.

**Custom Error** — A typed, tagged error value with a stable tag, useful message, structured safe fields, and optional `unknown` cause.

**Precise Error Union** — The local set of failures a caller can handle semantically.

## Two idioms, one discipline

These standards support two error idioms:

- **Errors-as-values** — Expected failures are returned in a typed channel (`Result<T, E>`, Effect's error channel). Rust-flavored. **Strong default for new code with no established convention.**
- **Throw-style** — Expected failures are thrown and caught with `try/catch`. Common in many existing codebases. **Fully valid** — match it where it is the established idiom.

Whichever idiom is in play, the discipline below is shared: failures are *typed and tagged*, defects stay loud, `unknown` is classified before use, and secrets never enter errors. Idiom choice changes the *channel*, not the rigor.

### Idiom selection: audit first

1. **Audit the repo.** Inspect the touched module and its neighbors. Is failure returned (`Result`/Effect) or thrown? Is there a `Result` dependency (`better-result`, Effect) already present? Is there a shared error base class or `AppError` hierarchy?
2. **Match the established idiom on the changed path.** Do not introduce `Result` into a throw-style service, or throw expected failures inside a `Result`-based service, just because of stylistic preference. Mixing idioms inside one layer is worse than either idiom applied consistently.
3. **Greenfield / no convention → errors-as-values.** For new packages or modules where nothing is established, default to `better-result` (or Effect if the responsibility is already Effect-organized — see [`EFFECT.md`](EFFECT.md)).
4. **Translate at the seam, not inward.** When an inbound throw-style framework meets a `Result`-based core (or vice versa), translate at the External Adapter Module. Neither idiom leaks past the boundary.

## Non-negotiables (both idioms)

- Expected failures are represented by typed, tagged values — a `Result` error variant, an Effect error, or a typed thrown error class with a stable `_tag`. Never a bare string, context-free `Error`, or untyped reject.
- Catch variables and rejection reasons are treated as `unknown` until classified.
- Cancellation/interruption is recognized before wrapping unknown failures as ordinary errors.
- Defects (impossible branches, violated invariants, startup misconfig) stay loud: throw / `Panic`, never silently swallowed or returned as an ordinary `err`.
- Secrets never enter error messages, fields, causes, or diagnostics — including startup configuration failures.
- Broad `AppError`-style unions stay near orchestration, rendering, logging, and entrypoints; module interfaces expose precise local failures.

## Non-negotiables (errors-as-values idiom only)

These apply when the changed path uses or should use a typed value channel:

- Expected failures are visible in the local return type through the typed value channel.
- Promise rejection is equivalent to throwing; do not use it for ordinary expected failures in `Result`-based code.
- Domain and functional-core code do not use `try/catch` as normal expected-failure control flow; catch is for translating exception-based dependencies at adapters.
- External Adapter Modules may catch exception-based APIs, but classify `unknown` before translating into the typed channel.

## Strong defaults

Failure representation order:

1. In Effect-based responsibilities, use Effect's typed error channel and the established Effect tagged-error mechanism such as `Schema.TaggedErrorClass`. See [`EFFECT.md`](EFFECT.md).
2. Outside Effect, in errors-as-values code, use **`better-result`** (`Result.ok` / `Result.err`, `TaggedError`, `Result.gen`) as the default Result library.
3. If the repo already has a different established result shape or a small local tagged union, use it rather than introducing `better-result`.
4. In throw-style code, still prefer **`TaggedError`** (or a class with a stable `_tag` and structured fields) for the thrown error types, even though the channel is `throw`/`catch`. The error *values* stay typed and tagged even when the *channel* is exceptions.

A minimal fallback result shape is fine when it is the local project choice:

```ts
type Result<T, E extends Error> =
  | { readonly _tag: "ok"; readonly value: T }
  | { readonly _tag: "err"; readonly error: E };
```

## better-result essentials

`better-result` maps cleanly onto this vocabulary:

| Concept | better-result |
|---|---|
| Expected Failure value | `Result.err(...)`, `TaggedError` subclasses |
| Custom Error | `class X extends TaggedError("X")<{ ... }>() {}` |
| Unrecoverable Defect | `Panic` (thrown when a callback throws inside a Result op — like Rust `panic!`) |
| Wrapping a throwing dependency | `Result.try({ try, catch })` / `Result.tryPromise` |
| Composition without nesting | `Result.gen(function* () { const a = yield* parseA(x); ... })` |
| Boundary serialization (RPC, server actions, storage) | `Result.serialize` / `Result.deserialize` |
| Exhaustive error handling | `matchError(e, { TagA: ..., TagB: ... })` |

Defects surface as `Panic`, not as an `err` variant — keep them out of the error union so `Result<T, E>` does not decay to `Result<T, E | unknown>`. Report `Panic` at the top-level boundary; do not catch it as a domain failure.

## Expected failures as values

Prefer (errors-as-values idiom):

```ts
function findUser(id: UserId): Promise<Result<User, UserNotFound | UserStoreUnavailable>>;
```

Avoid hiding ordinary lookup absence behind a throw in `Result`-based code:

```ts
async function findUser(id: UserId): Promise<User> {
  throw new Error("not found"); // ordinary lookup absence is hidden from the type
}
```

A framework may require throwing or rejected promises at its boundary. Keep the local module typed, then translate at the boundary:

```ts
const result = await users.findById(id);

if (Result.isError(result)) {
  throw toFrameworkError(result.error);
}

return result.value;
```

Do not let the framework's exception style leak inward as the service/domain contract.

## Throw-style done well

When the established idiom is throw-style, keep the same rigor:

```ts
// Typed, tagged error class — same value discipline, exception channel.
export class UserNotFound extends Error {
  readonly _tag = "UserNotFound" as const;
  constructor(readonly userId: UserId) {
    super("User not found");
  }
}

async function findUser(id: UserId): Promise<User> {
  const row = await db.users.findById(id);
  if (row === null) {
    throw new UserNotFound(id); // typed, tagged, documented in JSDoc @throws
  }
  return parseUser(row);
}
```

- Document thrown expected failures with `@throws` and a precise type — they are part of the contract even though the type system cannot enforce them.
- Callers discriminate on `_tag` / `instanceof`, never on `.message`.
- Still keep defects (impossible states) distinct from these expected throws.

## Defects may throw

Throwing (or `Panic`) is for invalid program states:

- impossible branches;
- violated internal invariants;
- startup misconfiguration;
- catastrophic runtime conditions;
- `notYetImplemented` during development.

Prefer shared helpers when they exist:

```ts
casesHandled(unexpectedCase: never): never;
shouldNeverHappen(message?: string): never;
notYetImplemented(message?: string): never;
```

Do not label ordinary domain, parse, authorization, I/O, persistence, or workflow failures as defects merely because throwing is convenient.

## Custom errors

A good expected-failure error is useful to callers and safe for telemetry:

```ts
export class UserStoreUnavailable extends TaggedError("UserStoreUnavailable")<{
  readonly operation: "findActiveByEmail";
  readonly provider: "postgres";
  readonly cause: unknown;
  readonly message: string;
}>() {}

const error = new UserStoreUnavailable({
  operation: "findActiveByEmail",
  provider: "postgres",
  cause,
  message: "User store unavailable during findActiveByEmail",
});
```

When not using `TaggedError`, a class with a stable `_tag` and structured fields is acceptable:

```ts
export class UserNotFound extends Error {
  readonly _tag = "UserNotFound" as const;

  constructor(readonly userId: UserId) {
    super("User not found");
  }
}
```

Avoid public contracts made of raw strings, context-free `Error`, or unstructured messages.

## Precise error unions

Prefer:

```ts
Result<User, UserNotFound | UserStoreUnavailable>
```

Avoid:

```ts
Result<User, AppError>
```

A broad error type hides caller decisions: retry, render not-found, ask for auth, stop workflow, compensate, or report dependency outage.

## Lookup absence

For required lookups, absence is a typed not-found failure:

```ts
findById(id: UserId): Promise<Result<User, UserNotFound | UserStoreUnavailable>>;
```

Use optional results only when optionality is intentional and obvious:

```ts
maybeFindById(id: UserId): Promise<Result<User | undefined, UserStoreUnavailable>>;
exists(id: UserId): Promise<Result<boolean, UserStoreUnavailable>>;
```

In Effect codebases, `Option` is fine for intentional optional lookup semantics.

## Boundary catch and classification

Prefer (translating an exception-based dependency into the typed channel):

```ts
try {
  const response = await fetch(url, { signal });
  return Result.ok(response);
} catch (cause: unknown) {
  if (isAbortCause(cause)) {
    return Result.err(new RequestCancelled({ operation: "fetchUser", cause }));
  }

  return Result.err(new HttpRequestFailed({ operation: "fetchUser", provider: "users-api", cause }));
}
```

Or, with `better-result` doing the wrapping:

```ts
const response = await Result.tryPromise({
  try: () => fetch(url, { signal }),
  catch: (cause) =>
    isAbortCause(cause)
      ? new RequestCancelled({ operation: "fetchUser", cause })
      : new HttpRequestFailed({ operation: "fetchUser", provider: "users-api", cause }),
});
```

Avoid:

```ts
catch (error) {
  logger.error(error.message); // assumes JavaScript threw an Error and may leak data
  throw error;
}
```

Only boundary/rendering/logging code should normalize unknown thrown values for display. External Adapter Modules preserve the original cause where useful.

## Rejected framings

- **"Errors-as-values is preferred, so I should convert this throw-style service."** No — match the established idiom on the changed path. Convert only with explicit intent.
- **"The team throws, so I'll throw bare strings/`Error`."** Throw-style still requires typed, tagged error classes and `@throws` docs.
- **"Recoverable exception."** If callers can recover and the idiom is values, put it in the return type.
- **"The controller catches it anyway."** Boundary translation does not excuse hidden local failure contracts.
- **"Everything is AppError."** Broad unions erase semantic handling.
- **"Not found is undefined."** Required lookup absence is a failure unless the operation is explicitly optional.
- **"Cancellation is just another dependency error."** Cancellation is a control path and must be classified before wrapping.
- **"A defect can just be an `err`."** Defects throw / `Panic`; keeping them out of the error union preserves type precision.

## Review checklist

Use this as the final scan after applying the rules above; the rule source of truth remains in the relevant sections.

- Mixed idioms in one layer: `Result` returns and thrown expected failures interleaved.
- Introducing `Result` into established throw-style code (or vice versa) without explicit intent.
- `async` functions rejecting for ordinary dependency failures in `Result`-based code.
- Catching `error` and using `.message` without classification.
- Returning `Result<T, Error>` or throwing with no stable tags.
- Thrown expected failures without `@throws` documentation.
- Throwing parse/authorization/domain failures from core logic as if defects.
- Forgetting `cause: unknown` when translating lower-level dependency failures.
- Treating startup config diagnostics as a place to print raw environment values.
- A defect returned as an `err` instead of thrown / `Panic`.
