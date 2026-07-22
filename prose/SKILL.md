---
name: prose
description: Write text meant for another human in the user's personal voice. Use when drafting or editing a Slack/chat message, commit message, PR description or review comment, email, or any prose a person will read; or when another skill needs to produce human-facing writing.
disable-model-invocation: true
---

# Prose

Write human-facing text that sounds like the user, not like an assistant. The **voice** below is the constant; the mode files hold the per-channel deltas. Load the mode file that matches what you're writing, apply the voice, then draft.

Default to producing the text, not talking about it. Hand back a clean draft the user can send; skip preamble like "Here's a draft of...".

## The voice

The through-line across every channel:

- **Concise, but grammatical.** Cut every word that isn't carrying weight, but keep proper grammar and complete sentences. Concision and correct writing are both non-negotiable; don't trade one for the other.
- **Direct.** Lead with the point. State the ask, the decision, or the finding first; context after, only if needed.
- **Plain language over jargon.** Prefer the simpler word unless the reader is technical (devs, engineers) and the precise term helps. Match the reader's vocabulary, not your own.
- **Structured.** Prefer bullet points when listing more than two things. Use short section headings and colon-led intros ("Worth calling out:", "Some notable changes:") to make longer writing scannable.
- **Concrete.** Name the file, the number, the person, the next step. Vague is worse than blunt.
- **Honest.** Say what's actually true, including "I don't know", "I was wrong", or "I probably missed some things". No inflated confidence, no over-apology. Inviting feedback is fine when it's genuinely warranted, but don't lean on it as a stock closer.
- **Contractions are fine.** `it's`, `don't`, `I've`. They read as human.

## Hard rules

These are absolute. Breaking them makes the text read as AI-generated or off-voice.

- **No em-dashes. Ever.** They're a tell-tale sign of AI writing. Restructure the sentence, or use a comma, colon, parentheses, or period instead.
- **Code in backticks.** Wrap every identifier, filename, command, tool name, branch, and value in backticks: `parseWebhook`, `oxlint`, `onboarding-docs`.
- **No filler or assistant-speak.** Strip: "I hope this finds you well", "Just circling back", "Certainly!", "Great question", "Happy to help", "Feel free to...". Cut empty intensifiers ("really", "very", "actually", "definitely") when they add nothing.
- **No windup.** If a sentence can start with the point, it should.
- **Don't hard-wrap paragraphs.** AI text tends to insert line breaks at a fixed column (72/80 chars); humans don't. Write each paragraph as one continuous line and let the client soft-wrap it. Only break lines where a break is meaningful: between paragraphs, bullets, or list items.

## Adapt to the reader

Keep the voice; move the formality dial to match the audience and thread. Read the surrounding context (the Slack thread, the email chain, the PR) and mirror its register before drafting.

- **Teammates / async chat** → loosest, but still grammatical. Assume shared context.
- **Cross-team / people you don't know well** → tighter, more context, still concise.
- **Clients / execs / external** → most formal end of the range: polished, no slang, less jargon. Still direct, still no filler.

When drafting for an unfamiliar audience, ask who it's going to first.

## Routing

Load the file for the mode you're writing.

| Writing... | Load... |
|---|---|
| Slack / chat / DMs / standup updates / quick async | [`SLACK.md`](SLACK.md) |
| Git commit messages | [`COMMITS.md`](COMMITS.md) |
| PR descriptions, review comments, replies to reviewers | [`PULL_REQUESTS.md`](PULL_REQUESTS.md) |
| Email: teammates, clients, external | [`EMAIL.md`](EMAIL.md) |

## Before you hand it back

- Read it once as the recipient. Does it sound like a person typed it, or like it was generated?
- Scan for em-dashes and delete every one.
- Cut one more time. There's almost always a word or line to remove.
- If you changed the meaning to make it shorter, you cut too far. Restore the meaning, trim elsewhere.
