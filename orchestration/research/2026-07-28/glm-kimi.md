# GLM and Kimi OpenCode Go route re-validation

Research date: 2026-07-28. Scope is limited to the four exact `opencode-go/...`
cards in `orchestration/ROUTING.md`. Prices are USD per 1M tokens. “Vendor-
reported” is a provider-published result, not an independent reproduction.

## Executive summary

- All four strings are live **OpenCode Go transport aliases**, not upstream
  canonical IDs. The route format is `opencode-go/<model-id>` and Go lists the
  four model IDs. The upstream canonical IDs are `glm-5.2`, `glm-5.1`,
  `kimi-k2.6`, and `kimi-k2.7-code`; this does not prove that Go serves the
  upstream provider's exact deployment, weights, limits, or controls.
  [OpenCode Go](https://opencode.ai/docs/go/)
- **Route cost is `unvalidated` for every card.** Go is a $5 first-month, then
  $10/month subscription with dollar-valued five-hour/week/month allowances,
  rather than a published standard-priority per-token route price. Its listed
  token rates describe included-usage accounting and balance fallback, not the
  subscriber's standing marginal token bill. This is the required treatment for
  subscription-bundled transport. [OpenCode Go](https://opencode.ai/docs/go/)
- As *non-route API context*, direct Z.AI GLM list prices yield $2.15/MTok at
  the required 3:1 mix (`$$`); direct Kimi list prices yield $1.7125/MTok
  (`$$`). These values must not replace the Go route cost. [Z.AI pricing](https://docs.z.ai/guides/overview/pricing) · [Kimi platform](https://platform.kimi.ai/)
- Public evidence supports raw capability observations, not the current integer
  intelligence values. Only GLM-5.1 has a current exact-model
  benchmark-owner leaderboard entry (Terminal-Bench 2.1); no route-equivalent,
  contemporary percentile population covers coding/agentic plus another domain
  for any card. Recommend **`unvalidated` intelligence** for all four.
- “Taste” has no suitable writing/design preference evaluation. Despite
  provider claims about creative/front-end ability, recommend **`unvalidated`**
  rather than preserving 6/7/8 as a fact.

## Route alias versus canonical name and availability

| Routing entry | Go alias / current transport availability | Upstream canonical model and documented surfaces | Boundary and confidence |
|---|---|---|---|
| `opencode-go/glm-5.2` | Go currently lists `glm-5.2`; its documented endpoint is `https://opencode.ai/zen/go/v1/chat/completions`. Local Pi 0.80.10 lists 1M context, 131.1K max output, thinking yes, no images. | Z.AI canonical API ID `glm-5.2`; Z.AI docs call it the strongest coding model and document API migration. Weights are MIT-licensed and published separately. [Z.AI migration](https://docs.z.ai/guides/overview/migrate-to-glm-new) · [Z.AI release](https://z.ai/blog/glm-5.2) | Go availability: high. Exact upstream deployment behind Go: unknown; do not treat the alias as an attestation of provenance. |
| `opencode-go/glm-5.1` | Go currently lists `glm-5.1` on the same Go endpoint. Local Pi lists 202.8K context, 32.8K max output, thinking yes, no images. | Z.AI canonical API ID `glm-5.1`, direct API and open-weight model. Docs specify 200K context, 128K max output, text in/out. [GLM-5.1 card](https://docs.z.ai/guides/llm/glm-5.1) | Go availability: high. Go's output limit disagrees with upstream card; use Go metadata when dispatching. |
| `opencode-go/kimi-k2.6` | Go currently lists `kimi-k2.6` on the Go endpoint. Local Pi lists 262.1K context, 65.5K max output, thinking yes, images yes. | Moonshot/Kimi canonical API ID `kimi-k2.6`; Kimi lists API, app, and Kimi Code availability. It is a general-purpose text/image/video model. [K2.6 model guide](https://platform.kimi.ai/docs/guide/kimi-k2-6-quickstart) · [release](https://www.kimi.com/blog/kimi-k2-6) | Go availability: high. Transport does not establish that every upstream hosted tool is exposed. |
| `opencode-go/kimi-k2.7-code` | Go currently lists `kimi-k2.7-code` on the Go endpoint. Local Pi lists 262.1K context, 262.1K max output, thinking yes, images yes. | Moonshot/Kimi canonical API ID `kimi-k2.7-code`, a dedicated coding model. It is distinct from `kimi-k2.7-code-highspeed`, which Kimi describes as the same capabilities with a different service tier/speed. [K2.7 guide](https://platform.kimi.ai/docs/guide/kimi-k2-7-code-quickstart) | Go availability: high. The Go alias does **not** say it uses HighSpeed; do not infer HighSpeed latency. |

Local model-list evidence was collected with `pi --list-models` on Pi 0.80.10 on
the research date. It establishes adapter metadata only; it is not a provider
model card. The OpenCode Go page says its model list can change, so re-run that
command at dispatch time. [OpenCode Go](https://opencode.ai/docs/go/)

### Pi adapter-control boundary

Pi 0.80.10 accepts only `off`, `minimal`, `low`, `medium`, `high`, `xhigh`, or
`max` for `--thinking`. `orchestration/PI.md` passes the route's value directly
unless it is `default`. Therefore current `on` (GLM-5.1/K2.6) and `always-on`
(K2.7 Code) are **invalid Pi CLI arguments**. `high` (GLM-5.2) is syntactically
valid, but neither Pi's catalog (`thinking: yes`) nor Go's public docs publish
a mapping from any Pi level to the four upstream controls. Upstream default
and always-thinking behavior must not be relabeled as a verified Pi level.

Until a controlled no-charge/approved probe establishes mapping, recommend
`default` for all four Go routes so PI.md omits `--thinking`; record the
provider behavior separately. This avoids a known CLI failure without asserting
that omission preserves upstream defaults. Local evidence: `pi --help` and
`orchestration/PI.md`, both inspected 2026-07-28.

## Pricing, context, and reasoning controls

| Route | Actual Go transport price and required cost result | Direct upstream API context only | Context/output and controls; transport caveat |
|---|---|---|---|
| GLM-5.2 | Go subscription: $5 first month, $10/month afterwards; limits are $12/5h, $30/week, $60/month of value. **Route cost: `unvalidated`**. Go's accounting table shows $1.40 input / $4.40 output / $0.26 cached read; not a standing subscriber token price. | Z.AI: $1.40 input / $4.40 output / $0.26 cached input; cache storage is limited-time free. `0.75 × 1.40 + 0.25 × 4.40 = $2.15` → `$$`. No batch price found. [Z.AI pricing](https://docs.z.ai/guides/overview/pricing) | Upstream: 1M context, 128K output; direct Z.AI thinking defaults on and supports `high`/`max` (`max` default when deep thinking). Go Pi metadata: 1M / 131.1K, thinking yes. **Pi recommendation: `default` (omit);** `high`/`max` forwarding/mapping to Go is unverified. [Z.AI migration](https://docs.z.ai/guides/overview/migrate-to-glm-new) |
| GLM-5.1 | Same Go subscription/limits. **Route cost: `unvalidated`**. Go's accounting table is $1.40 / $4.40 / $0.26. | Z.AI: $1.40 / $4.40 / $0.26; limited-time-free cache storage. `0.75 × 1.40 + 0.25 × 4.40 = $2.15` → `$$`. No batch price found. [Z.AI pricing](https://docs.z.ai/guides/overview/pricing) | Upstream: 200K context, 128K output; direct Z.AI thinking defaults enabled and supports disabled/enabled. Go Pi metadata: 202.8K / 32.8K, thinking yes. **Pi recommendation: `default` (omit);** current `on` is invalid. [GLM-5.1 card](https://docs.z.ai/guides/llm/glm-5.1) |
| Kimi K2.6 | Same Go subscription/limits. **Route cost: `unvalidated`**. Go's accounting table is $0.95 / $4.00 / $0.16 cached read. | Kimi lists $0.95 input / $4.00 output / $0.16 cache hit. `0.75 × 0.95 + 0.25 × 4.00 = $1.7125` → `$$`. No batch or promotion price found. [Kimi platform](https://platform.kimi.ai/) | Upstream: 256K context; direct Kimi default `thinking.enabled`, can be disabled. Docs default `max_tokens` to 32K, while Pi metadata advertises 65.5K output: test the transport cap. **Pi recommendation: `default` (omit);** current `on` is invalid. Thinking-mode tool calls require retained `reasoning_content`; built-in web search is temporarily incompatible with K2.6 thinking. [K2.6 guide](https://platform.kimi.ai/docs/guide/kimi-k2-6-quickstart) |
| Kimi K2.7 Code | Same Go subscription/limits. **Route cost: `unvalidated`**. Go's accounting table is $0.95 / $4.00 / $0.19 cached read. | Kimi lists $0.95 input / $4.00 output / $0.19 cache hit. `0.75 × 0.95 + 0.25 × 4.00 = $1.7125` → `$$`. No batch or promotion price found. [Kimi platform](https://platform.kimi.ai/) | Upstream: 256K context; direct Kimi is always-thinking — disabling errors. Default `max_tokens` is 32K; Pi advertises 262.1K max output. **Pi recommendation: `default` (omit);** current `always-on` is invalid and omission's Go effect is unverified; upstream always-thinking remains a separate fact. [K2.7 guide](https://platform.kimi.ai/docs/guide/kimi-k2-7-code-quickstart) |

Go says balance can take over after the included limits, but its documentation
does not publish a subscriber's standard-priority, uncached marginal price for
that fallback. Cached rates, the first-month offer, and the “aim” of 6× value
are therefore recorded separately and excluded from the route cost bucket.
[OpenCode Go](https://opencode.ai/docs/go/)

## Benchmark evidence

| Model | Domain | Raw evidence, version, protocol | Provenance, percentile usability, confidence |
|---|---|---|---|
| GLM-5.2 | Coding/agentic | Vendor report: Terminal-Bench 2.1 Terminus-2 81.0; SWE-bench Pro 62.1; DeepSWE 46.2; ProgramBench 63.7; FrontierSWE dominance 74.4; PostTrainBench 34.3; SWE-Marathon 13.0. Protocols vary; Terminal-Bench used Terminus-2, 256K, 4h, 4 CPU/8GB; ProgramBench used Claude Code and max effort. | Vendor-reported. Current Terminal-Bench owner board has no GLM-5.2 row. The heterogeneous harnesses cannot stand in for Pi/Go. No percentile population. Medium raw-evidence confidence. [GLM-5.2 release](https://z.ai/blog/glm-5.2) · [Terminal-Bench](https://www.tbench.ai/leaderboard/terminal-bench/2.1) |
| GLM-5.2 | Reasoning | Vendor report: HLE 40.5, HLE with tools 54.7, CritPt 20.9, GPQA-Diamond 91.2, AIME 2026 99.2. HLE used text-only by default, 163,840 max generation; tool HLE used 300K context. | Vendor-reported and no owner ranking/population for this exact configuration. Medium. [GLM-5.2 release](https://z.ai/blog/glm-5.2) |
| GLM-5.2 | Tool use | Vendor report: MCP-Atlas public set 76.8; Tool-Decathlon 48.2; all models evaluated in think mode; 10 minute/task for MCP-Atlas and 128K max tokens for Tool-Decathlon. | Vendor-reported; no defensible percentile population. Medium. [GLM-5.2 release](https://z.ai/blog/glm-5.2) |
| GLM-5.1 | Coding/agentic | **Benchmark-owner** Terminal-Bench 2.1: Claude Code, `max`, 58.7% ±1.2, rank 17/17 displayed, May 1. Vendor report separately gives Terminal-Bench Terminus-2 63.5, SWE-bench Pro 58.4, DeepSWE 18.0, ProgramBench 50.9, FrontierSWE 30.5. | Owner result is exact-model but a different agent from Pi and only one domain. `17/17` is a rank fraction, not a conventionally specified percentile; do not invert or bucket it. Vendor values cannot complete normalization. High for the owner row; medium for vendor rows. [Terminal-Bench](https://www.tbench.ai/leaderboard/terminal-bench/2.1) · [GLM-5.2 release table](https://z.ai/blog/glm-5.2) |
| GLM-5.1 | Reasoning/tool use | Vendor report: HLE 31.0 / with tools 52.3, CritPt 4.6, GPQA 86.2; MCP-Atlas 71.8 and Tool-Decathlon 40.7. | Vendor-reported with no benchmark-owner contemporary population. Medium raw evidence. [GLM-5.2 release](https://z.ai/blog/glm-5.2) |
| Kimi K2.6 | Coding/agentic | Vendor report: SWE-bench Pro 58.6; SWE-bench Multilingual 76.7; Kimi Code Bench claims long-horizon cases with 4,000+ tool calls / 12+ hours. The technical blog says its official results used thinking enabled, temperature 1/top-p 1, 262,144 context; several tool suites used search/code interpreter/browser. | Vendor-reported. No exact K2.6 entry on current Terminal-Bench 2.1 and no compatible public population. Medium raw evidence. [K2.6 announcement](https://forum.moonshot.ai/t/meet-kimi-k2-6-advancing-open-source-coding/369) · [K2.6 technical blog](https://www.kimi.com/blog/kimi-k2-6) |
| Kimi K2.6 | Reasoning/tool use | Vendor report: HLE 54.0, BrowseComp 83.2, Toolathlon 50.0, Charxiv-with-Python 86.7, Math Vision-with-Python 93.2. | Tool-enabled and multimodal configurations differ; no owner ranking/population. Medium raw evidence. [K2.6 announcement](https://forum.moonshot.ai/t/meet-kimi-k2-6-advancing-open-source-coding/369) |
| Kimi K2.7 Code | Coding/agentic/tool use | Vendor report: Kimi Code Bench V2 62.0 (K2.6 50.9), ProgramBench 53.6 (48.3), MLS Bench Lite 35.1 (26.7), Kimi Claw 24/7 46.9 (42.9), MCP-Atlas 76.0 (69.4), MCPMark Verified 81.1 (72.8). | Vendor-reported; several benchmarks are provider-owned or missing public population/protocol detail. The named `kimi-k2.7-code` may not share the Go transport's deployment/scaffold. Medium raw evidence. [K2.7 announcement](https://forum.moonshot.ai/t/here-comes-kimi-k2-7-code-better-coding-with-more-efficiency/441) |
| Kimi K2.7 Code | Reasoning | Kimi documents always-on long thinking and says it supports multi-step tools/reasoning, but no public exact-model benchmark-owner reasoning leaderboard was located. | Capability fact; raw comparative score/percentile missing. Low. [K2.7 guide](https://platform.kimi.ai/docs/guide/kimi-k2-7-code-quickstart) |

### Intelligence calculation and limits

All four recommend **`unvalidated`**, high confidence in that *validation
status*. The rubric permits a weighted numeric score only with defensible
domain percentiles or a justified reweight after exact evidence covers
coding/agentic and another domain. GLM-5.1 has one owner-run coding/agentic
row but no qualifying second domain; GLM-5.2 and both Kimi cards have useful
vendor raw results but no current benchmark-owner percentile populations and
non-equivalent scaffolds. Therefore no raw domain score, weighted mean
`0.60×coding + 0.25×reasoning + 0.15×tool`, or rounded integer can be honestly
calculated. Store the evidence/protocol separately and only score after a
route-level evaluation or compatible owner boards exist.

## Current versus recommended cards

### `opencode-go/glm-5.2`

| Field | Current | Recommended | Confidence | Fact or inference | Rationale |
|---|---|---|---|---|---|
| Cost | `$$` | `unvalidated` | High | Fact / rubric application | Go is subscription-bundled; $2.15 direct Z.AI blend is non-route context, not its actual Go marginal price. |
| Thinking | `high` | `default` (omit `--thinking`) pending probe | High | Adapter fact; deployment inference withheld | `high` is valid Pi syntax but Go does not document its mapping. Direct Z.AI's default `max` must not be presumed to reach Go. |
| Intelligence | 9 | `unvalidated` | High | Validation status | Strong vendor raw evidence, but no rubric-compatible route/owner percentiles. |
| Taste | 6 | `unvalidated` | Medium | Maintainer judgment withheld | No credible preference evaluation establishes a 6/10 writing/design score. |
| Best fit | repository synthesis, planning, long-context agentic work | Repository-scale investigation/planning and long-horizon coding **after route-level evaluation**; avoid asserting it is best for every large context. | Medium | Lead-labeled inference | Evidence chain: 1M executor/upstream context, text-only, vendor long-horizon coding evidence, configurable effort; actual Go latency and deployment parity unknown. |

### `opencode-go/glm-5.1`

| Field | Current | Recommended | Confidence | Fact or inference | Rationale |
|---|---|---|---|---|---|
| Cost | `$` | `unvalidated` | High | Fact / rubric application | Same Go subscription treatment; direct Z.AI blend is $2.15 (`$$`) only outside Go. |
| Thinking | `on` | `default` (omit `--thinking`) pending probe | High | Adapter fact | `on` is not in Pi 0.80.10's accepted enum and PI.md passes it directly. Direct Z.AI's enabled default does not establish Go omission semantics. |
| Intelligence | 7 | `unvalidated` | High | Validation status | One owner-run Terminal-Bench row is insufficient under the required two-domain gate. |
| Taste | 7 | `unvalidated` | Medium | Maintainer judgment withheld | Provider creative-writing claims are not a taste evaluation. |
| Best fit | fallback for general work | General text-only agent/coding fallback when 200K-ish Go context is sufficient and a validated route benchmark favors it. | Low | Lead-labeled inference | Evidence chain: text-only, thinking default on, one owner coding benchmark and vendor broad claims; Go output cap is notably lower than upstream. |

### `opencode-go/kimi-k2.6`

| Field | Current | Recommended | Confidence | Fact or inference | Rationale |
|---|---|---|---|---|---|
| Cost | `$` | `unvalidated` | High | Fact / rubric application | Go subscription prevents a bucket. Direct Kimi blend is $1.7125 (`$$`), so even the non-route basis is not `$`. |
| Thinking | `on` | `default` (omit `--thinking`) pending probe | High | Adapter fact | `on` is an invalid Pi CLI value. Upstream K2.6's default-enabled/toggleable thinking is not a verified Go map. |
| Intelligence | 8 | `unvalidated` | High | Validation status | Vendor results span domains but lack compatible benchmark-owner populations and Go route parity. |
| Taste | 8 | `unvalidated` | Medium | Maintainer judgment withheld | Text/image/video and provider creative/front-end claims are capabilities, not a defensible 8/10 preference score. |
| Best fit | fallback where taste/writing matters | Multimodal general-agent fallback where toggleable thinking, image/video input, and 256K class context matter; evaluate output style locally before calling it a writing/taste route. | Medium | Lead-labeled inference | Evidence chain: documented multimodality, enabled/disabled thinking, long-context general-purpose positioning; web-search/thinking incompatibility is a material limitation. |

### `opencode-go/kimi-k2.7-code`

| Field | Current | Recommended | Confidence | Fact or inference | Rationale |
|---|---|---|---|---|---|
| Cost | `$$` | `unvalidated` | High | Fact / rubric application | Go subscription prevents a bucket; the direct Kimi contextual blend is $1.7125 (`$$`). |
| Thinking | `always-on` | `default` (omit `--thinking`) pending probe | High | Adapter fact plus upstream fact | `always-on` is an invalid Pi CLI value. Direct K2.7 Code rejects disabled thinking, but that upstream behavior is not a valid Pi level or proof of Go forwarding. |
| Intelligence | 8 | `unvalidated` | High | Validation status | Vendor coding/tool deltas are promising but lack owner leaderboard percentile normalization and route equivalence. |
| Taste | 6 | `unvalidated` | Medium | Maintainer judgment withheld | It is coding-specialized; no credible writing/design preference study supports 6. |
| Best fit | default coding throughput | Coding-first throughput candidate for standard agent loops, subject to a controlled Go evaluation and an upstream always-thinking token/latency budget. | Medium | Lead-labeled inference | Evidence chain: dedicated coding positioning, vendor coding/tool comparisons, upstream always-thinking behavior, 256K context, and documented HighSpeed distinction. No Go HighSpeed/latency or control-mapping evidence. |

## Contradictions with `ROUTING.md`

| Current claim | Evidence-based correction |
|---|---|
| Each Go card has `$` or `$$` cost. | All actual Go transport costs are `unvalidated` under the supplied rubric because Go is subscription-bundled. Keep direct API blends as non-route context only. |
| GLM-5.2 intelligence 9; GLM-5.1 7; K2.6/K2.7 Code 8. | Preserve raw evidence but set each numeric intelligence field to `unvalidated`; none has rubric-compatible, route-equivalent percentile evidence across required domains. |
| K2.6 taste 8, GLM-5.1 taste 7, GLM-5.2/K2.7 Code taste 6. | No objective/credible qualitative source yields a calibrated taste score; all should be `unvalidated` unless a maintainer deliberately supplies a labeled subjective judgment. |
| GLM-5.2's `high` is the provider default. | Upstream GLM-5.2 deep thinking is enabled by default and `reasoning_effort=max` is default; `high` is an intentional routing override. Transport support for forwarding the setting is unverified. |
| GLM-5.1/K2.6 `on` and K2.7 Code `always-on` are route thinking values. | PI.md passes them directly, but Pi 0.80.10 accepts only `off`, `minimal`, `low`, `medium`, `high`, `xhigh`, and `max`; all three values fail CLI validation. Use `default`/omit until a Go mapping is probed. |
| K2.7 Code `always-on` thinking. | This is supported **upstream**: direct Kimi rejects disabled thinking. It is not a valid Pi CLI value and does not prove Go exposes the same parameter behavior or that it is HighSpeed. |
| GLM-5.1 is a generic fallback without limits caveat. | It is text-only; Go's 32.8K advertised output limit differs from Z.AI's 128K. Its one independent Terminal-Bench score used Claude Code/max, not Pi/Go. |
| K2.6 is the taste/writing fallback. | It has documented multimodal/general-agent capability; writing superiority is unsupported. Thinking-mode web search is temporarily incompatible upstream. |

## Unresolved gaps and empirical evaluation needs

- First make a no-charge/approved control probe that records Pi's omitted `--thinking` behavior and every valid Pi level against each Go route; inspect request/response errors and usage without exposing credentials. Do not select `high` or `max` for Go merely because those values are valid Pi syntax or exist upstream.
- Verify Go's actual provider, deployment version, regional endpoint, safety/tool policy, `thinking`/effort mapping, and whether it passes upstream context/output maxima. Neither Go aliases nor Pi metadata prove these.
- Record a real Go subscriber's post-limit balance terms before ever trying to price marginal tokens. Recheck Go's plan, $12/$30/$60 limits, and model list at dispatch because the docs say they may change. No paid calls were made for this research.
- Run one controlled, in-repo, **non-production** route evaluation only after control mapping: fixed prompt/task set, Pi version, allowed tools, time/token/retry limits, no secret exposure, and captured latency/token usage. Include long-context repository tasks, coding repair, reasoning, and tool reliability; distinguish direct-provider behavior from observed Go behavior.
- For `taste`, use a preregistered blind side-by-side writing/UI/API-design panel with task-specific criteria. Label the resulting score as maintainer preference, not model intelligence.
- Seek benchmark-owner boards for exact GLM-5.2, K2.6, and K2.7 Code or make reproducible submissions with disclosed harnesses. Never normalize vendor results against an unspecified population.

## Sources

All accessed 2026-07-28.

| Source | Owner / evidence used |
|---|---|
| [OpenCode Go](https://opencode.ai/docs/go/) | First-party subscription price, limits, alias format, exact Go model list, accounting rates/cache values, endpoint, balance fallback, and mutable-list caveat. |
| Local Pi 0.80.10 `--help`; `orchestration/PI.md` | Accepted `--thinking` enum and direct forwarding rule. This establishes CLI validity, not a provider control map. |
| [Z.AI pricing](https://docs.z.ai/guides/overview/pricing) | First-party direct GLM input/output/cache prices and limited-time cache-storage offer. |
| [Z.AI GLM-5.2 migration](https://docs.z.ai/guides/overview/migrate-to-glm-new) | Canonical ID, limits, default thinking/effort, tool-streaming and migration controls. |
| [Z.AI GLM-5.1 card](https://docs.z.ai/guides/llm/glm-5.1) | Canonical ID, modality, limits, controls, documented usage, and provider claims. |
| [Z.AI GLM-5.2 release / technical report](https://z.ai/blog/glm-5.2) | Vendor-reported cross-domain raw benchmarks and their stated protocols/limitations. |
| [Terminal-Bench 2.1 leaderboard](https://www.tbench.ai/leaderboard/terminal-bench/2.1) | Benchmark-owner exact GLM-5.1 Claude Code/max score, rank, date, uncertainty, harness and model organization. |
| [Kimi platform home](https://platform.kimi.ai/) | First-party direct K2.6/K2.7 Code input/output/cache prices and high-level current availability. |
| [K2.6 API guide](https://platform.kimi.ai/docs/guide/kimi-k2-6-quickstart) | Canonical ID, modalities, context, thinking controls, tool constraints, output default. |
| [K2.6 release / report](https://www.kimi.com/blog/kimi-k2-6) | Vendor capability descriptions, evaluation configuration and long-horizon claims. |
| [K2.6 announcement](https://forum.moonshot.ai/t/meet-kimi-k2-6-advancing-open-source-coding/369) | Vendor-reported K2.6 benchmark numbers and release surfaces. |
| [K2.7 Code API guide](https://platform.kimi.ai/docs/guide/kimi-k2-7-code-quickstart) | Canonical ID, HighSpeed distinction, controls, multimodality, limits, and tool constraints. |
| [K2.7 Code announcement](https://forum.moonshot.ai/t/here-comes-kimi-k2-7-code-better-coding-with-more-efficiency/441) | Vendor-reported coding/agentic/tool raw comparisons and fixed parameters. |
