# Frontend Components

A component is a module. Everything in [`DESIGNING_MODULES.md`](DESIGNING_MODULES.md) applies: deep interface, small surface, explicit dependencies, no leaky internals. This file holds the framework-agnostic rules shared by React and Vue; the framework files add idiom-specific detail.

## Vocabulary

**Presentational Component** — Renders from props/inputs, holds no app state, performs no I/O. Pure and trivially testable.

**Container / Feature Component** — Composes presentational components, owns local UI state, and wires data fetching and mutations at the boundary.

**Derived State** — A value computed from props/state/server data. It is computed, never stored or effect-synced.

**Server State** — Data owned by the server, fetched and cached (TanStack Query). Distinct from client/UI state. Not duplicated into local state.

**Boundary Parse** — Untrusted external data (API responses, form input, route/query params, `localStorage`) parsed with a schema (Zod) before it reaches component logic — same rule as [`BOUNDARIES_AND_PARSING.md`](BOUNDARIES_AND_PARSING.md).

## Non-negotiables

- External data entering a component (API responses, form values, route/search params, storage) is parsed at the boundary before component logic uses it. Components do not trust `as` on fetched JSON.
- Derived values are computed, not stored in state and not synchronized by effects.
- Server state lives in the server-state layer (TanStack Query), not copied into component state.
- Props are not mutated; a component does not write to objects/arrays it received.
- Lists rendered from data use stable, identity-based keys — never array index when items reorder, insert, or delete.
- Components do not embed secrets, tokens, or raw credentials in markup, attributes, or client bundles.
- Interactive elements use the correct semantic element/role and are keyboard-reachable; non-text content has accessible names.

## Strong defaults

- **Keep components presentational by default.** Push state and data fetching up to a small number of container/feature components. A deep tree of stateful components is harder to test and reason about than a shallow shell over pure leaves.
- **Server state → TanStack Query.** Fetching, caching, loading/error states, and invalidation belong to query/mutation hooks, not hand-rolled effects + state.
- **Client state minimal and local.** Prefer local state; lift only when genuinely shared. Reach for a global store (Pinia in Vue; a store lib in React) only when state is truly cross-cutting — see the framework files.
- **Parse at the edge with Zod.** API and form boundaries get a Zod schema; the inferred type is the domain shape passed inward. Schema and inferred type share one name (see [`TYPESCRIPT_CONTRACTS.md`](TYPESCRIPT_CONTRACTS.md)).
- **Tailwind for styling.** Compose utility classes; extract a component (not a custom CSS layer) when a pattern repeats. Keep conditional classes readable via a `clsx`/`cn`-style helper rather than ad-hoc string concatenation.
- **Co-locate.** Component, its styles, its local hooks/composables, and its tests live together.

## Prop design

Props are the component's interface — design them as deeply as any function signature.

- **Model legal states; make illegal props unrepresentable.** Prefer a discriminated union of prop shapes over a bag of optional booleans.

```ts
// Avoid: illegal combinations are representable (loading + error + data all set)
type Props = {
  data?: User;
  isLoading?: boolean;
  error?: string;
};

// Prefer: a discriminated union — exactly one state at a time
type Props =
  | { status: "loading" }
  | { status: "error"; message: string }
  | { status: "ready"; user: User };
```

- **Avoid boolean explosion.** Three booleans encode eight states, most illegal. Use a variant/union (`variant: "primary" | "ghost"`) instead of `isPrimary` + `isGhost`.
- **Pass parsed domain values, not raw DTOs.** A component receives `User`, not an unparsed fetch body.
- **Required by default; optional only when absence is meaningful.** Do not make props optional to dodge wiring them.

### Prop ordering

Order prop declarations and prop sites consistently:

1. **Data props first, then callback props** — two groups.
2. Within each group, sort by name in **ABC order**.

```ts
type ButtonProps = {
  // data props, ABC
  disabled?: boolean;
  label: string;
  variant: "ghost" | "primary";
  // callback props, ABC
  onClick: () => void;
  onFocus?: () => void;
};
```

This is a strong recommendation, not a hard rule — a logical grouping that reads better (e.g. grouping related props) is acceptable when intentional. Additional logical-ordering preferences (prop-type grouping, member specifiers) may apply; follow the established pattern in the file you are editing and ask when ambiguous.

## Data fetching and forms

- Fetching, caching, and invalidation go through TanStack Query hooks. Components consume `data`/`error`/`status`, they do not orchestrate `fetch` + `useState` + `useEffect` by hand.
- Mutations go through mutation hooks with explicit invalidation/optimistic update; surface typed errors (matching the repo's error idiom — see [`ERROR_HANDLING.md`](ERROR_HANDLING.md)).
- Form input is untrusted: parse with Zod on submit (or per-field), and pass the parsed value to the mutation. Validation messages derive from the parse result.
- Loading and error are first-class render states, not afterthoughts — every data-driven component renders all of `loading`, `error`, `empty`, and `ready` intentionally.

## Accessibility baseline

- Use semantic elements (`button`, `a`, `label`, `nav`, headings) before reaching for `div` + role.
- Every interactive control is keyboard-operable and focus-visible.
- Inputs have associated labels; icon-only controls have accessible names.
- Color is not the sole carrier of meaning; respect reduced-motion preferences for animation.

## Review checklist

Use this as the final scan after applying the rules above; the rule source of truth remains in the relevant sections.

- Fetched/form/route data used without a boundary parse (`as` on a response).
- Server data copied into local component state instead of read from the query cache.
- Derived value stored in state or synced by an effect instead of computed.
- Boolean-prop explosion where a variant union belongs.
- Optional props used to avoid wiring them.
- `index` used as a list key for a reorderable/mutable list.
- Prop mutation, or mutating a received object/array.
- Missing loading/error/empty render states.
- Non-semantic, non-keyboard-reachable interactive elements.
- Ad-hoc class-string concatenation instead of a `cn`/`clsx` helper.
