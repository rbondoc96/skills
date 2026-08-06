# PR feedback replies

Write direct, specific replies that save the reviewer's time. Answer the thread where the context lives. Critique or discuss the code, never the person.

## Forms

Use the shortest form that preserves useful context:

```markdown
Fixed in `a3f9c1b`. Empty responses now return a typed empty result.
```

```markdown
Fixed by amending `a3f9c1b`. The updated commit is `d8e42ac`. Empty responses now return a typed empty result.
```

```markdown
Fixed across `a3f9c1b` and `d8e42ac`. The parser and its caller now share the same empty-state contract.
```

```markdown
No code change. The existing behavior is intentional because retries must preserve the original request ID.
```

```markdown
Not changing this in this PR. The client migration affects unrelated callers and should land separately.
```

## Rules

- State what changed and why when the commit alone is insufficient.
- Say explicitly when a commit was amended, and include both the old and current short hashes.
- Do not claim an amend when commit lineage cannot be established.
- Link an existing follow-up issue when relevant; never create one without approval.
- Reply before resolving when the reply adds context.
- Do not post a PR-level comment that merely repeats thread replies.
- Use a PR-level comment only for cross-thread decisions, shared deferrals, multi-thread changes, important remaining work, or shared verification context.
- Remove every em dash and unnecessary word before posting.
