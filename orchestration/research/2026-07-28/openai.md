# OpenAI GPT-5.6 family re-validation

Research date: 2026-07-28. Scope: only `gpt-5.6-sol`, `gpt-5.6-terra`, and
`gpt-5.6-luna` presently listed in `orchestration/ROUTING.md`. Prices are USD
per 1M text tokens unless noted. "Documented" means a source fact; "inference"
is a routing recommendation, not a provider claim.

## Executive summary

All three exact IDs are current, generally available OpenAI API/Codex models,
not hypothetical aliases. `gpt-5.6` is specifically an alias for Sol. The
family has the same published 1.05M context, 128K output limit, six reasoning
efforts, image input, text output, function calling, structured outputs, and
Responses tools. [OpenAI models](https://developers.openai.com/api/docs/models)
[model guidance](https://developers.openai.com/api/docs/guides/latest-model)

The routing cost buckets are materially wrong under the required 3:1 workload:
Sol is **$$$$** ($11.25), Terra **$$$** ($5.625), and Luna **$$** ($2.25),
not `$$$`/`$$`/`$`. This is public standard synchronous API list pricing; it
does not establish Pi-reseller pricing or availability.

The public evidence supports the ordered capability claims Sol > Terra > Luna,
and benchmark-owner evidence reports Coding Agent Index scores 80/77/75 at
`max`. It does **not** publish the contemporary-frontier submission population
or a matching exact-model percentile for each of coding/agentic, reasoning, and
tool use. The rubric therefore requires **intelligence: unvalidated** for all
three rather than copying the current 9/8/7. A controlled route-level eval can
turn those raw results into scores.

For computer use, OpenAI's vendor-reported comparison gives standard Sol /
Terra / Luna **62.6% / 50.2% / 45.6%** on OSWorld 2.0 and **90.4% / 87.5% /
83.3%** on BrowseComp. The **92.2%** BrowseComp result is **Sol Ultra**, a
four-agent configuration, not ordinary single-agent Sol. [Launch comparison
table](https://openai.com/index/gpt-5-6/)

## Exact name and availability

| Exact model ID | Official position / alias | Current documented access | Confidence | Source |
|---|---|---|---|---|
| `gpt-5.6-sol` | Frontier complex-professional-work model; `gpt-5.6` alias routes here. | OpenAI API; Codex for Plus, Pro, Business, Enterprise; ChatGPT Sol availability varies by eligible plan. | High | [Models](https://developers.openai.com/api/docs/models), [ChatGPT availability](https://help.openai.com/en/articles/20001354-gpt-56-in-chatgpt/) |
| `gpt-5.6-terra` | Balance of intelligence and cost. | OpenAI API; Codex for Free/Go and Plus/Pro/Business/Enterprise; Work in ChatGPT for paid plans. | High | [Models](https://developers.openai.com/api/docs/models), [ChatGPT availability](https://help.openai.com/en/articles/20001354-gpt-56-in-chatgpt/) |
| `gpt-5.6-luna` | Cost-sensitive, high-volume model. | OpenAI API; Codex and Work in ChatGPT for Plus/Pro/Business/Enterprise. Not selectable in ordinary ChatGPT conversations. | High | [Luna card](https://developers.openai.com/api/docs/models/gpt-5.6-luna), [ChatGPT availability](https://help.openai.com/en/articles/20001354-gpt-56-in-chatgpt/) |

The July 9 announcement says the family is generally available, while the Help
article still warns that product rollout can be gradual; account/region/admin
entitlement remains a deployment check. [Launch](https://openai.com/index/gpt-5-6/)
[availability FAQ](https://help.openai.com/en/articles/20001354-gpt-56-in-chatgpt/)

## Pricing, limits, and reasoning

| Model | Standard input / cached input / output | Required cost calculation and bucket | Cache, batch, and limits | Reasoning and interfaces |
|---|---:|---|---|---|
| Sol | $5 / $0.50 / $30 | `0.75 × 5 + 0.25 × 30 = $11.25` → **$$$$** | Explicit cache write $6.25 (1.25× input); reads 90% discounted. Batch is 50% off but asynchronous (up to 24h), so excluded. Over 272K input: full request is 2× input and 1.5× output. Context 1,050,000; output 128,000. | `none`, `low`, `medium`, `high`, `xhigh`, `max`; also Responses `reasoning.mode: pro`. Chat Completions, Responses, Batch; text/image input, text output; function calling, structured outputs, web/file/computer tools. |
| Terra | $2.50 / $0.25 / $15 | `0.75 × 2.5 + 0.25 × 15 = $5.625` → **$$$** | Explicit cache write $3.125; otherwise same published cache, batch, long-prompt, context, and output rules. | Same published reasoning efforts, pro mode, endpoints, modalities, and supported tool/features. |
| Luna | $1 / $0.10 / $6 | `0.75 × 1 + 0.25 × 6 = $2.25` → **$$** | Explicit cache write $1.25; otherwise same published cache, batch, long-prompt, context, and output rules. | Same published reasoning efforts, pro mode, endpoints, modalities, and supported tool/features. |

Standing-price evidence: [Sol card](https://developers.openai.com/api/docs/models/gpt-5.6-sol),
[comparison](https://developers.openai.com/api/docs/models/compare), and
[Luna card](https://developers.openai.com/api/docs/models/gpt-5.6-luna). Cache
reads are 90% discounted and writes are 1.25× input; `pro` bills the selected
model's ordinary token rates but can increase total tokens/latency. [Guidance](https://developers.openai.com/api/docs/guides/latest-model)
Batch's 50% discount and 24-hour completion window are documented separately.
[Batch FAQ](https://help.openai.com/en/articles/9197833-batch-api-faq)

Tool-call, image-token, and provider/reseller charges are outside this token
calculation. No promotion was found in the official price/model pages.

## Benchmark evidence

| Domain | Exact-model result | Protocol / provenance | What it establishes | Rubric limitation |
|---|---|---|---|---|
| Coding/agentic | Artificial Analysis Coding Agent Index v1.1, `max`, Codex: Sol **80**, Terra **77**, Luna **75**. Sol leads; its component suite is DeepSWE, Terminal-Bench v2, and SWE-Atlas-QnA. | Benchmark owner evaluated pre-release models; harness/settings are named, not interchangeable with this repo's Pi route. | Exact family ordering and strong coding-agent evidence. | The cited release does not publish a fixed contemporary-frontier population/rank for each entry, so a 1–10 percentile conversion is not defensible. |
| Reasoning | Artificial Analysis Intelligence Index v4.1, `max`: Sol **59**, Terra **55**, Luna **51**. The aggregate includes reasoning, coding/terminal, tool/agentic, professional, and long-context evaluations. | Independent benchmark owner; its July 2026 report and model pages. | Strong cross-domain raw evidence, but it is an aggregate rather than a pure reasoning result. | No exact per-model contemporary-frontier percentile suitable for this rubric. Do not infer one from its broad all-history population. |
| Tool use / computer use | OpenAI vendor-reported standard single-agent results: OSWorld 2.0 Sol/Terra/Luna **62.6% / 50.2% / 45.6%**; BrowseComp **90.4% / 87.5% / 83.3%**. Separately, Sol Ultra scores **92.2%** BrowseComp. All three API cards list web search, file search, computer use, MCP, hosted shell, apply patch, and tool search as supported. | OpenAI launch comparison; its notes specify Ultra uses four agents and aggregate multi-agent tokens/cost. Model-card capability listing. | Exact-model family ordering for this vendor-evaluated computer-use evidence; no claim that Ultra equals ordinary Sol. | These are provider-reported and no contemporary-frontier percentile is published for the rubric; deployment/harness does not transfer automatically to Pi. |
| Safety limitation relevant to agents | OpenAI system card: overwrite avoidance / avoidance+correctness: Sol **.83/.44**, Terra **.81/.37**, Luna **.73/.32**. | Vendor system-card eval. | Smaller variants showed lower performance on this destructive-action proxy. | Not an intelligence measure; validate local edit-safety policy/harness. |

Sources: [Artificial Analysis GPT-5.6 evaluation](https://artificialanalysis.ai/articles/gpt-5-6-has-landed),
[Artificial Analysis frontier update](https://artificialanalysis.ai/articles/four-frontier-launches-in-eight-days-six-labs-now-field-a-model-above-50-on-the-artificial-analysis-intelligence-index),
[OpenAI launch](https://openai.com/index/gpt-5-6/),
[system card (PDF)](https://deploymentsafety.openai.com/gpt-5-6-preview/gpt-5-6-preview.pdf).
OpenAI's numbers are vendor-reported; Artificial Analysis is the benchmark
owner, but its published index must not be recast as the required percentile.

### Intelligence-rubric decision

Required weighting is coding/agentic 60%, reasoning 25%, tool use 15%. A
weighted 1–10 score cannot be calculated without defensible domain percentiles.
Although coding/agentic plus another domain have raw exact-model evidence, the
rubric permits reweighting only when those domains can be scored. Recommendation:
keep raw evidence and set all three Intelligence fields to **`unvalidated`**;
do not preserve 9/8/7 as facts. Confidence: high for the *unvalidated* decision,
medium for the observed Sol > Terra > Luna ordering.

## Current versus recommended cards

### `gpt-5.6-sol`

| Field | Current | Recommended | Confidence | Fact or inference | Rationale |
|---|---|---|---|---|---|
| Cost | `$$$` | **`$$$$`** | High | Fact | $11.25 required blended standing API calculation. |
| Intelligence | `9` | **`unvalidated`** | High | Rubric application | Raw Index: coding 80; aggregate intelligence 59; standard single-agent BrowseComp/OSWorld evidence is reported for all three. Required percentiles missing. |
| Taste | `6` | **`unvalidated`** | High | Evidence gap | Artificial Analysis says Sol (max) has highest Presentation Elo, but its public release gives neither the Elo value nor a protocol sufficient to map that claim to a 1–10 taste score. OpenAI's design claims are vendor-reported. |
| Best fit | hardest agentic coding | **High-value, difficult coding/reasoning and user-facing artifact work; use `max`/`pro` only after task eval.** | Medium | Lead inference | Strongest family raw coding and vendor-reported standard single-agent tool results; standing price is highest and Pi availability/latency is unknown. Do not substitute the four-agent Ultra result for ordinary Sol. |

### `gpt-5.6-terra`

| Field | Current | Recommended | Confidence | Fact or inference | Rationale |
|---|---|---|---|---|---|
| Cost | `$$` | **`$$$`** | High | Fact | $5.625 required blended standing API calculation. |
| Intelligence | `8` | **`unvalidated`** | High | Rubric application | Raw Index: coding 77; aggregate intelligence 55. No defensible domain-percentile conversion. |
| Taste | `5` | **`unvalidated`** | High | Evidence gap | Documentation makes a family-level frontend claim, but no exact Terra qualitative or empirical design/writing evaluation supports a 1–10 score. |
| Best fit | clear-spec implementation, bulk work, independent review | **Candidate for cost-balanced coding after a route-level eval; not established as cheap bulk work at the prescribed price basis.** | Medium | Lead inference | Second family coding score and lower price than Sol; still $5.625 blended and Pi execution is unverified. |

### `gpt-5.6-luna`

| Field | Current | Recommended | Confidence | Fact or inference | Rationale |
|---|---|---|---|---|---|
| Cost | `$` | **`$$`** | High | Fact | $2.25 required blended standing API calculation. |
| Intelligence | `7` | **`unvalidated`** | High | Rubric application | Raw Index: coding 75; aggregate intelligence 51. No defensible domain-percentile conversion. |
| Taste | `4` | **`unvalidated`** | High | Evidence gap | No exact Luna writing/design/UI assessment supports a score. |
| Best fit | high-volume / cheap mechanical tasks | **High-volume, lower-risk work where measured quality clears the task bar; do not label it the cheapest `$` route under this rubric.** | Medium | Lead inference | Officially cost-sensitive/high-volume, fastest family member; lower raw scores and destructive-action proxy warrant a task-specific check. |

## Contradictions with current `ROUTING.md`

1. All three cost buckets conflict with the mandated formula: Sol `$$$ → $$$$`,
   Terra `$$ → $$$`, Luna `$ → $$`.
2. Numeric Intelligence 9/8/7 has no recorded percentile calculation, benchmark
   population, protocol, or confidence; under the supplied rubric each must be
   `unvalidated`, with raw evidence retained.
3. Taste 6/5/4 is undocumented. Artificial Analysis reports Sol's highest
   Presentation Elo, but no public numeric value/protocol maps it defensibly to
   a 1–10 taste score; all three should remain `unvalidated` pending a blind
   route-level evaluation.
4. `Harness` says Codex, while role routes/fallbacks say the GPT-5.6 models run
   via Pi and "Codex is not part" of the routing scheme. Official docs confirm
   Codex access, but do not establish this repo's Pi model transport. Resolve
   the internal contradiction and validate the executor listing before routing.
5. "cheapest" Luna / "bulk" Terra is relative family positioning, not proof of
   those roles against the other listed providers or a 3:1 API workload.

## Unresolved gaps and empirical evaluation needs

1. Obtain the actual Pi provider/model listing, price card, supported effort
   values, context/output caps, and whether requests reach the named OpenAI IDs.
   API availability does not prove Pi availability.
2. Establish the route harness: tool set, sandbox, patch policy, retry/fallback,
   context truncation, and whether `max`/`pro` are actually exposed. Published
   Codex/Responses benchmarks do not transfer automatically to Pi.
3. Run a fixed evaluation set across all three and competing candidates, with
   identical repository/task/tool budgets. Record success, review defects,
   destructive-edit/approval errors, wall time, actual input/output/cache/tool
   cost, and output quality. Repeat enough times to expose variance.
4. To score Intelligence, define a dated contemporary-frontier population and
   use its benchmark-owner leaderboard/harness per domain. Store exact ranks,
   submissions, protocols, and percentile mappings before calculating
   60/25/15. Do not score from vendor comparison charts.
5. To score Taste, blind-rate exact-model user-facing writing/UI outputs against
   a stable brief and rubric. Keep this distinct from coding success.
6. Check safeguard intervention/latency on legitimate dual-use defensive tasks;
   OpenAI documents real-time cyber/biology classifiers that can refuse or pause
   generation. [Model guidance](https://developers.openai.com/api/docs/guides/latest-model)

## Sources

| Source | Type | Accessed | Used for |
|---|---|---:|---|
| [OpenAI Models](https://developers.openai.com/api/docs/models) | Provider model catalog | 2026-07-28 | IDs, alias, limits, reasoning, base capabilities |
| [OpenAI model comparison](https://developers.openai.com/api/docs/models/compare) | Provider model cards | 2026-07-28 | Exact prices, cache prices, endpoints, rate limits |
| [OpenAI GPT-5.6 guidance](https://developers.openai.com/api/docs/guides/latest-model) | Provider docs | 2026-07-28 | Reasoning/pro modes, cache, PTC, multi-agent beta, limitations |
| [OpenAI GPT-5.6 launch](https://openai.com/index/gpt-5-6/) | Provider launch | 2026-07-28 | GA, vendor-reported benchmark/tool/design claims, availability/pricing |
| [OpenAI availability FAQ](https://help.openai.com/en/articles/20001354-gpt-56-in-chatgpt/) | Provider help | 2026-07-28 | Product-plan/Codex/API access caveats |
| [OpenAI Batch FAQ](https://help.openai.com/en/articles/9197833-batch-api-faq) | Provider help | 2026-07-28 | 50% batch discount and 24-hour async window |
| [Artificial Analysis GPT-5.6 evaluation](https://artificialanalysis.ai/articles/gpt-5-6-has-landed) | Benchmark owner | 2026-07-28 | Index scores, harness, methodology summary |
| [Artificial Analysis frontier update](https://artificialanalysis.ai/articles/four-frontier-launches-in-eight-days-six-labs-now-field-a-model-above-50-on-the-artificial-analysis-intelligence-index) | Benchmark owner | 2026-07-28 | Dated comparative raw scores/rank statements |
| [OpenAI GPT-5.6 system card (PDF)](https://deploymentsafety.openai.com/gpt-5-6-preview/gpt-5-6-preview.pdf) | Provider system card | 2026-07-28 | Safety, overwrite and capability limitations |
