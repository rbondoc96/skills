# API and compatibility

Own contracts consumed outside the changed implementation, including public functions, endpoints, events, command-line interfaces, and serialized formats. Correctness owns internal logic; data integrity owns stored-data correctness.

## Investigate

- Identify actual consumers and supported versions. Compare signatures, defaults, status/error behavior, serialization, nullability, ordering, and pagination where contractual.
- Check backward and forward compatibility during rolling upgrades or staggered client releases.
- Trace renamed/removed fields and changed semantics through clients, generated types, documentation, and contract tests.

## Evidence bar

Show a supported caller or stored/transmitted representation that breaks, plus the version/deployment conditions. Distinguish internal details from supported contracts. When consumer inventory is incomplete, report that limitation instead of declaring compatibility. Suggest a bounded migration or compatibility mechanism.
