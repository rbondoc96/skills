# Orchestration model research

Research date: 2026-07-28.

This directory re-validates every model card currently listed in
`orchestration/ROUTING.md`. It recommends changes; it does not modify the
routing table.

## Outcome

- All 14 listed model names resolve to current models or live OpenCode Go
  aliases.
- The current cost symbols are not comparable. Direct API list price, a
  subscription, and subscription-allowance burn are different measurements.
- The prescribed public-benchmark rubric cannot defend any current 1–10
  Intelligence score. Preserve raw evidence and mark all 14 `unvalidated`.
- No source supports a calibrated 1–10 Taste score. Mark all 14 `unvalidated`
  until a blind maintainer evaluation exists.
- Best-fit descriptions remain useful only as explicitly labeled lead
  inferences. Validate them on the actual model + executor + settings route.
- Several current Thinking values describe upstream behavior but are invalid Pi
  CLI arguments. Store executor arguments separately from provider semantics.

The practical consequence is not “all models are equal.” Public evidence gives
useful ordering and capability signals. It does not justify the current
precision or route portability.

## Artifacts

| Artifact | Coverage |
|---|---|
| [OpenAI](./openai.md) | `gpt-5.6-sol`, `gpt-5.6-terra`, `gpt-5.6-luna` |
| [Anthropic](./anthropic.md) | `sonnet-5`, `opus-5` |
| [GLM and Kimi](./glm-kimi.md) | GLM-5.2/5.1 and Kimi K2.6/K2.7 Code through OpenCode Go |
| [Qwen, MiniMax, and DeepSeek](./qwen-minimax-deepseek.md) | Qwen 3.7 Max/Plus, MiniMax M3, and DeepSeek V4 Pro/Flash through OpenCode Go |
| [Executor contracts](./executors.md) | `codex`, `pi`, and `claude -p` CLI evidence; researched separately |

## Method

### Source rules

Use, in descending order:

1. Provider model catalogs, API docs, pricing, and system/model cards.
2. First-party executor and transport model listings.
3. Benchmark-owner leaderboards and reports.
4. Provider-reported benchmarks, clearly labeled as vendor-reported.

Aggregators, SEO summaries, and unsourced reviews do not support scores. A
provider benchmark can establish a raw result, not an independent rank.

### Cost

For a standing, standard-priority, uncached public API:

```text
blended cost = 0.75 × input price + 0.25 × output price
```

| Bucket | Blended USD per 1M tokens |
|---|---:|
| `$` | ≤ $1.50 |
| `$$` | > $1.50–$4.00 |
| `$$$` | > $4.00–$10.00 |
| `$$$$` | > $10.00 |

Promotions, caching, batch pricing, long-context multipliers, and priority
processing are separate. A subscription route without a standing marginal
token bill is `unvalidated`; its allowance-accounting rates remain operational
context.

### Intelligence

The proposed evidence model weighted coding/agentic 60%, reasoning 25%, and
tool use 15%. It required exact-model, benchmark-owner rankings against a dated
contemporary population. Missing domains could be reweighted only when
coding/agentic and one other domain were both defensibly scored.

No card cleared that gate. The common blockers were:

- vendor-only results;
- missing or changing leaderboard populations;
- incompatible scaffolds, reasoning settings, and tool budgets;
- aggregate indexes that do not isolate the required domains;
- direct-provider results applied to a different executor/transport.

Do not manufacture a number. Store raw result, benchmark version, harness,
settings, date, provenance, and confidence; make the normalized score optional.

### Taste and best fit

Taste is a maintainer preference, not an intelligence benchmark. Documented
writing, UI, vision, or design capability can select eval candidates but cannot
produce a 1–10 score.

Best fit is a lead inference from capability, route cost, latency, context,
tools, availability, and limitations. It is never a provider fact.

### Rubric clarifications

The thresholds and evidence gate did not change after dispatch. Review added
three clarifications:

