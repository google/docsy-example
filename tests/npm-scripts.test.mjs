import test from 'node:test';
import assert from 'node:assert/strict';
import { globSync, readFileSync } from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

// Guards the repo's npm-script posture (see docsy's supply-chain audit for the
// upstream pattern): every script runs exactly as written where it is invoked,
// with no lifecycle hooks. Implicit hooks are skipped under `ignore-scripts`
// installs and configs, so a hook-shaped step silently drops out of chains it
// appears to be part of. Manifests are discovered from the root `workspaces`
// config, so future workspaces stay guarded.

// npm runs these on its own initiative during install, pack, and publish
// operations, regardless of what other scripts are declared.
const LIFECYCLE_NAMES = [
  'preinstall',
  'install',
  'postinstall',
  'preprepare',
  'prepare',
  'postprepare',
  'prepublish',
  'prepublishOnly',
  'prepack',
  'postpack',
  'dependencies',
];

const repoRoot = fileURLToPath(new URL('..', import.meta.url));
const readManifest = (relPath) =>
  JSON.parse(readFileSync(path.join(repoRoot, relPath), 'utf8'));

const rootManifest = readManifest('package.json');
const manifests = new Map([['package.json', rootManifest]]);
for (const pattern of rootManifest.workspaces ?? []) {
  for (const dir of globSync(pattern, { cwd: repoRoot })) {
    const rel = path.join(dir, 'package.json');
    manifests.set(rel, readManifest(rel));
  }
}

test('workspace discovery finds manifests to guard', () => {
  assert.ok(
    manifests.size >= 2,
    'the root and at least one workspace manifest are discovered',
  );
});

test('npm scripts declare no pre/post hook siblings', () => {
  for (const [manifest, { scripts = {} }] of manifests) {
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

test('manifests declare no npm lifecycle scripts', () => {
  for (const [manifest, { scripts = {} }] of manifests) {
    for (const hook of LIFECYCLE_NAMES) {
      assert.equal(
        scripts[hook],
        undefined,
        `${manifest}: ${hook} stays absent, so npm operations run no undeclared code`,
      );
    }
  }
});
