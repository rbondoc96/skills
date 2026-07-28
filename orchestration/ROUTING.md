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
- Intelligence and taste are `unvalidated` for every card. Raw evidence may
  guide a provisional policy; it does not make scores comparable.
- Best-fit statements below are maintainer inferences. Revalidate them against
  the actual model + executor + settings route.

## Model cards

### Codex routes

| Provider | Model | Executor / transport | Route effort | Subscription allowance / burn | Evidence status | Provisional best fit |
|---|---|---|---|---|---|---|
| OpenAI | `gpt-5.6-sol` | Codex native or `codex exec`; T3 native only when the exact override is advertised | `high` | Codex executor: Codex subscription `unvalidated`; T3 native: T3 allowance `unvalidated` | Intelligence/taste `unvalidated`; strong GPT-5.6 family raw evidence (medium) | Hard, high-value coding, reasoning, and user-facing artifacts |
| OpenAI | `gpt-5.6-terra` | Codex native or `codex exec`; T3 native only when the exact override is advertised | `medium` | Codex executor: Codex subscription `unvalidated`; T3 native: T3 allowance `unvalidated` | Intelligence/taste `unvalidated`; middle GPT-5.6 family raw evidence (medium) | Clear-spec implementation and cost-balanced coding candidate |
| OpenAI | `gpt-5.6-luna` | Codex native or `codex exec`; T3 native only when the exact override is advertised | `low` | Codex executor: Codex subscription `unvalidated`; T3 native: T3 allowance `unvalidated` | Intelligence/taste `unvalidated`; lower GPT-5.6 family raw evidence (medium) | Low-risk mechanical or high-volume work after local quality validation |

### Claude routes

| Provider | Model | Executor / transport | Route effort | Subscription allowance / burn | Evidence status | Provisional best fit |
|---|---|---|---|---|---|---|
| Anthropic | `sonnet-5` | Claude native or `claude -p` | `high` | Claude subscription; reset/caps and burn `unvalidated` | Intelligence/taste `unvalidated`; exact Terminal-Bench coding evidence (medium) | Routine-but-real agentic implementation and coding/tool workflows |
| Anthropic | `opus-5` | Claude native or `claude -p` | `high` | Claude subscription; reset/caps and burn `unvalidated` | Intelligence/taste `unvalidated`; strong raw coding/reasoning/tool evidence (medium) | Capability-sensitive coding, long-context investigation, review, and product judgment |

### OpenCode Go routes

Go is the subscription transport. The named upstream family is a capability
clue, not proof that upstream controls, tools, or limits reach Pi.
Use Pi's `default` route setting: omit `--thinking` until a current Go mapping
is measured. `on` and `always-on` are invalid Pi arguments. Model-provider
identity behind Go is unverified; a Go route does not count as
provider-independent until a route-level provenance decision is recorded.

