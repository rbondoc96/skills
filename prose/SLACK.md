# Slack & chat

Apply the voice from `SKILL.md`. Slack is the loosest register: capitalized and punctuated, but conversational rather than polished. Natural informal phrasing like "yeah" is fine when it fits. Mirror the thread's tone if it's already looser. No em-dashes. Code in backticks.

## Shape

- **Lead with the point.** The first line should carry the message. Someone skimming should get it from line one.
- **Short.** One idea per message. If it needs sections, it probably needs a thread or a doc, so say so.
- **One question at a time** when you actually need an answer. Easier to reply to. Group closely related questions under a straightforward setup when they need shared context.
- Break a multi-part update into short bullets, not a wall of text.
- **Show uncertainty naturally.** Use exploratory framing such as "it does look like" when the conclusion is provisional. End with an open question when you genuinely want someone to fill a gap, not as a stock sign-off.

## Formatting

- Use `code formatting` for identifiers, commands, filenames, values, branches.
- Bullets for lists of 3+; inline for 2 or fewer.
- Bold sparingly, for the one thing that matters (a decision, a deadline, an ask).

## Emoji & tone

- Light and occasional. A single fitting emoji (`👍`, `✅`, `🙏`) is fine. Never strings, never decorative.
- Match the thread's energy. If it's playful you can be; if it's heads-down, stay flat.

## Asks & status

- Make the ask explicit and bounded: what you need, from whom, by when.
- Status updates: what's done, what's blocked, what's next. Skip the narrative of how you got there.
- Blocked? Say what you're blocked on and what would unblock you, in the same message.

## Voice example

Use this as a tone reference, not a template to copy:

> After looking into it, yeah it does look like most of this was handled in the earlier changes. I found an unused validation path and some stale test mocks we can remove.
>
> Regarding what's left:
> - Does `SharedComponent` need to handle the fallback automatically, or is the value passed by each caller enough?
> - I found a few older implementations that bypass it. Are any of those the places you meant were missed?
>
> Is there anything I'm missing?

This works because it is informed but not overconfident, technically specific, conversational, and genuinely open to correction.

## Examples

Standup: `Done: shipped the parser fix. Today: PR review, then starting on the webhook retry. No blockers.`

Ask: `Can you unblock the staging deploy? I need the DB migration approved to test the fix. No rush, sometime today is fine.`

Heads-up: `Heads up: I reverted the caching change, it was dropping headers. I'll redo it properly tomorrow.`
