# Routing

Use these cards after classifying the role. A route is a maintainer policy, not
a benchmark rank or permission to dispatch. Check the selected model, executor,
and controls at dispatch; never silently substitute.

## Subscription selection

The subscription fee is sunk. Treat operational cost as allowance pressure:
how quickly a route consumes the plan's available capacity before its reset.
Do not use upstream API price as a route-cost proxy.

- Record the subscription, reset/allowance behavior, and observed burn for the
  exact route. Use `unvalidated` until measured.
- Provider-published request estimates are provisional, not measured local
  burn. Account, region, plan, and executor can change availability.
- Best-fit statements below are maintainer inferences. Revalidate them against
  the actual model + executor + settings route.

## Model cards

Read the card columns as follows:

- **Tier** is a maintainer prior for triage order (`A` strongest, `C` weakest),
  not a measured score and not a benchmark rank. Intelligence is `unvalidated`
  for every route; see [`CALIBRATION.md`](CALIBRATION.md).
- **Taste** is the maintainer's own judgment of output quality for user-facing
  work. It is a decision, not a measurement.
- **Evidence** rates how much raw evidence backs the tier: `medium` for
  route-adjacent benchmark or vendor results, `low` for vendor positioning
  only. It does not make tiers comparable across providers.

Never route user-facing work to a Taste `C` route without an explicit reason.

### Codex routes

All Codex routes are OpenAI, run through Codex native or `codex exec`, and may
use T3 native only when the exact model override is advertised. Codex
subscription allowance and T3 allowance are both `unvalidated`.

| Model | Route effort | Tier | Taste | Evidence | Provisional best fit |
|---|---|:--:|:--:|:--:|---|
| `gpt-5.6-sol` | `high` | A | C | medium | Hard, high-value coding and reasoning |
| `gpt-5.6-terra` | `medium` | B | C | medium | Clear-spec implementation and cost-balanced coding candidate |
| `gpt-5.6-luna` | `low` | C | C | medium | Low-risk mechanical or high-volume work after local quality validation |

### Claude routes

All Claude routes are Anthropic and run through Claude native or `claude -p`.
Claude subscription reset/caps and burn are `unvalidated`.

| Model | Route effort | Tier | Taste | Evidence | Provisional best fit |
|---|---|:--:|:--:|:--:|---|
| `sonnet-5` | `low` | B | B | medium | Routine-but-real agentic implementation and coding/tool workflows |
| `opus-5` | `high` | A | A | medium | Capability-sensitive coding, long-context investigation, review, and product judgment |

### OpenCode Go routes

Go is the subscription transport. The named upstream family is a capability
clue, not proof that upstream controls, tools, or limits reach Pi.
Use Pi's `default` route setting: omit `--thinking` until a current Go mapping
is measured. `on` and `always-on` are invalid Pi arguments. Model-provider
identity behind Go is unverified; a Go route does not count as
provider-independent until a route-level provenance decision is recorded.

All Go routes share one executor (`pi -p`), one route effort (`default`, omit
`--thinking`), and one published allowance ($12/5h, $30/week, $60/month
included value). Local burn is `unvalidated` for all of them.

| Upstream family | Model alias | Tier | Taste | Evidence | Provisional best fit |
|---|---|:--:|:--:|:--:|---|
| Z.AI | `opencode-go/glm-5.2` | A | C | medium | Repository-scale investigation, planning, and long-horizon coding candidate |
| Z.AI | `opencode-go/glm-5.1` | C | B | low | Text-only general fallback when its smaller output cap is sufficient |
| Moonshot AI | `opencode-go/kimi-k2.6` | B | A | medium | Multimodal general-agent work; validate local writing preference |
| Moonshot AI | `opencode-go/kimi-k2.7-code` | B | C | medium | Coding-throughput candidate; account for upstream always-thinking latency/token behavior |
| Qwen | `opencode-go/qwen3.7-max` | B | C | low | Text-only, long-context coding and reasoning |
| Qwen | `opencode-go/qwen3.7-plus` | C | C | low | Image/screen-aware coding and general-agent work |
| MiniMax | `opencode-go/minimax-m3` | C | C | medium | Long-context multimodal repository or document work; validate >512K service |
| DeepSeek | `opencode-go/deepseek-v4-pro` | C | C | low | Text-only difficult debugging and reasoning; independent-review candidate after route evaluation |
| DeepSeek | `opencode-go/deepseek-v4-flash` | C | C | low | High-throughput mechanical transformations and low-risk exploration |

