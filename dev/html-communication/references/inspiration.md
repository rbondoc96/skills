# Design inspiration

Read when changing the visual language, adding a component, or looking for alternatives to an existing presentation pattern. These sources inform our choices; they are not dependencies or requirements to reproduce another system's style.

## Carbon: structure and explicit state

Browse the [component catalog](https://carbondesignsystem.com/components/overview/), [left navigation](https://carbondesignsystem.com/components/UI-shell-left-panel/usage/), [code snippets](https://carbondesignsystem.com/components/code-snippet/usage/), and [chart selection](https://carbondesignsystem.com/data-visualization/chart-types/).

We borrowed clear labels, compact evidence, and explicit statuses. Revisit Carbon when deciding a component's anatomy, navigation hierarchy, states, or accessibility behavior. Its application shell is a useful reference for navigation, not a reason to turn a report into an application.

For a new pattern, record what the reader needs to find or compare before choosing its appearance. Keep meaning in text as well as color.

## Tufte CSS: context near the claim

Browse [Tufte CSS](https://edwardtufte.github.io/tufte-css/), especially its sections on sidenotes, figures, and code.

We borrowed the reading column, nearby supporting notes, and integration of figures with the text they explain. Revisit it when readers must jump between a claim and its context, or when wide evidence interrupts the reading flow.

Our narrow-screen treatment places notes after their related passage instead of hiding them behind toggles. Essential warnings remain in the main flow. Typography and palette can change independently of these placement choices.

## Red Blob Games: explanation through progression

Browse [Red Blob Games](https://www.redblobgames.com/) and the [introduction to A*](https://www.redblobgames.com/pathfinding/a-star/introduction.html).

We borrowed causal progression: establish the situation, show meaningful changes, then explain the outcome. Revisit these examples when a mechanism is difficult to understand from prose alone, or when interaction could let the reader explore a relationship.

Use interaction to answer a specific question. Simple steps and annotated diagrams often suffice; custom simulations are warranted only when manipulating the example teaches something that a static view cannot.

## Apply an inspiration

1. Name the reader's difficulty and the source pattern that addresses it.
2. Sketch alternatives using the same representative content. Treat composition, typography, and interaction as separate choices where possible.
3. Review wide and narrow layouts, including how navigation and nearby notes compete for space.
4. After a choice, capture the reusable pattern in the component catalog and assets. Keep task-specific evidence out of the library.

Keep the authoritative usage guidance in the component catalog. This file records provenance and where to look next; it does not duplicate component rules.
