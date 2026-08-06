# Feedback plan format

Write the plan to `~/.pr-drafts/<owner>-<repo>/pr-<number>/feedback-plan.md`.

```markdown
# Feedback resolution plan

- PR: <owner/repo#number>
- URL: <url>
- Head: <full SHA>
- Generated: <ISO-8601 timestamp>

## Blocking

### T01: <Short title>

- Thread: <URL>
- Thread ID: `<GraphQL node ID>`
- Reviewer: `<login>`
- Location: `<path:line>`
- State: <unresolved | resolved | outdated>
- Disposition: <address | reply | clarify | defer | no-action | positive>
- Proposed change: <change or `None`>
- Verification: `<command>` or <manual check>
- Proposed reply: <draft or `None`>
- Resolve after reply: <Yes | No>
- Result: Pending
- Original commit: Pending
- Current commit: Pending
- Amended: Pending
- Reply posted: No
- Thread resolved: No
```

Repeat the entry under `Important`, `Minor`, `Informational`, `Deferred`, or `Positive` as appropriate. Give every timeline comment, submitted review, and review thread an ID or account for it as a duplicate under another ID.

## Execution updates

- Replace `Pending` values with the observed result.
- Preserve both hashes when a commit is amended.
- Record exact verification and whether it passed, failed, or was not run.
- Leave incomplete or intentionally open items visible.
- Treat user edits and annotations as authoritative unless they are ambiguous or unsafe; stop and ask rather than silently reinterpret them.