- `rank / population` is not automatically a conventional percentile;
- subscription accounting rates are not a standing marginal token bill;
- an upstream “thinking on” behavior is not a valid executor argument.

## Recommended cards

`Route cost` below describes the configured route where known. `API reference`
is only a comparison baseline; it may not match Codex, Claude, or Go
subscription billing.

### OpenAI and Anthropic

| Model | Effort recommendation | Route cost / API reference | Intelligence | Taste | Best-fit inference | Confidence |
|---|---|---|---|---|---|---|
| `gpt-5.6-sol` | Keep `high` as an explicit route choice; use `max`/`pro` only after task evaluation. | Codex billing: unresolved. API: `$$$$`, $11.25 blend. | `unvalidated`; strongest raw GPT-5.6 family evidence. | `unvalidated` | High-value difficult coding, reasoning, and user-facing artifact work. | Medium |
| `gpt-5.6-terra` | Keep `medium` as an explicit route choice, not a provider default claim. | Codex billing: unresolved. API: `$$$`, $5.625 blend. | `unvalidated`; middle raw family result. | `unvalidated` | Cost-balanced coding candidate after a route-level evaluation. | Medium |
| `gpt-5.6-luna` | Keep `low` as an explicit route choice after quality calibration. | Codex billing: unresolved. API: `$$`, $2.25 blend. | `unvalidated`; lowest raw family result. | `unvalidated` | High-volume, lower-risk work where measured quality clears the task bar. | Medium |
| `sonnet-5` | `high` is the documented Claude API/Claude Code default; do not label `low` the default. | Claude executor billing: unresolved. Standing API: `$$$`, $6 blend; current promotion is separate. | `unvalidated` | `unvalidated` | Agentic implementation and routine-but-real coding/tool workflows; current “mechanical coordination” description is too narrow. | Medium |
| `opus-5` | `high` is the documented default; select higher effort only after evaluation. | Claude executor billing: unresolved. API: `$$$`, $10 blend. | `unvalidated`; strong new raw evidence. | `unvalidated` | Capability-sensitive coding, long-context investigation, and code review. | Medium |

OpenAI's official catalog confirms all three exact IDs, 1.05M context, 128K
output, six reasoning levels, and API prices. Its launch comparison also
separates ordinary Sol from four-agent Sol Ultra; BrowseComp 92.2 belongs to
Ultra, not single-agent Sol. See [OpenAI research](./openai.md).

Anthropic's official model and pricing docs confirm the two pinned IDs, 1M
context, 128K synchronous output, API prices, adaptive thinking, and `high`
defaults. See [Anthropic research](./anthropic.md).

### OpenCode Go routes

All nine routes below are live aliases, but Go is a $10/month subscription
after the first-month offer. Therefore every actual route cost is
`unvalidated`. Upstream API blends are comparison context only.

