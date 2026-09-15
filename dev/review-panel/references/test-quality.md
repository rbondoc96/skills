# Test quality

Own meaningful protection and the cost of maintaining tests. Assess both missing coverage and low-value tests. Count and coverage percentage are signals, not objectives.

## Investigate

- For each changed test or coherent test group, identify the behavior protected and a plausible meaningful mistake it would catch. Follow assertions and test setup into the real implementation.
- Check meaningful gaps in changed behavior, especially errors and boundaries. Identify the concrete regression the proposed test would detect.
- Find implementation mirroring: expected results repeat the production algorithm, so the same mistake can appear on both sides.
- Find mock-only protection: the test primarily verifies configured mocks or internal calls without validating a meaningful outcome. An interaction assertion can be valuable when the interaction is itself the contract.
- Find weak assertions, irrelevant snapshots, duplicate scenarios, and brittle assertions on private structure or incidental ordering/text.
- Find tests duplicating type/lint guarantees without exercising a runtime boundary. Distinguish trusted typed callers from untrusted network, storage, or JavaScript input.
- Assess fixture/setup cost, nondeterminism, and dependence on clock, network, or shared mutable state when these make the test unreliable or expensive to change.

## Regression tests

A regression test earns its place by capturing a meaningful failure and detecting its return. The label alone establishes nothing. Checking that a removed function or obsolete text stays absent often encodes an edit rather than protecting behavior; trace any real compatibility or security obligation before judging it.

Small tests, snapshots, mocks, and repeated-looking cases can each protect real contracts. Evaluate their assertions and failure modes, not their form.

## Evidence bar

Recommend `keep`, `improve`, `consolidate`, `remove`, or `add` for investigated tests as useful. Report keeps in coverage rather than manufacturing findings. For a removal/consolidation recommendation, identify any unique protection and where it remains covered, or explain why the asserted behavior is no longer a requirement. Uncertain protection calls for investigation or improvement.

For additions, name the input, expected behavior, and specific plausible failure; "add more tests" is insufficient. Explain the maintenance cost of noisy tests and give a bounded recommendation. Return recommendations without editing or deleting tests.
