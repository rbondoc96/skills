# Routing

Use these routes after classifying the role. Intelligence outranks taste, which outranks cost for work that ships. Cost is otherwise a tie-breaker.

## Model cards

Cost uses `$`–`$$$$`: more `$` means pricier, same as any menu. `$` is cheapest, `$$$$` is priciest.
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

Never route user-facing work to a model with taste below 7 without an explicit reason.

## Role routes

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

## Fallbacks

Choose and show one fallback in the approval table. Keep the same role and safety boundary.

- Pi route → closest eligible Pi route for the task shape, or Claude for judgment and taste.
- Claude route → an independent Pi route when the task needs execution or a second technical perspective.
- GPT-5.6 models (`sol`/`terra`/`luna`) route through Pi only — Codex is not part of this routing scheme (Codex's sandbox mode has caused problems). `codex-implementation`/`codex-review` are unused as a result; that's a separate cleanup decision, not made here.
- `gpt-5.6-sol` and `qwen3.7-max` are interchangeable fallbacks for each other on hardest-tier tasks.
- `gpt-5.6-luna`, `qwen3.7-plus`, `minimax-m3`, and `deepseek-v4-flash` are interchangeable fallbacks for each other on trivial/bulk work — pick whichever isn't already in use for the primary route.

Pi settings may contain transport-level fallback models. They do not replace these role routes.
