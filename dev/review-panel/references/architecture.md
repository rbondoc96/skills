# Architecture

Own responsibilities, dependency direction, and system-wide tradeoffs across packages, services, or deployment boundaries. Code structure owns local implementation simplicity.

## Investigate

- Trace which component owns the decision and data, which components depend on it, and how the change crosses boundaries.
- Check alignment with documented architecture and actual consumers. Identify duplicated authority, cycles, or coordination that ties independent components together.
- Assess deployment/rollout coupling and whether the change creates a new operational responsibility or external dependency.

## Evidence bar

Name the affected components and a concrete change, deployment, or failure scenario made harder by the decision. Explain the smallest useful boundary adjustment and its cost. Respect deliberate documented tradeoffs; a preferred architectural style alone is not evidence. Broader redesign belongs in a separate proposal.
