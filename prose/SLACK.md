# Slack & chat

Apply the voice from `SKILL.md`. Slack is the loosest register, but keep proper grammar: complete sentences, capitalized, punctuated, just shorter and warmer than a PR. Mirror the thread's tone if it's already looser. No em-dashes. Code in backticks.

## Shape

- **Lead with the point.** The first line should carry the message. Someone skimming should get it from line one.
- **Short.** One idea per message. If it needs sections, it probably needs a thread or a doc, so say so.
- **One question at a time** when you actually need an answer. Easier to reply to.
- Break a multi-part update into short bullets, not a wall of text.

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

## Examples

Standup: `Done: shipped the parser fix. Today: PR review, then starting on the webhook retry. No blockers.`

Ask: `Can you unblock the staging deploy? I need the DB migration approved to test the fix. No rush, sometime today is fine.`

Heads-up: `Heads up: I reverted the caching change, it was dropping headers. I'll redo it properly tomorrow.`
