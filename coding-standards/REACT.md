# React

React-specific rules. Read [`FRONTEND_COMPONENTS.md`](FRONTEND_COMPONENTS.md) first — component-as-module, prop design, server state, and accessibility live there. This file covers hooks, effects, derived state, rendering, and React-specific seams.

## Non-negotiables

- Hooks are called unconditionally at the top level — never in conditions, loops, or after an early return.
- Effects are for synchronizing with external systems, not for deriving state from props/state. Derived values are computed during render.
- Every effect declares a complete, honest dependency array; do not omit deps to suppress re-runs, and do not disable the exhaustive-deps lint without a `SAFETY:` justification.
- Effects that subscribe, open, or schedule return a cleanup that tears down exactly what they set up.
- List keys are stable item identities, not array indices for reorderable lists.
- Props and state are treated as immutable; never mutate them in place.

## Strong defaults

- **Derive, don't store.** Compute from existing props/state during render. Reach for `useMemo` only when a measured cost or referential-stability requirement justifies it — not by default.
- **`useEffect` is a last resort.** Before writing one, ask: is this derived state (compute it), an event response (handle it in the handler), or server state (TanStack Query)? Effects remain for genuine external synchronization (subscriptions, DOM measurement, non-React widgets, timers).
- **Server state → TanStack Query**, never `useEffect` + `useState` + `fetch`.
- **Lift state minimally.** Local `useState` first; lift to the nearest common owner only when shared. Context for genuinely cross-cutting, low-frequency values (theme, current user); a store library only when justified.
- **Stabilize callbacks at the boundary that needs it.** Use `useCallback`/`useMemo` to satisfy a memoized child or an effect dep, not reflexively everywhere.
- **Type props explicitly; no `React.FC`.** Declare a props type and a plain function component.

## Derived state, not effects

Avoid syncing derived state through an effect:

```tsx
// Avoid: extra render, stale-risk, effect for a pure computation
const [fullName, setFullName] = useState("");
useEffect(() => {
  setFullName(`${firstName} ${lastName}`);
}, [firstName, lastName]);
```

Compute during render:

```tsx
const fullName = `${firstName} ${lastName}`;
```

If the computation is expensive (measured), memoize it:

```tsx
const sortedRows = useMemo(() => rows.toSorted(compareRows), [rows]);
```

## Effects done right

An effect synchronizes with something outside React, with cleanup:

```tsx
useEffect(() => {
  const controller = new AbortController();
  socket.subscribe(roomId, { signal: controller.signal });
  return () => controller.abort();
}, [roomId]);
```

- The dependency array is exhaustive and honest.
- Cleanup mirrors setup.
- No data fetching here — that is TanStack Query's job.
- Event-driven work (a click, a submit) lives in the handler, not an effect watching a flag.

## Components and props

```tsx
type UserCardProps = {
  // data props, ABC
  highlighted?: boolean;
  user: User;
  // callback props, ABC
  onSelect: (id: UserId) => void;
};

function UserCard({ highlighted = false, user, onSelect }: UserCardProps) {
  return (
    <button
      className={cn("rounded-md p-3", highlighted && "ring-2 ring-blue-500")}
      onClick={() => onSelect(user.id)}
    >
      {user.displayName}
    </button>
  );
}
```

- Prop type declared and ordered per [`FRONTEND_COMPONENTS.md`](FRONTEND_COMPONENTS.md) (data then callbacks, ABC within each).
- Defaults via destructuring defaults / `??`, not `||`.
- No `React.FC`; explicit props type.

## Server components / framework data loading

In a server-component or loader-based framework (Next.js App Router, Remix/React Router):

- Fetch and parse on the server; pass parsed domain values to client components.
- Mark client components deliberately (`"use client"`) and keep the client boundary as small as the interactivity requires.
- Do not pass unserializable values or secrets across the server→client boundary.
- Client-side server state still flows through TanStack Query; the initial server fetch can hydrate it.

## State management

- **Local** (`useState`/`useReducer`) for component-owned UI state.
- **Context** for low-frequency cross-cutting values; do not put high-churn state in context (it re-renders all consumers).
- **Store library** (Zustand/Redux Toolkit) only when state is genuinely global, high-frequency, and shared across distant subtrees — justify it, don't reach for it by default.
- **Server state is not client state** — it belongs to TanStack Query regardless of the above.

## Review checklist

Use this as the final scan after applying the rules above; the rule source of truth remains in the relevant sections.

- `useEffect` deriving state that could be computed during render.
- `useEffect` + `fetch` + `useState` where TanStack Query belongs.
- Incomplete or lint-suppressed dependency arrays without justification.
- Missing effect cleanup for subscriptions/timers/listeners.
- Reflexive `useMemo`/`useCallback` with no memoized consumer or measured cost.
- `index` keys on reorderable lists.
- Mutating props or state in place.
- High-frequency state in Context, or a global store used for local state.
- Secrets or unserializable values crossing the server→client boundary.
