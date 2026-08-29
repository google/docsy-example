import test from 'node:test';
import assert from 'node:assert/strict';
import { globSync, readFileSync } from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

// Guards the repo's npm-script posture (see docsy's supply-chain audit for the
// upstream pattern): every script runs exactly as written where it is invoked,
// with no lifecycle hooks. Hooks are skipped under `ignore-scripts` installs
// and configs, so a hook-shaped step silently drops out of chains it appears
// to be part of. The `pre`/`post` prefix ban is a shape rule: it also rejects
// orphan hooks (live again the day their parent name reappears) and names that
// would become hooks of a later script (a `preview` script hooks `view`).
// `install`, `dependencies`, and `publish` are the lifecycle names outside the
// shape. Manifests are discovered from the root `workspaces` config, so future
// workspaces stay guarded.

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

test('npm scripts declare no lifecycle or hook-shaped names', () => {
  for (const [manifest, { scripts = {} }] of manifests) {
    for (const name of Object.keys(scripts)) {
      assert.ok(
        !/^(pre|post)/.test(name) &&
          !['install', 'dependencies', 'publish'].includes(name),
        `${manifest}: ${name} stays outside npm's lifecycle namespace, so every script runs the same with and without ignore-scripts`,
      );
    }
  }
});
