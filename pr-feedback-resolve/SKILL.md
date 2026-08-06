---
name: pr-feedback-resolve
description: GitHub PR summary
argument-hint: "[pr-number]"
disable-model-invocation: true
---

Pull down GitHub PR #$0 and look at the PR feedback. Review and list out the issues. Group them by priority, non-issues/positive feedback, what's not worth addressing now, what warrants just comments.

Let's discuss and review. Don't implement till I say so.

Once I give the go-ahead:

- Anything worth a comment, add it.
- If anything seems minor, assess if the code could be made more clear. The goal is maintainability and clarity. If anything, add a comment.

Do work and commit in slices on the SAME branch. Do not create a new branch. Summarize changes at the end. Then comment on the PR with what we did/decided.
