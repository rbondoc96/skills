# Vue

Vue-specific rules (Vue 3, `<script setup>`, Composition API). Read [`FRONTEND_COMPONENTS.md`](FRONTEND_COMPONENTS.md) first — component-as-module, prop design, server state, and accessibility live there. This file covers reactivity, props/emits, composables, and Pinia.

## Non-negotiables

- Use `<script setup lang="ts">` with the Composition API; no Options API in new components.
- Props are typed and declared with `defineProps<T>()`; children do not mutate props (one-way data flow). Two-way binding goes through `defineModel` / `update:` events.
- Derived values use `computed`, not a `watch` that writes back into a `ref`.
- Reactivity is preserved when destructuring: use `toRefs`/`storeToRefs`, never destructure a reactive source into plain variables.
- Effects that subscribe/open/schedule clean up (`onScopeDispose`, watcher stop handle, or `watchEffect` cleanup callback).
- External data (API, forms, route params) is parsed (Zod) before component logic uses it.

## Strong defaults

- **`ref` by default; `reactive` for cohesive object state.** Prefer `ref` for primitives and most values; use `reactive` only for a closely-related object whose fields change together. Don't mix the two for the same concept.
- **`computed` for derived state**, always — never a watcher mirroring one ref into another.
- **`watch`/`watchEffect` only for side effects** (fetch trigger via query, imperative DOM, external sync), not for deriving values.
- **Server state → TanStack Query (Vue Query)**, not hand-rolled `ref` + `onMounted` + `fetch`.
- **Composables for reusable stateful logic**, named `useX`, returning a small explicit interface of refs/computeds/methods — a deep module, not a bag of internals.
- **Pinia for shared/global state**, with `storeToRefs` at consumption sites. Keep stores cohesive; local UI state stays in the component.
- **Tailwind** for styling, per [`FRONTEND_COMPONENTS.md`](FRONTEND_COMPONENTS.md).

## Props and emits

Typed, ordered per [`FRONTEND_COMPONENTS.md`](FRONTEND_COMPONENTS.md) (data props ABC, then callbacks/emits):

```vue
<script setup lang="ts">
type Props = {
  // data props, ABC
  disabled?: boolean;
  label: string;
  variant?: "ghost" | "primary";
};

const { disabled = false, label, variant = "primary" } = defineProps<Props>();

const emit = defineEmits<{
  select: [id: UserId];
}>();
</script>
```

- `defineProps<T>()` with destructuring defaults (Vue 3.5+) or `withDefaults`.
- Typed `defineEmits`; event names describe what happened (`select`, `submit`), not handler names.
- `defineModel` for two-way binding rather than ad-hoc `modelValue` + `update:modelValue` plumbing.

## Reactivity correctness

Derive with `computed`:

```ts
const fullName = computed(() => `${firstName.value} ${lastName.value}`);
```

Avoid mirroring state through a watcher:

```ts
// Avoid: watcher writing derived state into another ref
const fullName = ref("");
watch([firstName, lastName], () => {
  fullName.value = `${firstName.value} ${lastName.value}`;
});
```

Preserve reactivity when pulling fields out:

```ts
// Avoid: destructuring a reactive/store drops reactivity
const { count } = store;

// Prefer:
const { count } = storeToRefs(store);
```

Clean up watchers/subscriptions:

```ts
const stop = watch(source, handler);
onScopeDispose(stop);
```

## Composables

A composable is a deep module — small interface, explicit dependencies, no leaked internals:

```ts
function useUser(id: Ref<UserId>) {
  const query = useQuery({
    queryKey: ["user", id],
    queryFn: () => fetchUser(id.value),
  });

  return {
    error: query.error,
    isLoading: query.isLoading,
    user: query.data,
  };
}
```

- Name `useX`; return refs/computeds/methods, not raw internal state.
- Accept dependencies as parameters (refs/getters) rather than reaching for module globals.
- Register lifecycle/cleanup inside the composable so callers don't have to.

## Pinia and state management

- **Local UI state** stays in the component (`ref`/`reactive`).
- **Shared/global state** goes in a Pinia store; keep stores cohesive and minimal.
- Consume store state via `storeToRefs` to keep reactivity; call actions directly.
- **Server state is not Pinia state** — it belongs to TanStack Query (Vue Query). Don't cache server responses in a store.

## Review checklist

Use this as the final scan after applying the rules above; the rule source of truth remains in the relevant sections.

- Options API in a new component, or missing `lang="ts"`.
- `watch` writing derived state that `computed` should own.
- Destructuring a `reactive`/store without `toRefs`/`storeToRefs` (lost reactivity).
- Prop mutation instead of `defineModel`/emit.
- `ref` + `onMounted` + `fetch` where Vue Query belongs.
- Server responses cached in a Pinia store.
- Composable leaking internal refs or relying on module globals.
- Missing cleanup for watchers/subscriptions.
- Untyped `defineProps`/`defineEmits`.
