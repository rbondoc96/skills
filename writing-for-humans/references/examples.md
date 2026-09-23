# Editing examples

Use these to judge meaning and reading effort, not as templates to copy.

### Concrete wording requires evidence

Before: "This approach leverages a centralized configuration paradigm to facilitate consistency across services."

After, if the source confirms a shared file: "Each service reads the same configuration file, so you can change shared settings in one place."

If the mechanism is unknown, retain that uncertainty: "The services share configuration. The source does not explain how."

### Match terminology to the reader

Source fact: Retrying an order request with the same key does not create another order.

For an unfamiliar reader: "Retrying the request with the same key does not create another order. This behavior is called idempotency."

For a reader familiar with the term: "Order creation is idempotent when requests use the same key."

The condition stays in both versions.

### Remove unsupported judgments

Before: "We're pleased to share that the migration is substantially complete, with only a minor outstanding dependency relating to Finance's validation of historical totals."

After: "The migration is nearly complete. Finance still needs to verify the historical totals."

The rewrite removes the unsupported judgment that the remaining work is minor. It adds no deadline or claim that the migration is safe to release.
