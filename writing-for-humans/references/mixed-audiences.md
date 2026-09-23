# Mixed audiences

Use when one piece of writing serves readers with different knowledge or responsibilities. Apply the shared foundation in `SKILL.md` and organize around a common purpose.

## Establish the shared purpose

Identify what everyone must understand and the primary decision or action the writing supports. Prioritize explicit user direction, then the needs of the person responsible for that decision. Ask only if competing purposes would materially change the message.

Mixed responsibilities do not always require multiple sections. A short message may serve everyone with one concrete explanation.

## Layer detail where needed

1. Open with the shared outcome, impact, or decision. Include uncertainty and conditions that could change that decision here.
2. Explain enough cause or evidence for every reader to assess the opening.
3. Add clearly labeled specialist detail only for readers who need it. Use stable terminology across the whole piece and explain unfamiliar terms at the shared entry point.

Read [developer guidance](developers.md) only when technical sections need mechanisms, contracts, or verification evidence. Read [stakeholder guidance](stakeholders.md) only when decision or coordination sections need options, ownership, or timing. Those references select detail; the shared purpose controls order and emphasis.

Avoid repeating the same facts in separate versions for each audience. A reader who skips specialist detail must still receive every qualification needed to interpret the main point correctly. Honor an explicit request for separate deliverables when the audiences need different messages.

## Example

Assume the source establishes that payment retries can create duplicate orders, the server treats each retry as new, and request-key reuse is a proposed fix.

> Checkout can create duplicate orders when customers retry a payment. We recommend fixing this before the next release.
>
> **Implementation detail:** The server currently creates a new order for every retry. Reusing the original request key would let it recognize a repeated request.

The first paragraph supports a release decision. The second gives developers a mechanism to assess. If the proposed fix is unverified, its uncertainty belongs beside the proposal; if it could affect the release recommendation, explain that in the opening too.
