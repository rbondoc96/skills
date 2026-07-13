# Routing

Use these routes after classifying the role. Intelligence outranks taste, which outranks cost for work that ships. Cost is otherwise a tie-breaker.

## Model cards

| Model | Harness | Default thinking | Cost | Intelligence | Taste | Best fit |
|---|---|---:|---:|---:|---:|---|
| `gpt-5.6-terra` | Codex | medium | 9 | 8 | 5 | clear-spec implementation, bulk work, independent review |
| `sonnet-5` | Claude | low | 4 | 5 | 7 | mechanical coordination, routine writing |
| `opus-4.8` | Claude | as configured | 4 | 8 | 8 | plans, review, product and API judgment |
| `fable-5` | Claude | as configured | 2 | 9 | 9 | user-facing design, copy, and API design |
| `opencode-go/glm-5.2` | Pi | high | 9 | 8 | 5 | repository synthesis, planning, context-heavy work |
| `opencode-go/glm-5.1` | Pi | medium | 8 | 8 | 7 | fallback for general work |
| `opencode-go/kimi-k2.6` | Pi | medium | 8 | 7 | 8 | fallback where taste matters |
| `opencode-go/kimi-k2.7-code` | Pi | default | 8 | 7 | 7 | default coding throughput |
| `opencode-go/deepseek-v4-pro` | Pi | high | 9 | 6 | 6 | tricky logic, debugging, secondary review |
| `opencode-go/deepseek-v4-flash` | Pi | off | 9 | 7 | 5 | trivial, disposable, mechanical work |

Never route user-facing work to a model with taste below 7 without an explicit reason.

## Role routes

| Role and task shape | Primary route | Use instead when |
|---|---|---|
| Clear-spec implementation or bulk migration | `gpt-5.6-terra` via Codex | Use Kimi for normal coding throughput; use DeepSeek Pro for non-obvious logic |
| Repository-heavy implementation or planning | `glm-5.2` via Pi | Use Opus when taste or product judgment decides the design |
| Trivial, low-risk edit | `deepseek-v4-flash` via Pi | Use the current model if dispatch overhead exceeds the work |
| User-facing UI, copy, or API design | `fable-5` via Claude | Use Opus when review judgment matters more than generation |
| Plan or implementation review | `opus-4.8` via Claude | Add Codex or GLM as an independent technical perspective |
| High-risk review | Opus plus an independent Codex or Pi review | Required for auth, security, secrets, money, destructive data changes, migrations, public contracts, or cross-slice integration |
| Research or broad repository reconnaissance | `glm-5.2` via Pi | Use Codex read-only for computer-use-heavy investigation |

## Fallbacks

Choose and show one fallback in the approval table. Keep the same role and safety boundary.

- Codex route → closest Pi route for the task shape.
- Pi route → Codex for clear implementation/review, or Claude for judgment and taste.
- Claude route → an independent Codex or Pi route when the task needs execution or a second technical perspective.

Pi settings may contain transport-level fallback models. They do not replace these role routes.
