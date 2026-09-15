# Observability

Own whether an operator can detect and explain failures in the changed system. This angle is separate from records about the reviewers themselves. Reliability owns recovery behavior.

## Investigate

- Trace an affected failure from user-visible symptom to logs, metrics, traces, and alerts. Check whether context survives asynchronous or service boundaries.
- Check swallowed errors, misleading success signals, missing correlation, and diagnostic information that cannot distinguish plausible causes.
- Check telemetry cardinality, volume, sensitive data exposure, and whether an alert supports a useful action.

## Evidence bar

Name a concrete failure and the diagnostic question an operator cannot answer, or the noise/cost/exposure introduced. Show existing instrumentation before requesting more. Propose the minimum useful signal with its location and intended consumer. Logging every operation is not a substitute for an actionable diagnostic path.
