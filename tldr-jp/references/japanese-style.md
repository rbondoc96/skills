# Japanese style and furigana

Read before writing any Japanese.

## Voice

Natural modern Japanese, as a Japanese software engineer would casually
explain the work to a colleague. Prefer real Japanese terminology over
literal translations of English phrasing. Never use romaji.

Software vocabulary is welcome where it is what a native would actually
reach for: 実装、修正、変更、処理、追加、削除、更新、原因、対応、確認、
設定、認証、検証、依存関係、例外、引数、戻り値、再現、再発.

Keep proper nouns and identifiers in their normal form — function, variable,
and class names, APIs, libraries, frameworks, packages, files, commands,
protocols, products. Do not force a Japanese rendering.

## Ruby furigana

Output normally renders in a client that displays HTML inside assistant
Markdown, so use ruby annotations rather than parenthesized readings:

<ruby>変更<rt>へんこう</rt></ruby>

Fall back to `変更(へんこう)` only if ruby genuinely cannot render.

**Annotate the whole useful word,** not each character:

- Good: <ruby>依存関係<rt>いぞんかんけい</rt></ruby>
- Good: <ruby>認証処理<rt>にんしょうしょり</rt></ruby>
- Avoid: <ruby>認<rt>にん</rt></ruby><ruby>証<rt>しょう</rt></ruby><ruby>処<rt>しょ</rt></ruby><ruby>理<rt>り</rt></ruby>

Split a compound only when the split is the lesson.

## Density

First occurrence of a word only; repeats stay bare. Never annotate
kana-only words. Never place romaji beneath Japanese.

Beyond that, density is the difference between the modes:

- `easy` — most content words. Skip only very basic kanji, unless the
  reading is irregular. Uncertain means annotate.
- `hard` — uncommon readings, difficult compounds, and specialist
  vocabulary an intermediate learner plausibly would not know.