| Subscription service | Upstream family | Model alias | Executor | Route effort | Subscription allowance / burn | Evidence status | Provisional best fit |
|---|---|---|---|---|---|---|---|
| OpenCode Go | Z.AI | `opencode-go/glm-5.2` | `pi -p` | `default` (omit `--thinking`) | Published $12/5h, $30/week, $60/month included-value limits; local burn `unvalidated` | Intelligence/taste `unvalidated`; multi-domain vendor raw evidence (medium) | Repository-scale investigation, planning, and long-horizon coding candidate |
| OpenCode Go | Z.AI | `opencode-go/glm-5.1` | `pi -p` | `default` (omit `--thinking`) | Published $12/5h, $30/week, $60/month included-value limits; local burn `unvalidated` | Intelligence/taste `unvalidated`; one non-route Terminal-Bench result (low) | Text-only general fallback when its smaller output cap is sufficient |
| OpenCode Go | Moonshot AI | `opencode-go/kimi-k2.6` | `pi -p` | `default` (omit `--thinking`) | Published $12/5h, $30/week, $60/month included-value limits; local burn `unvalidated` | Intelligence/taste `unvalidated`; multimodal vendor raw evidence (medium) | Multimodal general-agent work; validate local writing preference |
| OpenCode Go | Moonshot AI | `opencode-go/kimi-k2.7-code` | `pi -p` | `default` (omit `--thinking`) | Published $12/5h, $30/week, $60/month included-value limits; local burn `unvalidated` | Intelligence/taste `unvalidated`; coding/tool vendor raw evidence (medium) | Coding-throughput candidate; account for upstream always-thinking latency/token behavior |
| OpenCode Go | Qwen | `opencode-go/qwen3.7-max` | `pi -p` | `default` (omit `--thinking`) | Published $12/5h, $30/week, $60/month included-value limits; local burn `unvalidated` | Intelligence/taste `unvalidated`; vendor positioning only (low) | Text-only, long-context coding and reasoning |
| OpenCode Go | Qwen | `opencode-go/qwen3.7-plus` | `pi -p` | `default` (omit `--thinking`) | Published $12/5h, $30/week, $60/month included-value limits; local burn `unvalidated` | Intelligence/taste `unvalidated`; vendor positioning only (low) | Image/screen-aware coding and general-agent work |
| OpenCode Go | MiniMax | `opencode-go/minimax-m3` | `pi -p` | `default` (omit `--thinking`) | Published $12/5h, $30/week, $60/month included-value limits; local burn `unvalidated` | Intelligence/taste `unvalidated`; vendor raw benchmark evidence (medium) | Long-context multimodal repository or document work; validate >512K service |
| OpenCode Go | DeepSeek | `opencode-go/deepseek-v4-pro` | `pi -p` | `default` (omit `--thinking`) | Published $12/5h, $30/week, $60/month included-value limits; local burn `unvalidated` | Intelligence/taste `unvalidated`; vendor positioning only (low) | Text-only difficult debugging and reasoning; independent-review candidate after route evaluation |
| OpenCode Go | DeepSeek | `opencode-go/deepseek-v4-flash` | `pi -p` | `default` (omit `--thinking`) | Published $12/5h, $30/week, $60/month included-value limits; local burn `unvalidated` | Intelligence/taste `unvalidated`; vendor positioning only (low) | High-throughput mechanical transformations and low-risk exploration |

## Role routes

| Role and task shape | Primary route | Fallback | Boundary |
|---|---|---|---|
| Hardest or ambiguous implementation | `gpt-5.6-sol` / OpenAI / Codex native or `codex exec` / `high` | `opus-5` / Anthropic / Claude native or `claude -p` / `high` | Preserve implementation scope and isolation; fallback is provider-independent |
| Clear-spec implementation | `gpt-5.6-terra` / OpenAI / Codex native or `codex exec` / `medium` | `sonnet-5` / Anthropic / Claude native or `claude -p` / `high` | Preserve tests and write isolation; fallback is provider-independent |
| Low-risk mechanical work | `gpt-5.6-luna` / OpenAI / `codex exec` / `low` | `opencode-go/deepseek-v4-flash` / OpenCode Go / `pi -p` / `default` | Use only after a narrow acceptance check; no silent broadening of scope |
| Repository-scale planning or investigation | `opencode-go/glm-5.2` / OpenCode Go service, provider unverified / `pi -p` / `default` | `opus-5` / Anthropic / Claude native or `claude -p` / `high` | Prefer read-only execution; treat both as provisional until route evaluation |
| Multimodal work | `opencode-go/kimi-k2.6` / OpenCode Go service, provider unverified / `pi -p` / `default` | `opencode-go/qwen3.7-plus` / OpenCode Go service, provider unverified / `pi -p` / `default` | Confirm image/video input and required tool behavior at dispatch; these are not independent providers |
| User-facing UI, API, copy, or product judgment | `opus-5` / Anthropic / Claude native or `claude -p` / `high` | `gpt-5.6-sol` / OpenAI / Codex native or `codex exec` / `high` | Treat output taste as a maintainer decision, not a measured score; fallback is provider-independent |
| Routine review | `sonnet-5` / Anthropic / Claude native or `claude -p` / `high` | `gpt-5.6-terra` / OpenAI / Codex native or `codex exec` / `medium` | Use read-only executor controls; fallback is provider-independent |
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
