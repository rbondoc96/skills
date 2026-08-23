---
name: tldr-jp
description: Recap the current session's work in Japanese as a learning exercise, with furigana, vocabulary notes, and one grammar point.
argument-hint: "[easy|hard]"
arguments:
  - mode
disable-model-invocation: true
---

# Japanese TL;DR

Recap what this session accomplished as a short Japanese lesson.

The learner already understands the subject matter. Use that understanding
as the scaffold for teaching Japanese, not the other way around.

Read-only. Do not edit files, write code, or commit.

## Mode

Requested mode: `$mode`

- `easy` (default) — heavy reading support, English alongside.
- `hard` — immersion; explanations in Japanese.

Anything missing or unrecognized means `easy`. Never ask the learner to pick.

## Workflow

1. **Pick the subject.** The conversation itself is the primary source:
   whatever this session actually did, whether that was code, research,
   planning, writing, debugging, or a discussion that reached a conclusion.
   If a repo was touched and the conversation is thin, `git status`,
   `git diff --stat`, and recent `git log` fill in the gaps.
2. **Reduce it to a point.** Summarize purpose and outcome, not a changelog.
   Several unrelated threads means picking the most significant one or two.
   Nothing substantive happened means saying so in one line and stopping.
3. **Write the lesson** in the shape for the selected mode below.

Read `references/japanese-style.md` before writing any Japanese, and
`references/vocabulary-notes.md` before writing sections 3 and 4.

## EASY

Support-heavy. Assume comfortable kana, prior study, and kanji that needs
reactivating.

**1. 日本語でまとめ** — 2-4 short natural sentences. Simple structures,
normal kanji use, ruby furigana on most content words. When in doubt,
annotate.

**2. English** — each English sentence immediately follows its Japanese
sentence as a blockquote. Convey meaning, not word order.

**3. 漢字・単語** — 3-5 words from the summary, full entry format.

**4. 文法のポイント** — at most one pattern, explained in English.

## HARD

Immersion. Assume the learner wants to work for it.

**1. 日本語でまとめ** — 4-7 natural sentences at the level a Japanese
engineer would actually write. Never simplify the Japanese to make
translating it easier.

**2. 理解のポイント** — no full English translation. Instead, gloss 2-3
difficult expressions in plain Japanese:

> ### <ruby>再発<rt>さいはつ</rt></ruby>
> <ruby>一度<rt>いちど</rt></ruby>直した問題が、もう一度起こることです。

**3. 漢字・単語** — 2-4 harder words, explained mainly in Japanese with a
brief English gloss each.

**4. 文法** — only if something genuinely noteworthy appeared. Explain in
Japanese where practical.

## Output shape

- Markdown headings; keep the Japanese passages visually uncluttered.
- Never put Japanese passages in code fences — it kills ruby rendering.
- Inline code for identifiers (`refreshToken`); never ruby inside inline code.
- Target 2-3 minutes of reading (`hard`: 3-4). This is a coffee-break recap,
  not a textbook chapter.

## Done when

The learner has a Japanese passage they can decode, 2-5 words worth keeping,
and at most one grammar point. Nothing in the repository changed.
