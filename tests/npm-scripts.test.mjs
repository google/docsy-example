import test from 'node:test';
import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import { fileURLToPath } from 'node:url';

// Guards the repo's npm-script posture (see docsy's supply-chain audit for the
// upstream pattern): every script runs exactly as written where it is invoked,
// with no implicit lifecycle hooks. Implicit hooks are skipped under
// `ignore-scripts` installs and configs, so a hook-shaped step silently
// drops out of chains it appears to be part of.

function scriptsOf(manifestPath) {
  return (
    JSON.parse(
      readFileSync(
        fileURLToPath(new URL(manifestPath, import.meta.url)),
        'utf8',
      ),
    ).scripts ?? {}
  );
}

const manifests = {
  'package.json': scriptsOf('../package.json'),
  'packages/hugoautogen/package.json': scriptsOf(
    '../packages/hugoautogen/package.json',
  ),
};

test('npm scripts declare no implicit pre/post hook siblings', () => {
  const rootNames = Object.keys(manifests['package.json']);
  assert.ok(rootNames.length > 0, 'root manifest declares scripts to guard');
  for (const [manifest, scripts] of Object.entries(manifests)) {
    for (const name of Object.keys(scripts)) {
      for (const hook of [`pre${name}`, `post${name}`]) {
        assert.equal(
          scripts[hook],
          undefined,
          `${manifest}: ${hook} stays absent, so ${name} runs the same with and without ignore-scripts`,
        );
      }
    }
  }
});

test('manifests declare no install-lifecycle hooks', () => {
  for (const [manifest, scripts] of Object.entries(manifests)) {
    for (const hook of ['preinstall', 'install', 'postinstall', 'prepare']) {
      assert.equal(
        scripts[hook],
        undefined,
        `${manifest}: ${hook} stays absent, so installs behave the same with and without --ignore-scripts`,
      );
    }
  }
});
