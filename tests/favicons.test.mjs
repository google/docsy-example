import test from 'node:test';
import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import { fileURLToPath } from 'node:url';

// Verifies that the Docsy theme's default favicons partial discovers and links
// the icon files this site ships in `static/`. Assumes the site has been built
// (`npm run build`); in the `test-only` chain, the check:links prebuild takes
// care of that.

const home = readFileSync(
  fileURLToPath(new URL('../public/index.html', import.meta.url)),
  'utf8',
);

function head(html) {
  return html.match(/<head[^>]*>([\s\S]*?)<\/head>/i)?.[1] ?? '';
}

test('the home page links the favicons supplied in static/', (t) => {
  const h = head(home);
  assert.match(
    h,
    /<link rel="icon" href="\/favicon\.ico" \/>/,
    'links favicon.ico',
  );
  assert.match(
    h,
    /<link rel="icon" href="\/favicon\.svg" type="image\/svg\+xml" \/>/,
    'links favicon.svg',
  );
  assert.match(
    h,
    /<link rel="apple-touch-icon" href="\/apple-touch-icon\.png" \/>/,
    'links apple-touch-icon.png',
  );
  t.diagnostic('all three discovered favicon links present');
});
