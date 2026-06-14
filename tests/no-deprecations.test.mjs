import test from 'node:test';
import assert from 'node:assert/strict';
import { spawnSync } from 'node:child_process';
import { mkdirSync, mkdtempSync, readFileSync, rmSync } from 'node:fs';
import { join } from 'node:path';
import { fileURLToPath } from 'node:url';

const siteDir = fileURLToPath(new URL('../', import.meta.url));
const tmpDir = join(siteDir, 'tmp');

// Build to a throwaway dir under `tmp/` so this concurrent test never clobbers
// the `public/` that other tests read.
function buildSite() {
  mkdirSync(tmpDir, { recursive: true });
  const destDir = mkdtempSync(join(tmpDir, 'no-deprecations-'));
  try {
    const res = spawnSync('npm run build -- -d ' + destDir, {
      cwd: siteDir,
      shell: true,
      encoding: 'utf8',
    });
    const output = `${res.stdout ?? ''}${res.stderr ?? ''}`;
    const deprecations = output
      .split('\n')
      .filter((line) => /deprecated/i.test(line));
    return { res, output, deprecations };
  } finally {
    rmSync(destDir, { recursive: true, force: true });
  }
}

test('site build logs no Hugo deprecation notices', (t) => {
  const { res, output, deprecations } = buildSite();
  assert.equal(res.status, 0, `Build failed:\n${output}`);
  assert.deepEqual(deprecations, [], 'Hugo build logged deprecation notice(s)');
  t.diagnostic(`Scanned ${output.split('\n').length} build-log lines`);
});

// The check above only catches deprecations if the build runs at `info` (or
// more verbose), where Hugo surfaces them. Assert that statically rather than
// seeding a deprecated call into tracked source.
test('the site build runs at a log level that surfaces deprecations', () => {
  const pkg = JSON.parse(
    readFileSync(new URL('../package.json', import.meta.url), 'utf8'),
  );
  const hugoScript = pkg.scripts?.['_hugo-dev'] ?? '';
  const match = hugoScript.match(/--logLevel\s+(\w+)/);
  assert.ok(match, `_hugo-dev script has no --logLevel flag: ${hugoScript}`);
  assert.ok(
    ['info', 'debug'].includes(match[1]),
    `_hugo-dev --logLevel ${match[1]} is too quiet to surface Hugo ` +
      'deprecation notices; use info (or more verbose)',
  );
});