## Role routes

| Role and task shape | Primary route | Fallback | Boundary |
|---|---|---|---|
| Hardest or ambiguous implementation | `gpt-5.6-sol` / OpenAI / Codex native or `codex exec` / `high` | `opus-5` / Anthropic / Claude native or `claude -p` / `high` | Preserve implementation scope and isolation; fallback is provider-independent |
| Clear-spec implementation | `gpt-5.6-terra` / OpenAI / Codex native or `codex exec` / `medium` | `sonnet-5` / Anthropic / Claude native or `claude -p` / `low` | Preserve tests and write isolation; fallback is provider-independent |
| Low-risk mechanical work | `gpt-5.6-luna` / OpenAI / `codex exec` / `low` | `opencode-go/deepseek-v4-flash` / OpenCode Go / `pi -p` / `default` | Use only after a narrow acceptance check; no silent broadening of scope |
| Repository-scale planning or investigation | `opencode-go/glm-5.2` / OpenCode Go service, provider unverified / `pi -p` / `default` | `opus-5` / Anthropic / Claude native or `claude -p` / `high` | Prefer read-only execution; treat both as provisional until route evaluation |
| Multimodal work | `opencode-go/kimi-k2.6` / OpenCode Go service, provider unverified / `pi -p` / `default` | `opencode-go/qwen3.7-plus` / OpenCode Go service, provider unverified / `pi -p` / `default` | Confirm image/video input and required tool behavior at dispatch; these are not independent providers |
| User-facing UI, API, copy, or product judgment | `opus-5` / Anthropic / Claude native or `claude -p` / `high` | `gpt-5.6-sol` / OpenAI / Codex native or `codex exec` / `high` | Treat output taste as a maintainer decision, not a measured score; fallback is provider-independent |
| Routine review | `sonnet-5` / Anthropic / Claude native or `claude -p` / `low` | `gpt-5.6-terra` / OpenAI / Codex native or `codex exec` / `medium` | Use read-only executor controls; fallback is provider-independent |
| High-risk independent review | `opus-5` / Anthropic / read-only Claude route / `high` **and** `gpt-5.6-sol` / OpenAI / read-only Codex route / `high` | Reroute only to a distinct, available provider approved for the same review scope | Require both for auth, security, secrets, money, destructive data changes, migrations, public contracts, and cross-slice integration |
| Research | `opencode-go/glm-5.2` / OpenCode Go service, provider unverified / read-only `pi -p` / `default` | `opus-5` / Anthropic / read-only Claude route / `high` | Define sources and stop criteria; do not treat upstream Go features as available without a probe |
| Integration and final acceptance | Current orchestrator | None | The orchestrator inspects diffs, resolves conflicts, runs verification, and accepts the result |

## Fallback and independence

- A fallback keeps the same role, acceptance criteria, write/read boundary, and
  required isolation. It is for execution failure, not an unapproved quality
  retry.
- Check availability at dispatch. A missing model, unsupported effort, or
  unavailable executor stops the card; propose the listed fallback for approval.
- Provider independence requires distinct, verified providers, not merely
  distinct executors or subscription services. Codex native and `codex exec`
  are both OpenAI; Claude native and `claude -p` are both Anthropic. Do not
  count any OpenCode Go route as provider-independent until route-level
  provenance is recorded.
- T3 can use an exact model only when its current surface advertises that
  override. Otherwise use the selected model's approved native or CLI executor.
- Pi/OpenCode Go routes may use only documented Pi thinking values. Until a Go
  mapping is validated, `default` means omit `--thinking`.

## Evidence and validation

See the dated [research synthesis](research/2026-07-28/README.md) for raw
benchmark evidence, model aliases, executor contracts, API-price context, and
the evidence behind this policy. Use [`CALIBRATION.md`](CALIBRATION.md) for a
future allowance-approved route evaluation. Research and calibration are
evidence, not active policy; this file is the single routing reference.
