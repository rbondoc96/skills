# ROUTING.md accuracy audit + new-model research

> **Research Date**: 15 July 2026
> Research done by Claude Sonnet 5, dispatched 5 subagents for research.
>
> **Historical:** superseded by the active `ROUTING.md` and the
> `research/2026-07-28/` re-validation. Keep this file as dated evidence only.

Five agents researched the existing rows (Claude, GPT-5.6, GLM/Kimi, DeepSeek) and the five candidate additions (`gpt-5.6-sol`, `gpt-5.6-luna`, `qwen3.7-plus`, `qwen3.7-max`, `minimax-m3`).

## Headline finding: a repeated inversion pattern

Multiple existing rows look like adjacent values got swapped or transposed during editing, not just "slightly off":

- **DeepSeek**: `deepseek-v4-flash` (284B, 13B active) was rated *smarter* (7) than `deepseek-v4-pro` (1.6T, 49B active, 6) — backwards. Pro wins every published benchmark.
- **GLM**: `glm-5.2` (the newer, larger, benchmark-leading model) was rated *cheaper* than `glm-5.1` at equal intelligence — GLM-5.2 is actually pricier and clearly stronger (+28.2 DeepSWE, +9.9 HMMT).
- **GPT-5.6**: `gpt-5.6-terra` was tagged cheapest ($) — it's actually the **mid** tier. Luna is cheapest, Sol is priciest.
- **Claude**: `sonnet-5` and `opus-4.8` shared a cost tier ($$$) despite opus costing ~67% more per token.

Worth a quick sanity pass next time this table is hand-edited — check that cost ordering and intelligence ordering both move in the same direction as any known model-tier ordering (mini/plus/pro/max, flash/pro, etc.), since these three families all have a same-family sibling to sanity-check against.

## Doc-level inconsistency (not model-specific) — resolved

Also worth deciding deliberately: "Default thinking" mixes two different vocabularies — GPT rows use real effort-parameter levels (`low`/`medium`/`high`/`xhigh`/`max`), while Kimi/DeepSeek/GLM rows use looser on/off/high labels that don't map to an actual provider parameter for those harnesses. Not wrong, just worth a one-line note in the doc clarifying that "default thinking" means different things per harness.

## Per-model detail

