---
name: pr-summary
description: Draft and update a structured GitHub pull request description for the current branch or a specified PR, with optional Linear issue coverage and useful technical visuals.
argument-hint: "[pr-number-or-url]"
disable-model-invocation: true
---

# PR Summary

Build a reviewable PR description from repository evidence, stage it as Markdown, and update GitHub only after approval.

## Workflow

1. **Resolve the PR.** Read [`references/GH_READS.md`](references/GH_READS.md). Accept a PR number or URL. Without one, resolve the PR for the current branch. Record the repository, PR number, URL, base/head branches, base/head SHAs, existing body, and repository PR template. If an explicitly supplied PR is not associated with the current branch, state that clearly and continue only when the user intended a remote-only summary. Stop when the target is ambiguous.
2. **Gather evidence.** Read the base-to-head diff, commit subjects, changed files, existing PR body, relevant project docs, and verification evidence. Never claim a check passed merely because its tests changed.
3. **Resolve Linear context.** Discover candidate issue IDs from user input, the branch, commits, PR title, and existing body. Use an available read-only Linear interface to retrieve issue descriptions and explicit acceptance criteria. Treat `Resolves` as a judgment: use it only when merging this PR completes the issue. Use `Contributes to` when it advances but does not complete the issue. If the relationship is unclear, ask before drafting it. Never invent acceptance criteria or mutate Linear. If issue details are unavailable, keep confirmed link statements and omit the checklist.
4. **Draft the description.** Read [`references/PR_WRITING.md`](references/PR_WRITING.md) and [`references/TEMPLATE.md`](references/TEMPLATE.md). Preserve repository-specific template sections and user-authored content. Use the managed block in the template when adding to an existing body; replace an existing managed block instead of appending another.
5. **Add a visual only when useful.** Use the smallest visual that materially clarifies a non-trivial flow, sequence, state change, hierarchy, or repeated-field comparison. Prefer Mermaid for relationships and Markdown tables for exact mappings. Ground every element in repository evidence. Omit decorative or repetitive visuals.
6. **Stage the draft.** Write the exact proposed PR body to `~/.pr-drafts/<owner>-<repo>/pr-<number>/summary.md`. Report the path and stop for review. The user may edit or annotate it.
7. **Apply after approval.** Read [`references/GH_WRITES.md`](references/GH_WRITES.md). Reread the file after approval, validate its Linear relationships, acceptance claims, Mermaid fences, and managed-block uniqueness, then update the PR body. Read the remote body back and verify the approved content appears exactly once.

## Completion

Complete when the staged draft exists, or, after approval, when the remote PR body matches the current staged file. Report the draft path, PR URL, and whether GitHub was changed.
