import test from 'node:test';
import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import { join } from 'node:path';
import { fileURLToPath } from 'node:url';

// Validates the navbar language selector and RTL rendering in the generated
// site (public/). Assumes the site has been built (`npm run build`); in the
// `test-only` chain, the check:links prebuild takes care of that.

const publicDir = fileURLToPath(new URL('../public', import.meta.url));

function page(relPath) {
  return readFileSync(join(publicDir, relPath, 'index.html'), 'utf8');
}

// Extract the language-menu markup from a page.
function langMenu(html) {
  const m = html.match(
    /<div class="td-lang-menu dropdown">[\s\S]*?<\/ul>\s*<\/div>/,
  );
  assert.ok(m, 'page has a td-lang-menu language selector');
  return m[0];
}

test('language selector marks untranslated languages as disabled', (t) => {
  // /docs/tasks/ exists only in English: the menu should show an active
  // entry (English) and disabled, link-less entries for no and fa.
  const menu = langMenu(page('docs/tasks'));
  const active = menu.match(/class="dropdown-item active"/g) ?? [];
  const disabled = menu.match(/class="dropdown-item disabled"/g) ?? [];
  assert.equal(active.length, 1, 'one active language entry');
  assert.equal(disabled.length, 2, 'two disabled (untranslated) entries');
  assert.ok(
    !/<a[^>]*class="dropdown-item (active|disabled)"/.test(menu),
    'active/disabled entries are not links',
  );
  t.diagnostic(`active: ${active.length}, disabled: ${disabled.length}`);
});

test('language selector links to existing translations', (t) => {
  // /docs/overview/ has a Persian translation: the menu should link to it.
  const menu = langMenu(page('docs/overview'));
  assert.match(
    menu,
    /<a class="dropdown-item" href="\/fa\/docs\/overview\/"/,
    'links to the Persian translation',
  );
  t.diagnostic('fa translation link present on /docs/overview/');
});

test('Persian pages render right-to-left', (t) => {
  const html = page('fa');
  assert.match(html, /<html[^>]*\bdir="rtl"/, 'html element has dir="rtl"');
  assert.match(html, /<html[^>]*\blang="fa"/, 'html element has lang="fa"');
  t.diagnostic('fa home page has dir="rtl" and lang="fa"');
});
