# Data integrity

Own persistence invariants, schemas, migrations, transaction boundaries, and data lifecycle. Reliability owns failure/retry mechanics; security owns unauthorized data access.

## Investigate

- Trace creates, updates, deletes, and backfills against uniqueness, ownership, referential, and business invariants.
- Check transaction boundaries, concurrent writes, lost updates, deduplication, and partial persistence in the affected path.
- Inspect migrations against existing rows, nullable/default values, ordering, application-version coexistence, and recovery from interruption.
- Check retention, precision, units, timestamps, and destructive transformations when changed.

## Evidence bar

Show the initial data, operation/interleaving, and invalid final state, loss, or migration failure. Identify required volume or version conditions. Evaluate migration code and safe local fixtures only; review does not authorize executing migrations against live data. Surface uncertain data assumptions explicitly.
