# Pull requests & review comments

Apply the voice from `SKILL.md`. A reviewer's time is the scarce resource, so write to save it. No em-dashes. Code, tools, and branches in backticks.

## Descriptions

Match any existing PR template in the repo first. Otherwise use this shape:

- **`## Description`** with a bulleted summary of what changed. Full sentences, periods on each bullet, one change per bullet.
- **Subsections with bold or `##` headings** when the change has distinct parts ("Code Standards Callouts", "Broadened Rules", etc.). Introduce them with a short line and a colon ("Worth calling out:").
- **Nested bullets** for sub-points under a bullet.
- **GitHub callouts** for meta notes: `> [!NOTE]` for draft status, dependencies, or context the reviewer needs up front.
- Point the reviewer where to start, call out tradeoffs, flag anything out of scope.
- If something is genuinely uncertain or incomplete, say so plainly and invite feedback. Don't tack on a humble "feedback encouraged" closer by reflex; use it only when it's real. A single 🙏 is on-voice when it is.

Keep it scannable. Don't restate the diff line by line; summarize intent.

### Skeleton

```
## Description

- Added X and linked it from the README.
- Split Y into focused files.

Worth calling out:

- Z now extends W, so shared guidance moved into W.
- `someFlag` now applies to all of A, not just B.

> [!NOTE]
> Keeping this in draft pending `other-branch` merge.
```

(If part of the change is genuinely uncertain, add a short honest note about it. Skip it otherwise.)

## Review comments (leaving them)

- Be specific and actionable: point at the line, say what and why, suggest the fix.
- Separate blocking from non-blocking. Prefix optional ones: `nit:`, `optional:`, `question:`.
- Critique the code, not the person. Ask rather than accuse when unsure: "is this handling the null case?" beats "this is broken".
- Praise briefly when something's genuinely well done. One sincere line, not performative.

## Replying to reviewers

- Answer the question directly. If they're right, say so and fix it. No defensiveness.
- If you disagree, give the reason concisely and stay open. It's a discussion, not a defense.
- "Done" or "good catch, fixed in `a3f9c1`" is a complete reply. Don't pad it.
