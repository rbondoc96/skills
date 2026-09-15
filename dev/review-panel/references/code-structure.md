# Code structure and simplicity

Own local module boundaries, abstraction cost, type modeling, readability, and unnecessary complexity. Architecture owns responsibilities and dependencies across packages/services. UI/UX owns the user-facing experience.

## Investigate

- Compare interface size with the complexity hidden behind it. Find exposed implementation details, caller coordination, and changes that must be repeated across consumers.
- Examine whether types express valid states and semantically distinct values. In TypeScript, consider inference and discriminated/refined types where they eliminate concrete mistakes; respect project conventions.
- Look for unnecessary wrappers, speculative flexibility, duplicated knowledge, tangled responsibilities, and abstraction that makes ordinary work harder.
- Check whether names and comments explain the model and its non-obvious constraints accurately.

## Evidence bar

Show the concrete maintenance cost: which callers must coordinate, what knowledge is repeated, what invalid state is representable, or which routine change becomes harder. Suggest the smallest useful improvement and its tradeoff. Personal style preferences and demands for blanket rewrites do not establish value.
