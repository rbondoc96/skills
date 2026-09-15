# Reliability

Own behavior under partial failure, concurrency, interruption, and recovery. Correctness owns ordinary execution; data integrity owns resulting persisted invariants.

## Investigate

- Trace dependency timeouts, cancellations, retries, backoff, and error propagation. Check idempotency for operations that may execute more than once.
- Check resource cleanup, bounded queues/concurrency, shutdown, and recovery paths when touched.
- Examine races and partial success across operations, including whether callers can distinguish failure from an unknown outcome.

## Evidence bar

Give a concrete failure or interleaving and show the resulting user-visible or operational consequence. Explain which dependency behavior is assumed. Avoid universal retry or timeout prescriptions; tie thresholds to the contract and workload. Report persisted corruption to the parent for data-integrity overlap handling.
