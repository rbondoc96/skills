# Security

Own trust boundaries, authorization, sensitive information, and attacker-controlled input. API compatibility owns ordinary caller breakage; data integrity owns non-adversarial corruption.

## Investigate

- Trace untrusted input to sensitive reads/writes, execution, queries, rendered content, and outbound requests. Identify actual attacker control and reachable paths.
- Check authentication versus authorization, tenant/object ownership, privilege changes, and session lifecycle in the affected flow.
- Check exposure of credentials and personal data through responses, errors, persistence, or telemetry.
- Check changed dependency/configuration behavior when it creates a concrete exposure. Verify version-specific vulnerability claims against authoritative evidence when needed.

## Evidence bar

Name the attacker capability, required conditions, reachable action, and affected asset. Distinguish a demonstrated exposure from optional hardening. Use safe reasoning and bounded local checks; exploitation of live services and credential disclosure are outside review scope.
