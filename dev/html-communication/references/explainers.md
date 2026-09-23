# Explainers

Use when the reader needs to understand how something works or why behavior changes.

1. State the idea to understand. Choose a concrete example and identify the knowledge the audience already has.
2. Build a progression: starting state, meaningful changes, resulting state. Use numbered steps for temporal or causal order; use a comparison when the relationship is not sequential.
3. Choose the smallest useful visual: code or pseudocode for logic, a tree for ownership or calls, a sequence for interactions over time, boxes and arrows for flow, or before/after views for a change. Keep labels and identities consistent across steps.
4. Place each visual beside the explanation it supports. Put optional definitions and observations in nearby notes. Keep failure conditions and warnings visible in the main path.
5. Add interaction only when changing an input, advancing a step, or revealing detail teaches something. Native disclosure works for secondary detail. Scripted controls need keyboard support, labeled state, and a useful script-free reading path.
6. Check that the visual agrees with the explanation and source behavior. Label illustrative examples and simplified boundaries explicitly.

Use the [component catalog](components.md) for reusable steps, sequence markup, notes, and code blocks. Borrow the [report branch](reports.md) when the explanation also supports a decision from evidence.

Done when the reader can trace the example from cause to outcome and understand where the explanation's assumptions stop applying.
