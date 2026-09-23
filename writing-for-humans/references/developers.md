# Developers

Use when the reader needs to understand, build, debug, maintain, or review a software system. Apply the shared foundation in `SKILL.md`; use this reference to select technical substance.

## Explain behavior and its cause

- Start with the relevant behavior or change. Trace the mechanism only as far as needed to explain it.
- Show concrete inputs, outputs, contracts, and failure conditions when they determine correctness. Identify affected callers or consumers when their behavior changes.
- For bugs, give the trigger, expected behavior, actual behavior, and impact. Include concise reproduction steps when supported by the available evidence.
- For changes, explain the reason, tradeoff, and verification relevant to review. Distinguish tested behavior from an untested expectation.
- Include identifiers, paths, commands, or small code examples when they help the reader locate, reproduce, or apply the explanation. Avoid narrating the diff file by file.

## Match technical depth

Preserve established technical vocabulary. Explain domain-specific or unfamiliar terms according to the reader's demonstrated knowledge, without adding a glossary for routine engineering terms.

For an implementation decision, connect the proposed mechanism to the constraint it satisfies. For onboarding or learning, introduce the mental model before internal details. A technical audience does not automatically require a long explanation.
