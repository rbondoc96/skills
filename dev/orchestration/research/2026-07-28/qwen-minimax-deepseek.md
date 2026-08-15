# OpenCode Go: Qwen 3.7, MiniMax M3, and DeepSeek V4

Research date: 2026-07-28. Scope is only the five `opencode-go/...` routes in
`ROUTING.md`. Prices are USD per 1M tokens. “Documented” is a source fact;
“inference” is a routing recommendation.

## Executive summary

These are **OpenCode Go subscription routes**, not direct upstream API
accounts. Go costs $5 for month one and $10/month afterwards, with a $12/5h,
$30/week, and $60/month *usage-value* allowance; it may fall back to a Zen
balance when enabled. Therefore every actual-route cost field is
**`unvalidated`** under the stated rubric, even though OpenCode publishes
token-value rates. Do not turn those rates into a per-call bill or a stable
`$` tier. [OpenCode Go](https://opencode.ai/docs/go/)

The provider-qualified form is an OpenCode configuration alias:
`opencode-go/<model-id>`. The canonical upstream identifiers are generally the
suffixes, with `MiniMax-M3` using upstream capitalization. The OpenCode Go
model-list endpoint and installed Pi catalog both list all five today. The
catalog shows 1M context, reasoning support, and the route-specific output and
image limits below. [Go endpoints](https://opencode.ai/docs/go/)
[Go model list](https://opencode.ai/zen/go/v1/models)

No integer intelligence or taste score survives the supplied rubric. Exact
model benchmark-owner rankings with contemporary populations were not found
for Qwen 3.7 Max/Plus, MiniMax M3, or DeepSeek V4 Pro/Flash; only vendor claims
and one vendor-run M3 BrowseComp result were located. Reweighting is not
allowed without coding/agentic evidence plus a second scored domain. Recommend
**`unvalidated`** for every intelligence and taste field pending a controlled
route-level evaluation.

## Alias, canonical model, and availability

| Routing alias | Go ID and transport | Canonical upstream model / status | Route facts | Confidence |
| --- | --- | --- | --- | --- |
| `opencode-go/qwen3.7-max` | `qwen3.7-max`; Anthropic Messages at `/zen/go/v1/messages` | QwenCloud `qwen3.7-max`, Qwen 3.7 Max. Current public base route is text-only; do not substitute visual snapshot `qwen3.7-max-2026-06-08`. | Go lists it; Pi lists 1M context, 65,536 output, text input, reasoning. | High |
| `opencode-go/qwen3.7-plus` | `qwen3.7-plus`; Anthropic Messages | QwenCloud `qwen3.7-plus`, Qwen 3.7 Plus. | Go lists it; Pi lists 1M context, 65,536 output, image/text input, reasoning. | High |
| `opencode-go/minimax-m3` | `minimax-m3`; Anthropic Messages | MiniMax `MiniMax-M3`. | Go lists it; Pi lists 1M context, 131,072 output, image/text input, reasoning. | High |
| `opencode-go/deepseek-v4-pro` | `deepseek-v4-pro`; OpenAI Chat Completions at `/zen/go/v1/chat/completions` | DeepSeek `deepseek-v4-pro` / DeepSeek-V4-Pro. | Go lists it; Pi lists 1M context, 384,000 output, text input, reasoning. | High |
| `opencode-go/deepseek-v4-flash` | `deepseek-v4-flash`; OpenAI Chat Completions | DeepSeek `deepseek-v4-flash` / DeepSeek-V4-Flash. | Go lists it; Pi lists 1M context, 384,000 output, text input, reasoning. | High |

OpenCode describes Go as a curated, globally hosted service and warns that its
model list can change. The unauthenticated list endpoint returned all five on
the research date, but subscription, account, allowance, regional service, and
rate-limit availability remain dispatch-time checks. [OpenCode Go](https://opencode.ai/docs/go/)
[Go model list](https://opencode.ai/zen/go/v1/models)

## Pricing, context, controls, and limits

### Actual Go route

| Route | Go published token-value input / output / cache read / write | Actual-route cost recommendation | Why | Output, modalities, controls |
| --- | --- | --- | --- | --- |
| Qwen Max | $2.50 / $7.50 / $0.50 / $3.125 | `unvalidated` | Subscription allowance is bundled, not an ordinary per-token invoice. | 1M / 65,536; text only. Pi catalog says reasoning, but exposes no per-level map. |
| Qwen Plus | ≤256K: $0.40 / $1.60 / $0.04 / $0.50; >256K: $1.20 / $4.80 / $0.12 / $1.50 | `unvalidated` | Same bundled allowance; cost changes after 256K. | 1M / 65,536; image + text. Pi catalog has no per-level map. |
| MiniMax M3 | $0.30 / $1.20 / $0.06 / no Go write price | `unvalidated` | Same bundled allowance. | 1M / 131,072; image + text. Pi catalog has no per-level map. |
| DeepSeek Pro | $0.435 / $0.87 / $0.003625 / no Go write price | `unvalidated` | Same bundled allowance. | 1M / 384,000; text only. Pi catalog maps only `high` and `max`. |
| DeepSeek Flash | $0.14 / $0.28 / $0.0028 / no Go write price | `unvalidated` | Same bundled allowance. | 1M / 384,000; text only. Pi catalog maps only `high` and `max`. |

The Go table is transport-specific evidence and matches the catalog's normal
input/output rates. Its allowance differs by model: Qwen Max and DeepSeek Pro
have $15 of monthly model usage; Qwen Plus, MiniMax M3, and DeepSeek Flash have $60. The stated 5h
request estimates are 950 / 4,300 / 3,200 / 3,450 / 31,650 respectively; they
are estimates from OpenCode's observed usage profile, not an SLA. [OpenCode Go](https://opencode.ai/docs/go/)

Pi accepts `off`, `minimal`, `low`, `medium`, `high`, `xhigh`, and `max`, not
`on`. Its installed Go catalog marks every route `reasoning: true`, but it
only maps DeepSeek `high` and `max`; it publishes no Qwen or M3 effort map.
Thus `high`, `medium`, and especially `on` in the routing table do **not** by
themselves prove the requested upstream reasoning setting reaches Go. For
DeepSeek Go routes, omit `--thinking` initially; adopt mapped `high` only
after a successful Go control-mapping probe. This is first-party
executor/catalog evidence, collected with `pi --help`,
`pi --list-models <id>`, and `~/.pi/agent/models-store.json` (Pi 0.80.10).

### Upstream API context only — not the Go route cost

| Upstream model | Standard uncached blend and rubric bucket | Context/output, reasoning, features/limits |
| --- | --- | --- |
| Qwen Max | `0.75×2.50 + 0.25×7.50 = $3.75` → `$$`. Current public page also displays a 50% promotion ($1.25/$3.75); exclude it from standing cost. | 1M context, 65,536 output, text only; Qwen API uses `enable_thinking`. Function calling, structured output, cache, batch, and web tools are documented upstream. |
| Qwen Plus | ≤256K: `0.75×0.40 + 0.25×1.60 = $0.70` → `$`; >256K: `0.75×1.20 + 0.25×4.80 = $2.10` → `$$`. Marketplace displays a 20% promotion; exclude it. | 1M context, 65,536 output; text/image/video input, text output. Upstream documents function calling, structured output, cache, batch, and web tools. |
| MiniMax M3 | Published list: ≤512K `0.75×0.60 + 0.25×2.40 = $1.05` → `$`; 512K–1M `0.75×1.20 + 0.25×4.80 = $2.10` → `$$`. The page separately displays a “permanent 50% off” current rate ($0.30/$1.20 and $0.60/$2.40); do not collapse that offer into list price. | 1M max (guaranteed 512K); native image/video/text input. Thinking is toggleable per request; standard/priority services exist. Above-512K availability was stated as limited at the pricing page crawl, so do not promise it. |
| DeepSeek Pro | `0.75×0.435 + 0.25×0.87 = $0.54375` → `$`. | 1M / 384K; text; thinking default with non-thinking selectable. JSON and tools supported; FIM is non-thinking only. |
| DeepSeek Flash | `0.75×0.14 + 0.25×0.28 = $0.175` → `$`. | Same documented 1M / 384K; thinking default with non-thinking selectable; JSON/tools/FIM restriction; 2,500 account concurrency vs Pro's 500. |

Sources: [Qwen Max](https://www.qwencloud.com/models/qwen3.7-max),
[Qwen Plus](https://www.qwencloud.com/models/qwen3.7-plus),
[Qwen pricing](https://docs.qwencloud.com/developer-guides/getting-started/pricing),
[MiniMax M3](https://www.minimax.io/models/text/m3),
[MiniMax pricing](https://platform.minimax.io/subscribe/token-plan?tab=api-enterprise),
[DeepSeek pricing](https://api-docs.deepseek.com/quick_start/pricing/), and
[DeepSeek thinking mode](https://api-docs.deepseek.com/guides/thinking_mode).

Upstream tool/caching claims do not establish Go/Pi parity. The Go catalog
does establish its message/completions transports and input modalities, but
does not document built-in upstream web/code tools, JSON mode, FIM, cache
creation, or function-call behavior at this route. Treat those as route-level
gaps, not advertised capabilities.

## Benchmark evidence

| Model(s) | Domain/result | Protocol/provenance | Rubric use |
| --- | --- | --- | --- |
| Qwen Max | Vendor positioning: programming, productivity, and long-horizon autonomous execution; no reproducible raw exact-route score found. | QwenCloud vendor page; text-only public route. | Context only; no owner leaderboard/population or second domain. |
| Qwen Plus | Vendor positioning: coding, tool use, productivity, visual/GUI interaction; no raw exact-model score found. | QwenCloud vendor page. | Context only; no percentile. |
| MiniMax M3 | **83.5 BrowseComp** vs cited Opus 4.7 79.3; coding/agentic claims. | Vendor-reported page. Its release describes internal SWE-Bench/Terminal-Bench/other harnesses, including scaffold and timeout differences. | Raw vendor evidence only; no benchmark-owner current rank/population. |
| DeepSeek Pro | Vendor claims open-source SOTA agentic coding and leading open-model math/STEM/coding; no raw score extracted. | DeepSeek V4 preview release; vendor claim. | No percentile. |
| DeepSeek Flash | Vendor says reasoning approaches Pro and simple agent tasks are at parity; no raw score extracted. | DeepSeek V4 preview release; vendor claim. | No percentile. |

The MiniMax methods explicitly use vendor infrastructure, mixed external rows,
different scaffolds, and different timeouts, so even reported scores are not
portable to this Pi/OpenCode Go harness. [M3 release and methodology](https://www.minimax.io/blog/minimax-m3)
DeepSeek's release presents model-family capability claims but no owner-run
rankings. [DeepSeek V4 release](https://api-docs.deepseek.com/news/news260424/)

### Intelligence and taste decision

All five: **intelligence `unvalidated` (high confidence)**. No exact-model,
benchmark-owner, contemporary-frontier percentile was located, and none has
the required coding/agentic plus another scored domain. Do not convert vendor
marketing, a vendor-run BrowseComp number, parameter counts, or upstream
availability into 1–10 values.

All five: **taste `unvalidated` (high confidence in the validation status)**.
No credible blind maintainer writing/design/UI comparison was provided. The
vision/GUI claims for Qwen Plus and M3 are capability facts, not a numeric
taste judgment.

## Current vs recommended cards

### `opencode-go/qwen3.7-max`

| Field | Current | Recommended | Confidence | Fact or inference |
| --- | --- | --- | --- | --- |
| Cost | `$$` | `unvalidated` | High | Fact: Go is bundled. Upstream context is $3.75 blend (`$$`). |
| Intelligence | 8 | `unvalidated` | High | Validation status. |
| Taste | 6 | `unvalidated` | High | Validation status. |
| Thinking | `high` | provider default until Go mapping is verified | High | Fact: no Pi map published for this route. |
| Best fit | frontier coding/reasoning, expensive to run | Text-only, long-context coding/reasoning investigations where high Go allowance burn is acceptable; use visual work elsewhere. | Medium | Inference from text-only route, 1M/65K limits, and Go's 950/5h estimate. |

### `opencode-go/qwen3.7-plus`

| Field | Current | Recommended | Confidence | Fact or inference |
| --- | --- | --- | --- | --- |
| Cost | `$` | `unvalidated` | High | Fact: Go is bundled. Upstream short-context blend is $0.70; long is $2.10. |
| Intelligence | 7 | `unvalidated` | High | Validation status. |
| Taste | 6 | `unvalidated` | High | Validation status. |
| Thinking | `medium` | provider default until Go mapping is verified | High | Fact: no Pi map published for this route. |
| Best fit | cheap multimodal agentic workhorse | Image/screen-aware coding and general agent work, especially below 256K input; do not infer Go tool/GUI parity from upstream claims. | Medium | Inference from route image input, 1M/65K limits, tiered upstream price, and Go's 4,300/5h estimate. |

### `opencode-go/minimax-m3`

| Field | Current | Recommended | Confidence | Fact or inference |
| --- | --- | --- | --- | --- |
| Cost | `$` | `unvalidated` | High | Fact: Go is bundled. Upstream list short-context blend is $1.05; current permanent-discount rate is $0.525. |
| Intelligence | 7 | `unvalidated` | High | Validation status. |
| Taste | 6 | `unvalidated` | High | Validation status. |
| Thinking | `medium` | provider default until Go mapping is verified | High | Fact: Pi publishes no map; upstream supports on/off. |
| Best fit | cheapest long-context coding option | Long-context, multimodal repository/document work where 1M context and 131K output matter; validate >512K API service and route cache/tool behavior first. | Medium | Inference from limits, image input, upstream long-context caveat, and Go's 3,200/5h estimate. |

### `opencode-go/deepseek-v4-pro`

| Field | Current | Recommended | Confidence | Fact or inference |
| --- | --- | --- | --- | --- |
| Cost | `$` | `unvalidated` | High | Fact: Go is bundled. Upstream blend is $0.54375. |
| Intelligence | 7 | `unvalidated` | High | Validation status. |
| Taste | 6 | `unvalidated` | High | Validation status. |
| Thinking | `on` | `default`: omit `--thinking` initially; adopt mapped `high` only after a successful Go control-mapping probe. | High | Fact: `on` is not a Pi level; catalog maps high/max, while upstream default thinking is a separate fact. |
| Best fit | tricky logic, debugging, secondary review | Text-only difficult debugging/reasoning and an independent implementation/review path, subject to route-level tool and quality evaluation. | Medium | Inference from 1M/384K, documented dual modes, and Go's 3,450/5h estimate. |

### `opencode-go/deepseek-v4-flash`

| Field | Current | Recommended | Confidence | Fact or inference |
| --- | --- | --- | --- | --- |
| Cost | `$` | `unvalidated` | High | Fact: Go is bundled. Upstream blend is $0.175. |
| Intelligence | 6 | `unvalidated` | High | Validation status. |
| Taste | 5 | `unvalidated` | High | Validation status. |
| Thinking | `on` | `default`: omit `--thinking` initially; adopt mapped `high` only after a successful Go control-mapping probe. | High | Fact: `on` is not a Pi level; catalog maps high/max, while upstream default thinking is a separate fact. |
| Best fit | trivial, disposable, mechanical work | High-throughput, text-only mechanical transformations and low-risk exploration; escalate correctness-sensitive work until direct route eval confirms the claimed Pro proximity. | Medium | Inference from 1M/384K, high Go request estimate, and vendor Flash positioning. |

## Contradictions with `ROUTING.md`

| Current claim | Correction |
| --- | --- |
| Every Go card has a `$`–`$$` cost tier. | All must be `unvalidated` for **actual route cost**: Go is a capped subscription/allowance transport. Retain upstream blends only as context. |
| Qwen Max can be a general multimodal route. | The exact Go catalog route is text-only. A visual `qwen3.7-max-2026-06-08` snapshot exists upstream but is not this route. |
| Qwen Max `high` and Qwen Plus/M3 `medium` select known effort levels. | Go Pi metadata publishes reasoning but no Qwen/M3 mapping. These selections need a non-production capability check. |
| DeepSeek `on` is a valid Pi thinking route. | Pi's documented levels omit `on`. Start by omitting `--thinking`; although Go metadata maps `high`/`max`, use mapped `high` only after a successful Go control-mapping probe. This does not alter the separately documented upstream default-thinking behavior. |
| Direct DeepSeek/Pi rates are interchangeable with Go/current DeepSeek rates. | DeepSeek's Pi integration example shows Pro $1.74/$3.48/cache $0.145 and Flash cache $0.028, while its current pricing page and Go show Pro $0.435/$0.87/$0.003625 and Flash cache $0.0028. Treat the integration example as stale or a different tier until DeepSeek resolves it; actual Go cost remains bundled/unvalidated. |
| Current 6–8 intelligence and 5–6 taste values are evidence-backed. | They do not meet the required exact-model, benchmark-owner percentile/two-domain rule or the taste-evidence rule. |
| “cheap” means an unconstrained low per-call route. | Go has a shared 5h/week/month dollar-value allowance; relative throughput estimates vary sharply by model and can change. |

## Gaps and evaluation needs

- Verify a request per route in the subscribed Go account without paid evaluation: selected model, region, current allowance, 429/fallback behavior, and whether balance fallback is enabled. For both DeepSeek routes, include a control-mapping probe before using mapped `high`.
- Run a fixed, representative Pi coding-agent suite with pinned tool allowlist, context budget, retries, task timeouts, and recorded actual Go allowance consumption. Compare Qwen Max/Plus, M3, Pro, and Flash at the available settings.
- Run harmless API feature probes before promising tool calls, structured output, cache, image input, or upstream built-in tool parity through Go/Pi. Include Qwen Max text-only and M3 >512K access.
- Obtain benchmark-owner leaderboards with exact versions and current submission populations for coding/agentic and a second domain before assigning intelligence values.
- Define a blind maintainer taste evaluation for prose, API design, and UI/code from the actual Go routes; retain `unvalidated` until then.

## Sources

| Source | Use | Accessed |
| --- | --- | --- |
| [OpenCode Go](https://opencode.ai/docs/go/) | First-party subscription, allowance, per-model usage values, IDs, transports, limits, privacy, model-list URL | 2026-07-28 |
| [OpenCode Go models](https://opencode.ai/zen/go/v1/models) | First-party live list: all five aliases present and `owned_by: opencode` | 2026-07-28 |
| Pi 0.80.10 `--help`, `--list-models`, and local catalog | First-party executor metadata: context/output/input/reasoning and available thinking maps | 2026-07-28 |
| [Qwen Max](https://www.qwencloud.com/models/qwen3.7-max) and [Qwen Plus](https://www.qwencloud.com/models/qwen3.7-plus) | First-party canonical IDs, modalities, features, current promotions, limits | 2026-07-28 |
| [Qwen pricing](https://docs.qwencloud.com/developer-guides/getting-started/pricing) | First-party standing/tiered prices, batch/cache/tool charges | 2026-07-28 |
| [MiniMax M3](https://www.minimax.io/models/text/m3), [release](https://www.minimax.io/blog/minimax-m3), and [pricing](https://platform.minimax.io/subscribe/token-plan?tab=api-enterprise) | First-party ID, M3 limits/multimodality/thinking, vendor benchmark/protocol, price tiers | 2026-07-28 |
| [DeepSeek pricing](https://api-docs.deepseek.com/quick_start/pricing/), [V4 release](https://api-docs.deepseek.com/news/news260424/), and [Pi integration](https://api-docs.deepseek.com/quick_start/agent_integrations/pi_mono/) | First-party IDs, API features/limits/prices, vendor positioning, Pi compatibility example | 2026-07-28 |
