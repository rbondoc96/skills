# Anthropic: Sonnet 5 and Opus 5 revalidation

Accessed 2026-07-28. This report covers only the two Claude cards presently named in `ROUTING.md`. Prices are USD per 1M tokens. “Vendor-reported” means Anthropic's own evaluation, not an independent reproduction.

## Executive summary

- Both exact cards are real, current, pinned Claude API model IDs: `claude-sonnet-5` and `claude-opus-5`. Opus 5 launched on 2026-07-24, so it is not an alias for Opus 4.8. [Models overview](https://platform.claude.com/docs/en/about-claude/models/overview) · [release notes](https://platform.claude.com/docs/en/release-notes/overview)
- Sonnet 5's standing price is $3 input / $15 output, not its temporary $2 / $10 launch price. At the required 3:1 mix, its standing blend is **$6.00/MTok (`$$$`)**, so the current `$$` is wrong. Opus 5 is $5 / $25; its blend is **$10.00/MTok (`$$$`)**. [Pricing](https://platform.claude.com/docs/en/about-claude/pricing)
- Both default to `high` effort, not the card's Sonnet `low`; both have adaptive thinking on by default. Sonnet 5's default thinking can be disabled. Opus 5 cannot disable thinking at `xhigh` or `max`. [Effort](https://platform.claude.com/docs/en/build-with-claude/effort) · [Sonnet migration](https://platform.claude.com/docs/en/about-claude/models/whats-new-sonnet-5) · [Opus migration](https://platform.claude.com/docs/en/about-claude/models/whats-new-opus-5)
- The requested percentile rubric supports **no integer intelligence score for either model**. Sonnet has one exact-model benchmark-owner coding result but no second rubric-compatible domain; Opus 5 has strong raw and vendor-reported results but no current benchmark-owner population/ranking for the needed domains. Do not preserve the current `6`/`8` as if validated.
- “Taste” is not measured by the sources. Recommend `unvalidated` for both rather than retaining 7/8 as fact. Best-fit statements can remain explicit maintainer inferences.

## Exact name and availability

| Routing name | Exact product / API ID | Current availability and surfaces | Status / confidence |
|---|---|---|---|
| `sonnet-5` | Claude Sonnet 5 / `claude-sonnet-5`; pinned, dateless snapshot | Claude API for all customers; Claude Code; Claude consumer plans (Free/Pro default; Max/Team/Enterprise); Claude Platform on AWS and Amazon Bedrock; Google Cloud; Microsoft Foundry. [Launch](https://www.anthropic.com/news/claude-sonnet-5) · [migration](https://platform.claude.com/docs/en/about-claude/models/whats-new-sonnet-5) | Current; high. |
| `opus-5` | Claude Opus 5 / `claude-opus-5`; pinned, dateless snapshot | Claude API for all customers; Amazon Bedrock (`anthropic.claude-opus-5`); Google Cloud (`claude-opus-5`); Microsoft Foundry. Released 2026-07-24. The current API docs do not state Claude.ai/Claude Code consumer-plan availability for Opus 5; do not infer it from Opus 4.8. [Release notes](https://platform.claude.com/docs/en/release-notes/overview) · [migration](https://platform.claude.com/docs/en/about-claude/models/whats-new-opus-5) | Current; high for listed API/cloud surfaces, low for unsourced consumer availability. |

## Pricing, context, and reasoning controls

| Model | Standing standard-priority uncached API list price | Required blended calculation / bucket | Cache, batch, promotion, and exclusions | Limits and controls |
|---|---:|---|---|---|
| Sonnet 5 | $3 input / $15 output | `0.75 × 3 + 0.25 × 15 = $6.00` → `$$$` (`> $4–$10`) | Intro promotion through 2026-08-31: $2 / $10 (blend $4.00; not the standing basis). 5m write $3.75, 1h write $6, hit $0.30. Batch: $1.50 / $7.50. US-only inference is 1.1×. | 1M context (default and max), 128k synchronous output; Batch can enable 300k output. Adaptive thinking default; `low`/`medium`/`high`/`xhigh`/`max`, default `high`; manual extended thinking and non-default sampling parameters return 400. Priority Tier unavailable. [Pricing](https://platform.claude.com/docs/en/about-claude/pricing) · [Sonnet migration](https://platform.claude.com/docs/en/about-claude/models/whats-new-sonnet-5) · [Models](https://platform.claude.com/docs/en/about-claude/models/overview) |
| Opus 5 | $5 input / $25 output | `0.75 × 5 + 0.25 × 25 = $10.00` → `$$$` (`> $4–$10`) | No standing promotion found. 5m write $6.25, 1h write $10, hit $0.50. Batch: $2.50 / $12.50. Fast-mode research preview, first-party API only: $10 / $50; not batch-compatible. US-only inference is 1.1×. | 1M context (default and max), 128k synchronous output; Batch can enable 300k output. Adaptive thinking default; `low`/`medium`/`high`/`xhigh`/`max`, default `high`. `thinking: disabled` only at `high` or lower; with it disabled, tool calls may leak into text. Mid-conversation tool changes and server-side fallback are beta. [Pricing](https://platform.claude.com/docs/en/about-claude/pricing) · [Opus migration](https://platform.claude.com/docs/en/about-claude/models/whats-new-opus-5) · [Effort](https://platform.claude.com/docs/en/build-with-claude/effort) |

The newer tokenizer makes roughly 30% more tokens for the same text on both models, so equal per-token prices do not prove equal per-request cost. [Pricing](https://platform.claude.com/docs/en/about-claude/pricing)

## Benchmark evidence

Scores below are raw evidence, not a synthesized intelligence score. Vendor-reported values use Anthropic's published configurations and are not interchangeable with an independent leaderboard run.

| Model | Domain | Result, benchmark/version, protocol | Source posture / percentile usability |
|---|---|---|---|
| Sonnet 5 | Coding / agentic | Terminal-Bench 2.1: 74.6% ±1.6%, Claude Code, `high`, rank 10 of 17 displayed current submissions; benchmark team verified the run. Vendor system card also reports SWE-bench Verified 85.2%, Pro 63.2%, Multilingual 78.3%, Multimodal 28.1%, five trials, adaptive thinking at max effort; the latter has no usable current leaderboard population. | Benchmark-owner evidence for one domain only. `10/17 = 58.8%` is a rank fraction, **not** a conventional percentile (and its direction is inverted: lower rank is better); do not map it to the rubric. SWE results are vendor-reported context only. [Terminal-Bench](https://www.tbench.ai/leaderboard/terminal-bench/2.1) · [Sonnet system card](https://www-cdn.anthropic.com/73ad94ca3c0502e75e46637cc62c8bd9532a7f2c/Claude%20Sonnet%205%20System%20Card.pdf) |
| Sonnet 5 | Tool use | Vendor launch reports BrowseComp and OSWorld-Verified improvements versus Sonnet 4.6 and parity with Opus 4.8 on some high-effort tasks; exact figures and a current owner ranking were not extracted. | Raw comparative vendor evidence only; no percentile. This domain is missing from the numeric calculation. [Launch](https://www.anthropic.com/news/claude-sonnet-5) |
| Opus 5 | Coding / agentic | Vendor system card: SWE-bench Verified 96.0%, Pro 79.2%, Multilingual 89.5%, Multimodal 59.4%; DeepSWE 1.1 68.8%, each averaged over five trials. Artificial Analysis reports joint first on its Coding Agent Index and 89% Terminal-Bench 2.1 at max effort, but the current Terminal-Bench owner leaderboard does not yet include an Opus 5 row. | System-card scores are vendor-reported. Independent evaluator reports are strong but no published contemporary population/rank is supplied for the exact comparison. No rubric percentile. [Opus system card](https://www-cdn.anthropic.com/c5fbac3f0b1280a933ebd26d3cb8bb9f5bdeaf48/Claude%20Opus%205%20System%20Card.pdf) · [Artificial Analysis](https://artificialanalysis.ai/articles/opus-5) |
| Opus 5 | Reasoning | Vendor system card: Humanity's Last Exam 56.3% without tools, 64.7% with tools; BrowseComp 90.8%; ARC-AGI-3 30.2%. Protocols differ, and tool-assisted HLE is not comparable to no-tool rows. | Vendor-reported. No current benchmark-owner Opus 5 HLE ranking was located, so this cannot establish a percentile. [Opus system card](https://www-cdn.anthropic.com/c5fbac3f0b1280a933ebd26d3cb8bb9f5bdeaf48/Claude%20Opus%205%20System%20Card.pdf) |
| Opus 5 | Tool use | Vendor system card: OSWorld 2.0 70.6%, MCP-Atlas pass rate 85.8%, mean claim coverage 89.1%, and AutomationBench 26.0%. Documentation also says its effort setting changes tool-call count and that Opus 5 adds beta tool-list changes mid-session. | Vendor-reported raw scores; no owner-leaderboard population or comparable scaffold. No rubric percentile. [Opus system card](https://www-cdn.anthropic.com/c5fbac3f0b1280a933ebd26d3cb8bb9f5bdeaf48/Claude%20Opus%205%20System%20Card.pdf) · [Effort](https://platform.claude.com/docs/en/build-with-claude/effort) |

### Intelligence calculation and limits

**Sonnet 5.** **Unvalidated; do not assign an integer.** The Terminal-Bench result is exact-model, benchmark-owner coding/agentic evidence, but it is only one rubric-compatible domain. The previously considered HLE row came from an aggregator, not a benchmark owner or primary source; its “verified” label does not make its population or protocol suitable for percentile normalization. Vendor SWE/BrowseComp/OSWorld context does not supply the required independent second domain. The requested rubric permits reweighting only after exact evidence covers coding/agentic **and** another domain, which is not met.

**Opus 5.** **Unvalidated; do not assign an integer yet.** The exact model has substantial raw evidence, but release age and incompatible/vendor scaffolds leave no defensible current frontier-submission percentile in each required domain. The requested rubric expressly forbids inventing one. Schema improvement: store domain evidence and protocol separately from an optional normalized score; render `unvalidated` until benchmark-owner or independently administered comparable rankings cover coding/agentic and one more domain.

## Current versus recommended cards

### `sonnet-5`

| Field | Current | Recommended | Confidence | Fact or inference | Rationale |
|---|---|---|---|---|---|
| Cost | `$$` | `$$$` | High | Fact | Standing blend is $6.00/MTok; the current value appears to use neither the required standing price nor the defined buckets. |
| Intelligence | 6 | `unvalidated` | High | Validation status | One exact-model, benchmark-owner coding/agentic result is insufficient for the rubric; no primary second-domain percentile was located. |
| Taste | 7 | `unvalidated` | Low | Maintainer judgment unavailable | Documentation supports text/image input and text output, and calls Sonnet suitable for coding/agents, but no fit-for-purpose blind writing/design evaluation was found. [Models](https://platform.claude.com/docs/en/about-claude/models/overview) |
| Best fit | mechanical coordination, routine writing | Cost-sensitive, high-volume agentic implementation and routine-but-real coding/tool workflows; reserve `low` effort for short/scoped or latency-sensitive work, not as a model default. | Medium | Lead-labeled inference | Evidence chain: $6 standing blend; 1M context; all five effort levels; current Terminal-Bench evidence; vendor reports gains in coding/agentic tasks. Its new real-time cyber safeguards may refuse high-risk cyber requests. [Effort](https://platform.claude.com/docs/en/build-with-claude/effort) · [Sonnet migration](https://platform.claude.com/docs/en/about-claude/models/whats-new-sonnet-5) |

### `opus-5`

| Field | Current | Recommended | Confidence | Fact or inference | Rationale |
|---|---|---|---|---|---|
| Cost | `$$$` | `$$$` | High | Fact | Standing blend is exactly $10.00/MTok. |
| Intelligence | 8 | `unvalidated` | Low | Inference withheld | The score predates the 2026-07-24 release and has no cited, rubric-compatible normalization. Preserve raw evidence rather than laundering launch claims into 8/10. |
| Taste | 8 | `unvalidated` | Low | Maintainer judgment unavailable | Capability docs describe longer default deliverables, vision/UI work, documents, and code review, but none is a valid taste score. [Opus migration](https://platform.claude.com/docs/en/about-claude/models/whats-new-opus-5) |
| Best fit | plans, review, product and API judgment | Capability-sensitive agentic coding, long-context investigation, and code review/bug-finding where higher per-call spend is justified; set effort from workload evaluation, beginning at `high`, not “as configured.” | Medium | Lead-labeled inference | Evidence chain: $10 standing blend; 1M context; full effort ladder; documented code-review, long-horizon, vision, and multi-agent capabilities; no independent end-to-end routing evaluation yet. [Opus migration](https://platform.claude.com/docs/en/about-claude/models/whats-new-opus-5) · [Effort](https://platform.claude.com/docs/en/build-with-claude/effort) |

## Contradictions with `ROUTING.md`

| Current card claim | Evidence-based correction |
|---|---|
| Sonnet default thinking is `low`. | `high` is API/Claude Code default. `low` is a deliberate cost/latency setting. |
| Sonnet cost is `$$`. | Required standing blend is $6.00/MTok, `$$$`. Its active promotion is $4.00 blend but cannot set the standing-card value. |
| Sonnet intelligence 6, “mechanical coordination, routine writing.” | It is a current 1M-context adaptive-thinking agentic/coding model with benchmark-owner Terminal-Bench evidence, but its integer intelligence score is `unvalidated` because a primary second-domain percentile is missing. Its best-fit description is materially too narrow. |
| Opus default thinking is “as configured.” | It defaults to adaptive thinking at `high`; controls are all five effort levels. Disabling thinking is invalid at `xhigh`/`max`. |
| Opus intelligence 8 and taste 8. | Neither has cited normalization under the required rubric. Opus 5 launched after the card's apparent assessment; intelligence must be `unvalidated` pending comparable leaderboards, and taste has no objective evidence. |

## Unresolved gaps and empirical evaluation needs

- Run a controlled in-repo, representative coding-agent suite at each route's stated effort, with fixed tools, token/time budgets, retries, and cost capture. Compare Sonnet 5 `high`/`xhigh` and Opus 5 `high`/`xhigh`/`max`; no paid evaluation was run for this report.
- Obtain a benchmark-owner or independently administered primary leaderboard for Sonnet 5 reasoning or tool use, then re-evaluate whether the rubric's second-domain gate is met. Do not use aggregator rows or mix incompatible protocols.
- Revisit Opus 5 after Terminal-Bench, HLE, or another benchmark owner publishes an exact-model, current comparable ranking. Do not mix HLE no-tools and with-tools scores.
- Establish a blind maintainer rubric for writing/API/UI taste: paired outputs, task-specific prompt, model/effort hidden, and separate prose, API design, and UI implementation criteria. Until then, the `taste` number should remain `unvalidated`.
- Measure operational availability in the actual Claude executor/harness: consumer-plan model selection, region/account eligibility, rate limits, refusal/fallback behavior, and whether high effort's additional tool calls fit the budget.
- Check migrated callers for unsupported non-default sampling, manual extended-thinking fields, insufficient `max_tokens`, and preserved cache keys. The new tokenizer changes equivalent-text token consumption by about 30%.

## Sources

| Source | Type / use | Accessed |
|---|---|---|
| [Anthropic models overview](https://platform.claude.com/docs/en/about-claude/models/overview) | First-party IDs, modalities, prices, limits, comparative latency, versioning | 2026-07-28 |
| [Anthropic pricing](https://platform.claude.com/docs/en/about-claude/pricing) | First-party standing/promo/cache/batch/fast/region pricing | 2026-07-28 |
| [Anthropic effort](https://platform.claude.com/docs/en/build-with-claude/effort) | First-party effort defaults, levels, tool/thinking behavior | 2026-07-28 |
| [Sonnet 5 migration](https://platform.claude.com/docs/en/about-claude/models/whats-new-sonnet-5) | First-party Sonnet changes, limits, availability, limitations | 2026-07-28 |
| [Opus 5 migration](https://platform.claude.com/docs/en/about-claude/models/whats-new-opus-5) | First-party Opus changes, limits, availability, limitations | 2026-07-28 |
| [Anthropic release notes](https://platform.claude.com/docs/en/release-notes/overview) | First-party Opus 5 release date and surfaces | 2026-07-28 |
| [Anthropic Sonnet 5 launch](https://www.anthropic.com/news/claude-sonnet-5) | First-party launch positioning and promotion | 2026-07-28 |
| [Sonnet 5 system card](https://www-cdn.anthropic.com/73ad94ca3c0502e75e46637cc62c8bd9532a7f2c/Claude%20Sonnet%205%20System%20Card.pdf) | First-party vendor-reported benchmark protocols/results | 2026-07-28 |
| [Opus 5 system card](https://www-cdn.anthropic.com/c5fbac3f0b1280a933ebd26d3cb8bb9f5bdeaf48/Claude%20Opus%205%20System%20Card.pdf) | First-party vendor-reported benchmark protocols/results | 2026-07-28 |
| [Terminal-Bench 2.1 leaderboard](https://www.tbench.ai/leaderboard/terminal-bench/2.1) | Benchmark-owner Sonnet 5 exact-run rank, harness, score | 2026-07-28 |
| [Artificial Analysis Opus 5 evaluation](https://artificialanalysis.ai/articles/opus-5) and [GDPval-AA v2 leaderboard](https://artificialanalysis.ai/evaluations/gdpval-aa) | Independent evaluator: exact model results, agent harness, current ranking | 2026-07-28 |
