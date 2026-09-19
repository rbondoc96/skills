# Data processing

Scope: imports, exports, batch transformations, and record-level validation in any language.

## Input and transformation

- Identify the record shape, normalization rules, and output contract before choosing a processing abstraction.
- Separate input decoding, record validation, domain transformation, and output projection when they change for different reasons. Keep a small pipeline small.
- Distinguish missing, malformed, and valid empty values. Preserve units, precision, and time-zone meaning across conversions.
- For large inputs, bound memory and concurrency through streaming, chunking, or paging appropriate to the workload. Preserve record identity and any required ordering across parallel steps.

## Partial failure

- Choose all-or-nothing processing or partial acceptance explicitly. State whether a rejected record stops the batch or allows valid records to continue.
- Make accepted, rejected, and skipped counts reconcile with the input. Return stable rejection reasons tied to safe record identifiers.
- Retain rejected data only through the application's designated access-controlled storage and retention policy. Logs are not a quarantine store.
- Define replay behavior before writing partial results. Read [Persistence](PERSISTENCE.md) when retries, checkpoints, or duplicate imports affect stored state.

## Verification

Use small representative fixtures for malformed records, meaningful empty values, duplicate input, conversion boundaries, and the selected partial-failure policy. Check output records and rejection reports together. Test replay or interruption when the changed behavior promises resumability.
