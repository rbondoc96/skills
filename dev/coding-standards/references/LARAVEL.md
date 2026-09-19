# Laravel

Scope: Laravel application code, alongside [PHP](PHP.md) and matching domain topics selected by the router. These conventions use public Laravel APIs and ordinary application classes; they require no organization-specific package or base class.

## Requests and actions

Prefer this responsibility split for nontrivial request flows:

```text
Route and middleware
  -> FormRequest authorization and validation
  -> typed operation input
  -> injected action
  -> Eloquent persistence
  -> API Resource
```

- Put request authorization and input rules in FormRequests, using policies or gates for reusable authorization decisions. Apply equivalent authorization when the same action is reached through another entry point.
- Construct typed operation input from validated fields. A request-local conversion method can own this translation; ordinary constructors are sufficient. Check the allowed keys of nested arrays as well as the outer input.
- Keep controllers responsible for transport: receive input, invoke an action, and select the response or resource.
- Let an action own a cohesive use case. Prefer constructor-injected collaborators and the PHP reference's immutable-class defaults when compatible with the class's responsibilities.
- Keep HTTP request/response objects out of reusable actions. Eloquent models, framework collections, and established facades are valid application dependencies; add a repository or adapter only when it hides meaningful complexity or provides real substitution.
- Follow the project's existing action method naming and placement. A trivial operation does not require a ceremonial action/data-object pair.

FormRequest mechanics and validated input access follow the [installed Laravel version's validation documentation](https://laravel.com/docs/validation#form-request-validation).

## Persistence and output

Read [Persistence](PERSISTENCE.md) when changing queries, transactions, or persisted rules.

- Let Eloquent models own casts, relationships, query scopes, and cohesive domain predicates. Use typed relationships and static-analysis generics where the project's tooling supports them.
- Put a multi-write use case's transaction around the action's atomic work using `DB::transaction`. Let failures abort the transaction, and handle unsuccessful write results as well as exceptions; a cancelled save must not become a success response.
- Select mass-assigned fields explicitly from validated operation input. Apply the model's assignment protections as a second boundary.
- Load relationships required by the response deliberately. Resource rendering should not trigger an accidental query per item. Treat missing required relations as a contract failure; omit optional relations deliberately.
- Use API Resources for explicit public fields and nested projections. Model casts and serialization defaults do not replace a response contract.
- Translate expected action failures through the application's established exception-rendering/reporting mechanism. Preserve the distinction between authorization, validation, absence, conflict, and unexpected failures.

## Jobs and events

Read [Backend](BACKEND.md) for job lifetime and retry policy.

- Keep jobs focused on scheduling and delivery orchestration; delegate reusable work to actions.
- When a queued job depends on writes in an open transaction, use the project's after-commit queue setting or `afterCommit()` dispatch. This prevents workers observing uncommitted state. It does not guarantee durable database-to-broker delivery; apply the persistence guidance when that guarantee is required.
- Use container lifecycle scopes appropriate to requests and jobs. Mutable per-request state must be cleared before a long-lived worker handles the next task.

Check [Laravel's jobs and transactions guidance](https://laravel.com/docs/queues#jobs-and-database-transactions) against the configured queue connection.

## Verification

- Test request authorization, invalid input, action outcomes, public response fields, and persisted state through their owning interfaces.
- Test failed multi-write operations for rollback using a representative database.
- Use framework fakes for outbound queues, notifications, mail, or HTTP when those are the boundary being observed. A dispatch assertion proves dispatch; exercise the job/action separately to prove its work.
- Use factories and data providers for meaningful states and cases. Tests need not mirror class count or private method structure.
