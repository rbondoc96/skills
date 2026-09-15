# Correctness

Own behavior within the changed execution paths and affected callers. API compatibility owns external contract evolution; reliability owns behavior under operational failure.

## Investigate

- Trace inputs through branches, transformations, state transitions, and returned results. Check boundary values, empty/missing cases, ordering, and units against intended behavior.
- Follow callers and consumers when a changed assumption can affect them. Check error propagation and whether the implementation actually fulfills the requested behavior.
- Contrast the old and new behavior to establish whether this change causes or worsens the issue.

## Evidence bar

Show a concrete input/state and reachable path producing the wrong outcome. If the expected behavior is undocumented, name the uncertainty instead of inventing a requirement. A suspicious pattern or unusual syntax is insufficient without a behavioral consequence.
