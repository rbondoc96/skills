# Persistence

Scope: queries, persisted invariants, transactions, and concurrent writes in any language. Language/framework references own row mapping and model conventions.

## State and atomicity

- Put writes that must succeed together in one transaction owned by the use case. Keep network calls and long-running computation outside that transaction.
- Enforce persisted invariants with appropriate database constraints and guarded writes. Input validation alone cannot prevent a competing writer from changing the state.
## Retry-safe commands

Treat mutating HTTP commands, especially `POST` creates, as retryable by default. Clients, proxies, queues, and humans retry after timeouts or lost responses.

A create operation must not allocate a fresh identity on retry and create a duplicate logical resource. Use one of:

- client/request idempotency key;
- client-provided natural ID plus unique constraint;
- persisted replay record;
- deduplication/inbox record;
- state-machine transition guard;
- transactional outbox/inbox.

Prefer:

```txt
receive CreatePayment(idempotencyKey)
  -> transaction: create/replay payment + outbox record
  -> deliver outbox after commit
```

Avoid:

```txt
insert payment
call payment provider
```

A crash between save and external call creates an ambiguous side-effect window unless durable delivery closes it.

## Atomic transition guards

For retry/concurrency-exposed lifecycle transitions, use guarded persistence operations:

```sql
UPDATE invoices
SET state = 'paid', paid_at = ?
WHERE id = ? AND state = 'sent'
```

Avoid stale read then unconditional write as the only guard:

```txt
row = SELECT invoice
if row.state == sent
  UPDATE invoice SET state = paid
```

Retries should not overwrite original transition metadata like `completedAt` or `paidAt`.

Deletion semantics should be explicit: if delete is idempotent, name/document that. If the result claims whether this request deleted the entity, derive it from the atomic delete result, not a stale pre-read.

## Delivery after commit

When committed database state must reliably cause an external message or side effect, use the project's durable delivery mechanism. After-commit scheduling solves visibility ordering, but does not by itself close the crash window between commit and delivery.

## Queries and representation

- Parameterize runtime query values. Allowlist dynamic identifiers or sort expressions that cannot be bound as values.
- Select required columns and relationships deliberately. Avoid per-record queries inside an otherwise batched operation; bound large reads with the project's paging or streaming approach.
- Map stored representations according to the language/framework branch. Schema types and model casts do not establish every domain invariant. Keep impossible persisted states visible rather than silently repairing them during reads.
- Keep transaction and connection/session ownership visible at the boundary that can commit, roll back, and release them.

## Verification

Use the production query/mapping path against an isolated, representative database for claims about constraints, transactions, query semantics, or concurrent writes. Test rollback when an atomic operation fails partway through. An in-memory repository fake proves application behavior, not database behavior.

Use the project's safe test setup and schema/migrations. Name any unverified database guarantee when the required test environment is unavailable.
