# PHP

Scope: PHP code. Laravel conventions live in [Laravel](LARAVEL.md) and apply only when the touched code uses that framework.

## Types and values

- Use `declare(strict_types=1)` in new PHP source files. Explicitly parse external scalar values before calling typed application code; strict types are not input validation.
- Declare parameter, property, and return types. Use static-analysis annotations for collection element types, generics, and array shapes that native types cannot express.
- Prefer operation-specific data objects over arrays with undocumented keys. Give optional values a defined meaning rather than using nullability to avoid constructing valid input.
- Use native enums for closed domain choices. Use backed enums when the values have a stable serialized representation; validate external values before conversion.
- Prefer `final readonly` classes for immutable data objects and stateless actions when supported by the project's PHP version and inheritance requirements. Readonly properties do not make referenced mutable objects immutable; choose or copy contained values deliberately.
- Represent money, units, and constrained identifiers with domain values when primitive values invite mistakes. Reuse the project's existing value types; a new vendor package is not required.

## Behavior and failures

- Inject collaborators through constructors or established framework injection points. Introduce an interface when it expresses a real dependency boundary or alternate implementation.
- Keep exceptions meaningful through specific classes and safe structured context. Match the local exception or result convention; TypeScript result libraries and tagged-union conventions are not PHP defaults.
- Catch exceptions where recovery or translation is owned. Preserve the previous exception when useful and safe; avoid converting all failures into an empty result or success-shaped response.
- Use strict comparisons where coercion could change a domain decision. Distinguish absent values from meaningful `false`, `0`, and empty strings.

## Verification and tools

Use the repository's Composer scripts and existing static-analysis, formatting, and test configuration. Preserve configured strictness; add precise local types before suppressing diagnostics. PHPStan, Pint, and PHPUnit guidance applies when those tools are installed, without imposing a version, analysis level, or command name from another project.

Exercise value construction, expected failures, and observable use-case results. Load the matching domain topics for HTTP, database, or queued-work evidence.

Check PHP-version constraints before using newer syntax. See the [PHP class documentation](https://www.php.net/manual/en/language.oop5.basic.php#language.oop5.basic.class.readonly) for readonly-class behavior.
