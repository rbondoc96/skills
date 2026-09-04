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

# Counts distinct head commits reviewed by someone other than the author, so a
# repeated review of one commit does not inflate the round count.
gh pr view "$pr_number" --repo "$owner/$repo" \
  --json author,headRefOid,reviews --jq '
  .author.login as $author
  | .headRefOid as $head
  | [.reviews[]
      | select(
          .author.login != $author
          and .commit.oid != null
          and (.state == "APPROVED" or .state == "CHANGES_REQUESTED" or .state == "COMMENTED")
        )]
  | . as $eligible
  | ($eligible | map(.commit.oid) | unique) as $reviewed
  | {
      count: ($reviewed | length),
      currentHeadReviewed: (($reviewed | index($head)) != null),
      latestReviewedHeadSha: (($eligible | sort_by(.submittedAt) | last | .commit.oid) // null),
      reviewedHeadShas: $reviewed
    }
'
