# Editing examples

These fictional examples illustrate meaning and reading effort. Use them to judge edits, not as templates to copy.

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

### Name the counted unit and population

Source facts: A 40-line file contains 10 data records. A separate review examined 8 of 10 requested test cases; 6 of the examined cases passed.

Before: "The file contains 40 records. Across all 10 test cases, 75% passed."

After: "The file contains 10 data records. Of the 8 test cases reviewed, 6 passed, or 75%. Two requested cases were not reviewed."

Count records from the data, not physical lines. Keep the reviewed population beside the rate; unreviewed cases are neither passes nor failures.

### Preserve the operation when simplifying

Source fact: The application scans a file before it can be opened. The source does not establish when the file is downloaded.

Before: "The application scans a file before it can be downloaded."

After: "The application scans a file before it can be opened."

Downloading and opening are different operations. A simpler verb must preserve the supported behavior and timing.
