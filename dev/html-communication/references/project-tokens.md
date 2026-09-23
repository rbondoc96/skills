# Project tokens

A mock is only useful if it looks like the product it is proposing a change to. Before rendering any variant, extract the invoking project's real design tokens. Do not invent a palette.

## 1. Discover

Run these from the repository root, in order. In Tailwind v4 the CSS file is the config, so check CSS before looking for a JS config. A project mid-migration can have both; `@theme` wins.

```sh
# Tailwind v4: @import "tailwindcss" is the strongest signal the project is on v4
rg -n '@import\s+"tailwindcss"|@theme' --glob '*.css'

# v4 token names, which are what you actually transplant.
# @theme inline is how shadcn remaps its own vars onto Tailwind color names.
rg -n '^\s*--(color|font|spacing|radius|text)-' --glob '*.css' | head -40

# Tailwind v3 fallback, only when no @theme block exists
ls tailwind.config.{ts,js,cjs,mjs} 2>/dev/null

# Any other CSS custom properties, including a plain :root palette
rg -l --glob '*.css' ':root\s*\{' | head

# shadcn setup, which pins the --background/--foreground/--primary/--radius set
cat components.json 2>/dev/null

# Fonts actually in use
rg -n 'next/font|@font-face|font-family' --glob '*.{css,ts,tsx,js,jsx}' | head
```

A defined token is not a used token. Both `theme.extend` and `@theme` describe what is available, not what the product renders, so a config-faithful mock can still look nothing like the app. Open two or three existing components in the area being redesigned and copy their structural idiom: spacing scale, border radius, border vs shadow, how headings and labels are sized. Where the components and the config disagree, follow the components.

## 2. Transplant

Emit the tokens inside a `.mock` wrapper scope, with a comment naming the source. Scope component selectors there too. Build every variant from those tokens; preserve the surrounding artifact's independent styling.

```css
.mock {
  /* from app/globals.css */
  --background: hsl(0 0% 100%);
  --foreground: hsl(240 10% 3.9%);
  --primary: hsl(240 5.9% 10%);
  --border: hsl(240 5.9% 90%);
  --radius: 0.5rem;
}
```

If the project defines both light and dark values, wire them through `light-dark()` so the mock follows the reader's scheme the same way the product does.

## 3. Declare the gaps

Say what you could not reproduce, in a short banner at the top of the mock. Never let a substitution pass silently; the user will read it as a design proposal.

State which of these apply:

- No tokens found, so a neutral fallback palette is in use.
- The real webfont cannot load in the sandbox, so `<name>` is rendering as a system fallback.
- Icons are inline SVG approximations, not the project's icon set.
- Data is representative, not real.