### Claude family
- **sonnet-5**: $3/$15 per M. Cost should move from $$$ to **$$**. Intelligence: Anthropic frames it as "near-Opus," i.e. still below — suggest **6** (was 5, slight bump; not equal to Opus).
- **opus-4.8**: $5/$25 per M, unchanged **$$$**. Intelligence **8** confirmed (Anthropic's own tier language: fable-5 > opus-4.8 > sonnet-5).
- **fable-5**: $10/$50 per M, unchanged **$$$$**, intelligence **9** confirmed as flagship. Taste **9 is unconfirmed** — Anthropic's explicit "warmer/clearer writing" language is attached to opus-4.8, not fable-5, in the docs the agent found. Recommend dropping to **8** unless you have firsthand experience justifying 9 — flagging this one as a judgment call, not hard evidence.

### GPT-5.6 family
All three GA'd July 9, 2026. Six effort levels available: none/low/medium/high/xhigh/max.

| Tier | Price ($/M in / out) | Notes |
|---|---|---|
| Sol | $5 / $30 | flagship — SWE-Bench Pro 64.6%, AA Intelligence 58.9 (edges just under fable-5's 59.9) |
| Terra | $2.50 / $15 | mid — confirmed **not** cheapest |
| Luna | $1 / $6 | cheapest, fastest |

Proposed rows — Sol: Cost $$$, Intelligence 9, Taste 6, default effort high. Terra: Cost **$$** (correction from $), Intelligence 8, Taste 5 (unchanged). Luna: Cost $, Intelligence 7, Taste 4, default effort low.

### GLM / Kimi family (Pi, `opencode-go/`)
- **glm-5.2** (June 2026, 744B/40B active, 1M context, $1.40/$4.40): clear step up from 5.1 on benchmarks. Cost **$$** (was $), Intelligence **9** (was 8), Taste **6** (was 5). High/Max reasoning-tier toggle.
- **glm-5.1** (754B/40B active, ~203K context, $0.966/$3.04): weaker sibling. Cost **$** (was $$), Intelligence **7** (was 8), Taste 7 unchanged.
- **kimi-k2.6** (1T/32B active, 262K context, $0.66/$3.41): reputation for writing/creative strength holds. Cost **$** (was $$), Intelligence **8** (was 7), Taste 8 unchanged.
- **kimi-k2.7-code** (coding fork of k2.6, 256K context, $0.95/$4.00, always-on thinking): Cost $$ unchanged, Intelligence **8** (was 7). Taste **6** (was 7) — plausible since it's a narrow coding fork of a writing-strong generalist base, though this specific point is unverified by a direct writing eval (flagging confidence as medium, not high).

### DeepSeek family (Pi, `opencode-go/`)
- Both Pro and Flash now support thinking/non-thinking via one unified API, **thinking on by default for both** (the old chat/reasoner split retires July 24, 2026) — so Flash's "off" default is stale.
- **deepseek-v4-pro** (1.6T/49B active, $0.435/$0.87 cache-miss): wins every benchmark found vs Flash. Intelligence **7** (was 6), default thinking "on" (was "high" — same effect, just re-labeled to match Flash's new wording).
- **deepseek-v4-flash** (284B/13B active, $0.14/$0.28): Intelligence **6** (was 7, corrected down — it is not smarter than Pro), default thinking "on" (was "off").

## New models to add

| Model | Cost | Intelligence | Taste | Default thinking | Access |
|---|---|---|---|---|---|
| `gpt-5.6-sol` | $$$ | 9 | 6 | high | Pi |
| `gpt-5.6-luna` | $ | 7 | 4 | low | Pi |
| `opencode-go/qwen3.7-max` | $$ | 8 | 6 | high | Pi (native DashScope also available) |
| `opencode-go/qwen3.7-plus` | $ | 7 | 6 | medium | Pi |
| `opencode-go/minimax-m3` | $ | 7 | 6 | medium | Pi |

Notes:
- **qwen3.7-max**: frontier-tier coding/reasoning (60.6% SWE-Bench Pro, edges out opus-4.6/k2.6-thinking on Terminal-Bench 2.0), but "thinks heavily" even on simple prompts — expensive to run, and reviews describe its UI/UX output as conservative/"not aesthetically refined," hence Taste 6 not higher. **Pricing re-verified**: Alibaba's official Model Studio page confirms $2.50/$7.50 per M is the standing list price; $1.25/$3.75 is a limited-time 50% promo, not the long-term rate. Budget for list price — Cost tier stays **$$**.
- **qwen3.7-plus**: ~1/6 of Max's price, multimodal, good agentic/everyday fit — best "cheap workhorse" candidate of the three new models.
- **minimax-m3**: cheapest of the three, MiniMax Sparse Attention makes long-context (1M) runs unusually affordable; benchmarks land in glm-5.2/kimi tier. Least taste evidence found — treated as comparable to kimi-k2.7-code pending more signal.

## Updated model-card table (proposed)


| Model | Harness | Default thinking | Cost | Intelligence | Taste | Best fit |
|---|---|---:|:--:|---:|---:|---|
| `gpt-5.6-sol` | Pi | high | $$$ | 9 | 6 | flagship-tier agentic coding, hardest tasks worth the premium |
| `gpt-5.6-terra` | Pi | medium | $$ | 8 | 5 | clear-spec implementation, bulk work, independent review |
| `gpt-5.6-luna` | Pi | low | $ | 7 | 4 | high-volume/cheap mechanical tasks |
| `sonnet-5` | Claude | low | $$ | 6 | 7 | mechanical coordination, routine writing |
| `opus-4.8` | Claude | as configured | $$$ | 8 | 8 | plans, review, product and API judgment |
| `fable-5` | Claude | as configured | $$$$ | 9 | 8 | user-facing design, copy, and API design |
| `opencode-go/glm-5.2` | Pi | high | $$ | 9 | 6 | repository synthesis, planning, long-context agentic work |
| `opencode-go/glm-5.1` | Pi | on | $ | 7 | 7 | fallback for general work |
| `opencode-go/kimi-k2.6` | Pi | on | $ | 8 | 8 | fallback where taste/writing matters |
| `opencode-go/kimi-k2.7-code` | Pi | always-on | $$ | 8 | 6 | default coding throughput |
| `opencode-go/qwen3.7-max` | Pi | high | $$ | 8 | 6 | frontier coding/reasoning, expensive to run |
| `opencode-go/qwen3.7-plus` | Pi | medium | $ | 7 | 6 | cheap multimodal agentic workhorse |
| `opencode-go/minimax-m3` | Pi | medium | $ | 7 | 6 | cheapest long-context coding option |
| `opencode-go/deepseek-v4-pro` | Pi | on | $ | 7 | 6 | tricky logic, debugging, secondary review |
| `opencode-go/deepseek-v4-flash` | Pi | on | $ | 6 | 5 | trivial, disposable, mechanical work |

## Suggested Role routes + Fallbacks changes (ROUTING.md)

Current `ROUTING.md` has no role slot for the new frontier tier (`gpt-5.6-sol`, `qwen3.7-max`) or the new cheap tier (`gpt-5.6-luna`, `qwen3.7-plus`, `minimax-m3`) — they'd otherwise sit in the model-card table unused. Proposed replacement for both sections:

### Role routes (proposed)

| Role and task shape | Primary route | Use instead when |
|---|---|---|
| Clear-spec implementation or bulk migration | `gpt-5.6-terra` via Pi | Use Kimi K2.7-code for normal coding throughput; DeepSeek Pro for non-obvious logic; `gpt-5.6-luna` for lower-stakes/cheaper bulk work |
| Flagship-tier or hardest agentic coding task | `gpt-5.6-sol` via Pi | Use `qwen3.7-max` via Pi as an alternate frontier-coding route; use Opus when taste or product judgment decides the design |
| Repository-heavy implementation or planning | `glm-5.2` via Pi | Use Opus when taste or product judgment decides the design |
| Cheap, everyday agentic or multimodal work | `qwen3.7-plus` via Pi | Use `minimax-m3` for cheaper long-context runs; use Kimi K2.6 when writing or taste matters |
| Trivial, low-risk edit | `deepseek-v4-flash` via Pi | Use `gpt-5.6-luna` or `minimax-m3` as alternates; use the current model if dispatch overhead exceeds the work |
| User-facing UI, copy, or API design | `fable-5` via Claude | Use Opus when review judgment matters more than generation |
| Plan or implementation review | `opus-4.8` via Claude | Add GPT or GLM via Pi as an independent technical perspective |
| High-risk review | Opus plus an independent Pi review | Required for auth, security, secrets, money, destructive data changes, migrations, public contracts, or cross-slice integration |
| Research or broad repository reconnaissance | `glm-5.2` via Pi | Use a read-only Pi route for computer-use-heavy investigation |

New/changed rows: "Flagship-tier or hardest agentic coding task" and "Cheap, everyday agentic or multimodal work" are new. Everything else carries over unchanged except cross-references to the new cheap-tier models.

### Fallbacks (proposed)

- Pi route → closest eligible Pi route for the task shape, or Claude for judgment and taste.
- Claude route → an independent Pi route when the task needs execution or a second technical perspective.
- GPT-5.6 models (`sol`/`terra`/`luna`) route through Pi only — Codex is not part of this routing scheme (Codex's sandbox mode has caused problems). `codex-implementation`/`codex-review` are unused as a result; that's a separate cleanup decision, not made here.
- `gpt-5.6-sol` and `qwen3.7-max` are interchangeable fallbacks for each other on hardest-tier tasks.
- `gpt-5.6-luna`, `qwen3.7-plus`, `minimax-m3`, and `deepseek-v4-flash` are interchangeable fallbacks for each other on trivial/bulk work — pick whichever isn't already in use for the primary route.

Pi settings may contain transport-level fallback models. They do not replace these role routes.

This drops the old standalone line *"Do not route GPT models through Codex; invoke them through Pi"* — folded into the GPT bullet above since it's no longer a special case, just how GPT models are reached.

## Resolved / deferred

- GPT routing: **resolved** — Pi, not Codex (sandbox issues). `~/.claude/CLAUDE.md` updated; table above updated. `codex-implementation`/`codex-review` are now unused by this routing table, and `pi-implementation`/`pi-review` still need a `gpt-5.6-*` row with a confirmed Pi model-id string — flagging both as separate follow-ups, not done here.
- "Default thinking" vocabulary: **deferred** — left as-is for now.
- Qwen3.7-Max pricing: **resolved** — $2.50/$7.50 per M is the real list price (confirmed against Alibaba's official pricing page); $1.25/$3.75 was a temporary promo. Cost tier unchanged at $$.
