---
name: pr-summary
description: GitHub PR summary
argument-hint: "[pr-number]"
disable-model-invocation: true
---

Look in remote GitHub repo PR #$0. Should be associated to this branch. If it not found or it's not associated to this branch, stop and state why.

If it does, append to the PR description a summary of the changes. Include these sections if the PR has content to fill them:

- New Features
- Bug Fixes
- Documentation
- Tests
- Important Notes

Feel free to add more sections if needed. The summaries should be short and concise, yet descriptive. Use scannable bullet points and simple yet descriptive terms. For new terms, too "technical" terms, or domain-specific terms not captured by the project's existing docs, add a footnote with short descriptions, definitions, etc.
