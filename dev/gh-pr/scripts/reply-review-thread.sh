#!/usr/bin/env bash
set -euo pipefail

if (($# != 2)); then
  echo "Usage: $(basename "$0") <thread-node-id> <body-file>" >&2
  exit 2
fi

thread_id="$1"
body_file="$2"

[[ "$thread_id" =~ ^PRRT_[A-Za-z0-9_=-]+$ ]] || { echo "Invalid review thread node ID" >&2; exit 2; }
[[ -f "$body_file" && -r "$body_file" ]] || { echo "Body file is not readable: $body_file" >&2; exit 2; }
[[ -s "$body_file" ]] || { echo "Body file must not be empty" >&2; exit 2; }

gh api graphql \
  -F threadId="$thread_id" \
  -F body=@"$body_file" \
  -f query='mutation($threadId: ID!, $body: String!) {
    addPullRequestReviewThreadReply(input: {pullRequestReviewThreadId: $threadId, body: $body}) {
      comment { id body url }
    }
  }' |
  jq -e --argjson expected_body "$(jq -Rs . < "$body_file")" '
    .data.addPullRequestReviewThreadReply.comment
    | select(.id != null and .url != null and .body == $expected_body)
  '
