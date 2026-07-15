# Findings Format

One contract for both the per-reviewer `/tmp` files and the consolidated file. Markdown throughout.

## Grounded rationale

Every finding is grounded: its body cites the specific code, diff line, or behavior it rests on and states the concrete failure or consequence. Drop anything you cannot substantiate from the diff or gathered context. Prefer fewer grounded findings over speculation.

## Severity scale

`Critical` > `Major` > `Minor` > `Nit`. Add `Question` for things needing author clarification.

## Finding entry

Each finding is one section:

```markdown
### [Severity] Short title

- Scope: pr | file | line-range
- File: path/from/repo/root.ext        (omit for pr scope)
- Lines: R42-R48                        (line-range scope only; see below)
- Link: <url>                           (line-range scope only; see below)

Body in Markdown. State the problem and the fix direction. Include a fenced
code block to illustrate, or a GitHub ```suggestion block when proposing an
exact replacement (line-range scope on head lines only).
```

### Scopes

1. **pr** — applies to the whole PR (architecture, scope, missing coverage). No `File`/`Lines`/`Link`.
2. **file** — applies to one file as a whole. Include `File`, no `Lines`/`Link`.
3. **line-range** — applies to a specific diff range. Include `File`, `Lines`, and `Link`.

### Line-range `Lines` and `Link`

Side prefix: `L` = base/old side, `R` = head/new side. Range is `<side><start>-<side><end>`; a single line is just `<side><n>`.

Build the browser URL that targets the range on the PR's "Files changed" view. The anchor hash is the SHA-256 of the file path as it appears in the diff (repo-root-relative, no `a/`/`b/` prefix):

```bash
HASH=$(printf '%s' "path/from/repo/root.ext" | shasum -a 256 | cut -d' ' -f1)
URL="https://github.com/<owner>/<repo>/pull/<number>/changes#diff-${HASH}R42-R48"
```

`changes` is the current tab slug; `files` also works. Example:
`https://github.com/account/repo/pull/406/changes#diff-48be1514663d6e2eccb521b4be07cc6029e596d6253ca53793374585259df13bL36-L40`

### Suggestion blocks

A GitHub ` ```suggestion ` block only applies to **head-side line-range** findings and must contain the exact replacement for the referenced lines. Use plain code fences for anything illustrative.

## Per-reviewer file (`/tmp`)

Path: `/tmp/pr-review-<owner>-<repo>-pr<number>-<provider>.md`. Start with a one-line header naming the reviewer model and PR, then the findings, most severe first.

## Consolidated file (`~/.pr-reviews`)

Path: `~/.pr-reviews/<owner>-<repo>-pr<number>-<timestamp>.md`. Structure:

```markdown
# Review: <owner>/<repo> PR #<number> — <title>

- PR: <html_url>
- Base/head: <base_sha>..<head_sha>
- Reviewers: <providerA model>, <providerB model>
- Generated: <timestamp>

## Findings

<merged findings, most severe first>
```

Merge rules: when both reviewers raise the same issue, combine into one entry and note the agreement. Keep single-reviewer findings, attributing the reviewer inline. Preserve every finding from both `/tmp` files — merged or listed, none dropped.
