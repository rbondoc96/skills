---
name: pr-review
description: Review a GitHub pull request with two independent reviewers from different model providers, then consolidate their findings into one Markdown file under ~/.pr-reviews. Strictly read-only — never edits, comments on, or approves the PR. Use when the user wants a PR reviewed, drops a GitHub PR URL to review, asks for a cross-model or second-opinion PR review, or wants review findings written to a file to apply by hand.
disable-model-invocation: true
---

# PR Review

Orchestrate two **read-only**, independent reviews of a GitHub pull request — one per model provider — and consolidate them into a single Markdown file the user applies by hand.

**Read-only is absolute.** No agent in this skill — main or sub — ever edits, comments on, reviews, approves, or otherwise mutates the PR or repo. Allowed writes are exactly: local files under `/tmp` and the consolidated file under `~/.pr-reviews`. Never run `gh pr comment/review/edit/merge/close`, any writing `gh api` (POST/PATCH/PUT/DELETE), `git push`, or any command that changes remote state.

## Steps

1. **Resolve the PR.** If the user did not pass a GitHub PR URL, ask for one and stop until given. Parse `owner`, `repo`, and `number` from it.
2. **Require orchestration.** Load the `orchestration` skill. If it is not installed, stop and tell the user to install it — do not attempt to dispatch without it. Orchestration owns all dispatch, provider, and approval mechanics; this skill only supplies the review task.
3. **Gather PR context (read-only).** Capture PR metadata, the full diff, and the changed-file list, e.g. `gh pr view <number> --repo <owner>/<repo>`, `gh pr diff <number> --repo <owner>/<repo>`, `gh pr view <number> --json ...`. Record base and head SHAs. Done when every changed file and the diff are captured and `owner/repo/number` plus base/head SHAs are recorded.
4. **Choose two reviewers.** Detect which providers are reachable (the running harness itself is one; check `codex` and `pi` on `PATH` for the others). Pick two from **different** providers. If fewer than two distinct providers are available, stop and report which are missing.
5. **Propose the plan and get explicit approval.** Using orchestration's approval table, show the user: the two chosen reviewer models/harnesses, the PR under review, the `/tmp` output paths, and the read-only boundary. **Hard stop** — dispatch nothing until the user approves.
6. **Dispatch two independent reviews.** Give each reviewer the PR context, the review task below, and [`FINDINGS.md`](FINDINGS.md) as the required output contract. Each writes its findings to its own `/tmp` file. Done when both files exist and are non-empty.
7. **Consolidate.** Merge both findings into one Markdown file at `~/.pr-reviews/<owner>-<repo>-pr<number>-<timestamp>.md` per [`FINDINGS.md`](FINDINGS.md). Drop any finding whose rationale you cannot substantiate against the diff or gathered context. Every surviving finding from both reviewers is accounted for — merged (noting agreement) or listed. Done when the file is written.
8. **Report.** Print the consolidated file's absolute path to the user. Do not apply the findings.

## Review task (given to each reviewer)

Review the PR for correctness bugs, regressions, security issues, missing tests, and requirement/scope mismatches. Prioritize findings over summary. Every finding is grounded — cite the code/behavior it rests on and the concrete consequence; prefer fewer grounded findings over speculation. Each finding targets one of: **(1)** the whole PR, **(2)** a specific file, or **(3)** a specific line range in a file. Follow [`FINDINGS.md`](FINDINGS.md) exactly for format, scopes, the line-range URL, and code/suggestion blocks. Read-only: do not edit files or touch the PR.

## Non-negotiables

- Read-only, as defined above. This binds the main agent and every subagent.
- Two reviewers from different providers, chosen at run time from what is reachable.
- Explicit user approval of the dispatch plan before any dispatch.
- Findings — `/tmp` files and the consolidated file — follow [`FINDINGS.md`](FINDINGS.md).
