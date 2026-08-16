# Issue Writing Examples

Use these comparisons to calibrate the issue. The good examples explain the outcome and boundaries without turning the issue into an implementation plan.

## Title

BAD

> ❌ Update WebSocket reconnect logic

This names an implementation area but not the problem or desired outcome.

GOOD

> ✅ Restore live updates after a connection drop

This names the user-visible outcome in plain language.

## Summary

BAD

> ❌ Refactor `SocketManager` to add exponential backoff, move retry state into Zustand, and replace the existing interval with chained timeouts.

This prescribes a solution before explaining why the work exists.

GOOD

> ✅ Live updates stop after a brief network interruption, forcing people to reload the page. Restore the connection automatically so they can continue working without losing context.

This explains the problem, desired outcome, affected user, and value without fixing the design in place.

## Acceptance criteria

BAD

> ❌
> - Add a reconnect hook.
> - Update `SocketManager`.
> - Write tests.

These are implementation tasks. They do not define which behavior proves the issue is done.

GOOD

> ✅
> - Live updates resume automatically after a temporary connection loss.
> - Changes made while reconnecting appear after the connection is restored.
> - A persistent failure is shown clearly and offers a retry action.

These bullets are observable and allow different valid implementations.

## Scope

BAD

> ❌ Improve reconnect behavior across the app and clean up related networking code.

The boundary is unclear and invites unrelated work.

GOOD

> ✅
> ## Affected Areas
>
> - Live document updates in the editor
>
> ## Out of Scope
>
> - Offline editing
> - Background synchronization for other product areas

This identifies the intended blast radius and excludes tempting adjacent work.

## Bug report

BAD

> ❌ Sometimes saving fails. Fix the API issue.

This lacks a reliable reproduction, environment, expected behavior, and evidence for the claimed cause.

GOOD

> ✅ Saving an edited profile returns an error when the display name contains an apostrophe. The profile should save with valid punctuation so people can use their real names.
>
> ## Steps to Reproduce
>
> 1. Open profile settings.
> 2. Set the display name to `O'Connor`.
> 3. Save the profile.
>
> ## Environment
>
> - Production web app
> - Reproduces on every attempt

This records the shortest reproduction and only the environment details relevant to the failure.

## Design and implementation detail

BAD

> ❌ Includes component diagrams, schema proposals, migration commands, rollout steps, and a file-by-file implementation checklist in the issue body.

This makes the issue harder to scan and couples its outcome to an early design.

GOOD

> ✅ Summarize the relevant constraint in the issue and link a Linear document containing the design, tradeoffs, and implementation plan.

This keeps the issue lean while preserving deeper material where it can evolve independently.
