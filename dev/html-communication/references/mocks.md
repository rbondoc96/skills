# Mock variants

The goal is a decision, not a gallery. A variant set the user cannot choose between has failed, however good it looks.

## Fix the frame

Hold everything constant except the thing being decided. Across every variant, keep the same viewport, the same content, the same data, the same tokens, and the same surrounding page furniture.

Name the axis that varies before building. If two variants differ on five things at once, the user cannot attribute what they like, and the pick carries no information.

## Per variant

- Label variants as `A`, `B`, `C`, and so forth. Labels are how the user replies.
- Give it one thesis line: the single change it makes and what it buys. "B: filters move to a left rail, trading horizontal room for always-visible state."
- Render it fully styled. Never describe a variant in prose instead of drawing it.
- Add at most two lines of tradeoff underneath. Not a pitch.

## Content

Use realistic data: real-shaped names, plausible lengths, actual copy from the product where it exists. Lorem ipsum and `Item 1` hide exactly the problems a mock exists to surface.

Include the states the decision hinges on. A layout choice that only works when the list is full is not a layout choice, so render the empty state, the longest realistic string, and the error or loading state wherever the variants diverge on them.

## Layout

Stack variants vertically, full width, each under a clear `A` / `B` / `C`/ etc. heading, with an anchor list at the top of the file. Stacking preserves the real viewport width; side-by-side columns shrink each mock into a layout the user is not actually evaluating.

Add a short comparison table at the end only when there are three or more variants and the axes are genuinely discrete. Keep it under five rows.

## Stop

Publish, report the URL, and stop. Do not begin implementing, and do not edit real components, until the user picks.

After a pick, keep iterating in the same file at the same URL so the Postplan version history stays comparable.
