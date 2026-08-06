# PR reads

Resolve explicit values once, then pass `--repo <owner>/<repo>` to subsequent `gh pr` commands.

## Metadata

Use `gh pr view <number> --repo <owner>/<repo> --json ...` to request only needed fields. Common fields include `baseRefName`, `baseRefOid`, `body`, `comments`, `commits`, `files`, `headRefName`, `headRefOid`, `latestReviews`, `number`, `reviewDecision`, `reviews`, `statusCheckRollup`, `title`, and `url`.

Use `gh pr diff <number> --repo <owner>/<repo>` for the full patch. Treat metadata comments and reviews as flat summaries; they do not preserve complete thread topology.

## Review threads

Run:

```bash
scripts/fetch-review-threads.sh <owner> <repo> <number>
```

The script returns a JSON array containing thread node IDs, resolution and outdated state, locations, and every fetched reply. It exhausts thread pagination and fails rather than silently truncating a thread with more than 100 comments.

Preserve these identifiers for later writes:

- Thread GraphQL node ID for resolve or reopen.
- Top-level review comment database ID for replies.
- Comment and thread URLs for human review.

## Completion

Complete a feedback read only after timeline comments, submitted reviews, requested changes, and review threads are all accounted for. State explicitly when permissions or API limits prevent complete retrieval.
