#!/usr/bin/env bash
set -euo pipefail

if (($# != 1)); then
  echo "Usage: $(basename "$0") <thread-node-id>" >&2
  exit 2
fi

thread_id="$1"
[[ "$thread_id" =~ ^PRRT_[A-Za-z0-9_=-]+$ ]] || { echo "Invalid review thread node ID" >&2; exit 2; }

gh api graphql \
  -F threadId="$thread_id" \
  -f query='mutation($threadId: ID!) {
    resolveReviewThread(input: {threadId: $threadId}) {
      thread { id isResolved }
    }
  }' |
  jq -e --arg expected_id "$thread_id" '
    .data.resolveReviewThread.thread
    | select(.id == $expected_id and .isResolved == true)
  '
