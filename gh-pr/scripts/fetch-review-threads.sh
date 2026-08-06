#!/usr/bin/env bash
set -euo pipefail

if (($# != 3)); then
  echo "Usage: $(basename "$0") <owner> <repo> <pr-number>" >&2
  exit 2
fi

owner="$1"
repo="$2"
pr_number="$3"

if [[ ! "$pr_number" =~ ^[1-9][0-9]*$ ]]; then
  echo "PR number must be a positive integer" >&2
  exit 2
fi

gh api graphql --paginate --slurp \
  -F owner="$owner" \
  -F repo="$repo" \
  -F number="$pr_number" \
  -f query='query($owner: String!, $repo: String!, $number: Int!, $endCursor: String) {
    repository(owner: $owner, name: $repo) {
      pullRequest(number: $number) {
        reviewThreads(first: 100, after: $endCursor) {
          nodes {
            id
            isOutdated
            isResolved
            path
            line
            startLine
            diffSide
            startDiffSide
            resolvedBy { login }
            comments(first: 100) {
              nodes {
                id
                databaseId
                url
                body
                createdAt
                author { login }
                replyTo { id }
              }
              pageInfo { hasNextPage }
            }
          }
          pageInfo { hasNextPage endCursor }
        }
      }
    }
  }' |
  jq -e '
    [.[].data.repository.pullRequest.reviewThreads.nodes[]] as $threads
    | if any($threads[]; .comments.pageInfo.hasNextPage)
      then error("A review thread has more than 100 comments; complete nested pagination before continuing")
      else $threads
      end
  '
