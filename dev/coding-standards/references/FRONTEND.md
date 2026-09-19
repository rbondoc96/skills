# Frontend

Scope: user interfaces, server-rendered templates, forms, and client state in any language. TypeScript component conventions live in [TypeScript components](FRONTEND_COMPONENTS.md); load that file only for TypeScript work.

## Interaction and state

- Keep derived values computed from their source. Give local interaction state, shared client state, and server-owned data distinct owners.
- Define loading, empty, error, and ready behavior where data affects rendering. Preserve user input when a recoverable submission fails.
- Validate form and external data at the receiving boundary. Client validation improves feedback; protected writes still require server validation and authorization.
- Use the framework's escaping/rendering mechanisms for untrusted content. Intentional raw markup requires an appropriate sanitization boundary.
- Keep secrets and raw credentials out of rendered markup, attributes, client bundles, and serialized page data.

## Accessibility

- Prefer semantic elements before custom roles. Controls must be keyboard-operable and have visible focus.
- Associate labels with inputs and accessible names with icon-only controls. Connect validation feedback to the affected fields.
- Convey meaning through more than color. Respect reduced-motion preferences where animation is used.

## Verification

Exercise the changed interaction through the rendered interface. Check the relevant data states, keyboard behavior, submission failures, and public output. Select libraries and styling conventions through the applicable framework guidance and local configuration.