| Model | Pi Thinking recommendation | Upstream API reference | Intelligence | Taste | Best-fit inference | Confidence |
|---|---|---|---|---|---|---|
| `opencode-go/glm-5.2` | `default`; omit the flag until Go mapping is probed. | `$$`, $2.15 | `unvalidated` | `unvalidated` | Repository-scale investigation/planning and long-horizon coding candidate. | Medium |
| `opencode-go/glm-5.1` | `default`; current `on` is invalid Pi syntax. | `$$`, $2.15 | `unvalidated` | `unvalidated` | Text-only general fallback when the smaller Go output cap is acceptable. | Low |
| `opencode-go/kimi-k2.6` | `default`; current `on` is invalid Pi syntax. | `$$`, $1.7125 | `unvalidated` | `unvalidated` | Multimodal general-agent fallback; evaluate writing preference locally. | Medium |
| `opencode-go/kimi-k2.7-code` | `default`; current `always-on` is invalid Pi syntax. Upstream remains always-thinking. | `$$`, $1.7125 | `unvalidated` | `unvalidated` | Coding-throughput candidate with an always-thinking upstream token/latency budget. | Medium |
| `opencode-go/qwen3.7-max` | `default` until Go mapping is probed. | `$$`, $3.75 | `unvalidated` | `unvalidated` | Text-only, long-context coding/reasoning where allowance burn is acceptable. | Medium |
| `opencode-go/qwen3.7-plus` | `default` until Go mapping is probed. | `$` ≤256K; `$$` >256K | `unvalidated` | `unvalidated` | Image/screen-aware coding and general agent work. | Medium |
| `opencode-go/minimax-m3` | `default` until Go mapping is probed. | `$` ≤512K; `$$` above 512K at list price | `unvalidated` | `unvalidated` | Long-context multimodal repository/document work; validate >512K service first. | Medium |
| `opencode-go/deepseek-v4-pro` | `default` initially; test mapped `high` before adopting it. Current `on` is invalid. | `$`, $0.54375 | `unvalidated` | `unvalidated` | Text-only difficult debugging/reasoning and independent review candidate. | Medium |
| `opencode-go/deepseek-v4-flash` | `default` initially; test mapped `high` before adopting it. Current `on` is invalid. | `$`, $0.175 | `unvalidated` | `unvalidated` | High-throughput mechanical transformations and low-risk exploration. | Medium |

OpenCode's first-party Go docs confirm all nine aliases, endpoints, subscription
limits, and accounting rates. Pi 0.80.10 independently lists their
route-specific context, output, reasoning, and image metadata. Official
upstream docs confirm the cited canonical names, prices, context, modalities,
and thinking controls. They do not prove deployment or feature parity behind
Go. See [GLM/Kimi](./glm-kimi.md) and
[Qwen/MiniMax/DeepSeek](./qwen-minimax-deepseek.md).

## Largest routing corrections

1. **Split cost by basis.** OpenAI and Anthropic public API buckets are mostly
   one tier higher than the current cards. Go subscriptions cannot use those
   same symbols as actual route cost.
2. **Remove false score precision.** Every Intelligence and Taste integer lacks
   the required evidence trail. Keep raw evidence and `unvalidated` state.
3. **Separate executor from provider.** A model's upstream API result, context,
   price, or reasoning control does not automatically transfer through Codex,
   Claude, Pi, or OpenCode Go.
4. **Repair Thinking values.** Pi 0.80.10 accepts
   `off|minimal|low|medium|high|xhigh|max`. It rejects current `on` and
   `always-on` values when `PI.md` forwards them directly.
5. **Correct defaults.** Sonnet 5 and Opus 5 default to `high`; GLM-5.2 direct
   Z.AI defaults to `max`, but that does not prove Go mapping.
6. **Fix route assumptions.** Qwen Max's exact Go route is text-only. Kimi K2.7
   Code does not imply HighSpeed. GLM-5.1's Go output metadata is materially
   lower than the upstream limit.
7. **Resolve stale price evidence.** DeepSeek's current price page conflicts
   with its Pi integration example. Use current route metadata and treat the
   integration price as stale or a different tier.
8. **Keep Sol Ultra separate.** Multi-agent Ultra benchmark results cannot be
   attributed to ordinary single-agent Sol.

## Recommended routing schema

A single model row currently mixes facts from different layers. Represent:

```text
host
provider
model
executor
transport
executor_argument
provider_behavior
availability
billing_model
api_reference_cost
route_allowance_cost
capability_evidence
local_eval
best_fit
fallback
```

Recommended field changes:

- Replace `Cost` with `billing model`, `reference API blend`, and
  `route budget/allowance`.
- Replace mandatory Intelligence with raw evidence plus optional
  `validated score`.
- Replace Taste with a dated `maintainer preference` result and eval ID.
- Split `Default thinking` into `executor argument` and
  `observed provider behavior`.
- Attach confidence and last-validated date to route-level fields.

## Empirical calibration

Evaluate the route, not the marketing name.

