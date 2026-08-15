# Route calibration

Use this process to replace provisional routing policy with observed
model + executor + settings evidence. Calibration consumes subscription
allowance; never start live probes without an approved route list, call budget,
and stop threshold.

## Record

Create a dated sibling workspace such as
`orchestration-calibration/2026-07-28/`. Record for every run:

- Task and acceptance checks
- Host, provider, model, executor, transport, and region when observable
- Model effort, tool permissions, isolation, and executor version
- Start/end time, result, retries, defects, and reviewer findings
- Subscription, reset window, observable allowance before/after, and
  throttling/fallback; record `unknown` when the surface exposes no meter
- Input/output/cache/tool usage when exposed

Keep provider estimates separate from measured local allowance burn.

## Phase 0: controls

Run local help and model-list checks first. For approved live probes:

1. Confirm the selected model and transport.
2. Probe omitted/default effort before explicit values.
3. Confirm tools, modalities, context/output limits, structured output, and
   refusal behavior only when the route needs them.
4. Stop on unexpected billing, fallback, model substitution, permission, or
   allowance behavior.

Complete when every candidate route is either reachable with recorded controls
or marked unavailable/unknown with evidence.

## Phase 1: routing screen

Run one fixed attempt per route on:

- Two repository implementation tasks
- One debugging task
- One repository planning task
- One code-review task
- One tool-heavy research task

Use identical task inputs, tools, time/token limits, retry policy, isolation,
and acceptance checks. Record completion, defects, destructive-edit errors,
wall time, and allowance burn. Do not turn this small screen into a global
intelligence score.

Complete when every screened route has the same six task results or a recorded
stop reason.

## Phase 2: finalists

Keep routes that pass the screen for at least one task shape. Run at least three
independent attempts on a larger balanced suite. Report pass rate, variance,
latency, allowance burn, failure modes, and date by task shape.

Prefer route profiles such as “review” or “clear-spec implementation” over one
cross-domain score.

## Taste

Evaluate prose, API design, and UI separately:

1. Generate outputs from exact routes with fixed briefs and budgets.
2. Remove model/provider identifiers and randomize order.
3. Reject outputs that fail correctness or accessibility gates.
4. Compare survivors pairwise on clarity, hierarchy, coherence, restraint,
   usefulness, and task-specific craft.
5. Repeat finalists at least three times.

Store the result as a dated maintainer preference with sample size and
variance. Never merge taste with coding correctness.

## Promote evidence

Update [`ROUTING.md`](ROUTING.md) only after recording the workspace path,
route versions, sample size, and confidence. Replace `unvalidated` allowance or
best-fit claims only for the exact measured route. Leave upstream provider
claims and different executors unvalidated.
