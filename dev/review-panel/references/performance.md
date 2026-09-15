# Performance

Own work per operation, latency, memory, I/O, and scaling behavior. Reliability owns whether overload or failure is handled correctly.

## Investigate

- Trace repeated queries, scans, allocations, network calls, render work, and serialization. Relate them to input size, cardinality, and call frequency.
- Check batching, pagination, caching/invalidation, indexes, and resource retention where the diff changes them.
- Consider the affected critical path and whether new parallel work shifts load to a constrained dependency.

## Evidence bar

Show the operation and plausible workload that causes the cost, with a measured result or explicit complexity estimate. Label estimates. Recommend measurement when volume or frequency is unknown. A micro-optimization without material cost is not a finding; a cache suggestion must account for freshness and invalidation.
