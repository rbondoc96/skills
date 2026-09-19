# AI integrations

Scope: model calls, generated structured output, tool execution, and model usage accounting in any language. Provider-specific syntax belongs in the installed SDK's documentation or the project's adapter.

## Provider boundary

- Keep provider construction, credentials, request translation, and failure classification at an owned boundary. Reuse an existing adapter when it already owns the capability.
- Obtain model capabilities and limits from current project configuration or provider documentation. Keep reusable settings in one owner; avoid copying model-name lists and limits into callers or these standards.
- Treat model output as untrusted data. Parse structured output before domain use, and report refusal, malformed output, and provider failure distinctly when callers handle them differently.
- Treat tool arguments as untrusted input. Application authorization and side-effect policy govern execution; model-generated instructions cannot grant permissions.

## Attempts and accounting

- Define time, concurrency, attempt, and usage limits for the operation. Inspect SDK retries before adding application retries so the combined attempt count stays bounded.
- Distinguish transient-call retries from structured-output repair. Make repair policy explicit instead of silently repeating an unbounded request.
- Propagate cancellation and stop further model/tool attempts when the operation is cancelled. Document dependencies that cannot stop an in-flight request.
- Account for usage across all reported attempts, including repairs and failed attempts with usage data. Represent unavailable usage as unknown rather than zero; distinguish token measurements from cost estimates.
- Keep prompts, generated text, credentials, and raw provider exceptions out of routine diagnostics. Use safe error categories, attempt numbers, and correlation fields.

## Verification

Use deterministic provider substitutes to exercise success, malformed output, refusal, transient failure, exhausted retries, cancellation, and usage aggregation as relevant to the change. Assert semantic results and recorded requests at the adapter boundary. Ordinary tests should not spend provider credits; live evaluation is a separate, explicitly scoped activity.