### Phase 0: controls

- Confirm selected model ID, transport, and region where observable.
- Probe omitted and accepted effort values without assuming upstream mapping.
- Confirm tools, image input, context/output caps, structured output, caching,
  refusal behavior, and allowance consumption.
- Record executor version, settings, prompt, response metadata, time, and cost.

### Phase 1: routing screen

Run one fixed attempt per route on:

- two repository implementation tasks;
- one debugging task;
- one repository synthesis/planning task;
- one code-review task;
- one tool-heavy research task.

Use the same task inputs, allowed tools, time/token limits, retry policy, and
acceptance checks. Record completion, defects, destructive-edit errors,
reviewer findings, wall time, tokens, cache, and actual bill or allowance burn.
Do not convert this small screen into a 1–10 score.

### Phase 2: calibrated finalists

For routes that pass the screen, run at least three independent attempts on a
larger balanced suite. Publish tasks, harness versions, settings, graders,
failures, variance, and date. Prefer task-shape profiles over one global
Intelligence number.

### Taste evaluation

Use separate prose, API-design, and UI tasks:

1. Generate outputs from the actual routes with fixed briefs and budgets.
2. Remove model/provider identifiers and randomize presentation order.
3. Reject outputs that fail correctness or accessibility gates.
4. Compare survivors pairwise on clarity, hierarchy, coherence, restraint,
   usefulness, and task-specific craft.
5. Repeat finalist routes at least three times.
6. Store a dated maintainer-preference result with sample size and variance.

Do not merge taste with coding correctness.

## Verification

The lead inspected every family artifact, recalculated all cost blends, checked
internal consistency, and ran local executor/model-list checks. Material claims
were independently checked as follows:

| Models | Independently checked claims |
|---|---|
| GPT-5.6 Sol/Terra/Luna | Exact IDs/alias, input/output prices, context/output, reasoning levels, and per-model tool results in official OpenAI sources. |
| Sonnet 5/Opus 5 | Exact pinned IDs, prices/promotion, context/output, adaptive thinking, and `high` defaults in official Anthropic sources. |
| GLM-5.2/5.1 | Go aliases/endpoints/accounting plus Pi context/output metadata; Z.AI canonical IDs, prices, and direct-provider controls. |
| Kimi K2.6/K2.7 Code | Go aliases/accounting plus Pi limits/modalities; Kimi prices, 256K context, toggleable K2.6 thinking, and always-thinking K2.7 behavior. |
| Qwen 3.7 Max/Plus | Go aliases/accounting plus Pi limits/modalities; Qwen canonical IDs, prices, 1M context, and text-only versus multimodal distinction. |
| MiniMax M3 | Go alias/accounting plus Pi limits/modalities; MiniMax canonical capitalization, 1M/512K caveat, multimodality, and provider-reported BrowseComp result. |
| DeepSeek V4 Pro/Flash | Go aliases/accounting plus Pi limits/modalities; DeepSeek prices, 1M context, 384K output, dual thinking modes, and concurrency limits. |

Four family research tasks ran on the approved GPT-5.6 Terra/high route. The
GLM/Kimi owner spawned one inherited-model helper for read-only GLM/OpenCode
source collection. The lead constrained it from writing or further
delegation, audited its returned claims, and confirmed no helper file existed.
The owner rejected an inconsistent vendor Terminal-Bench value and retained the
value from the cited technical table without using it for normalization.

## Unresolved

- Actual Codex and Claude subscription billing versus API-equivalent cost.
- OpenCode Go deployment provenance, region, pinning, feature parity, and
  effort mapping.
- Go post-allowance balance pricing and allowance behavior in the subscribed
  account.
- Opus 5 consumer/Claude Code availability on the user's plan.
- Stable benchmark-owner populations spanning the required domains.
- Route-level latency, reliability, refusals, destructive-edit behavior, and
  local task quality.
- Any empirical maintainer taste preference.
