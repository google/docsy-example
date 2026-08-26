# Docsy Example

[Docsy][] is a [Hugo theme module][] for technical documentation sites,
providing easy site navigation, structure, and more. This **Docsy Example
Project** pulls in the Docsy theme as a Hugo module, together with its
dependencies, and provides a skeleton documentation structure for you to use.
For Docsy documentation, see the [Docsy user guide][].

This project is hosted on [Netlify][] at [example.docsy.dev][].

This is not an officially supported Google product. This project is currently
maintained.

## Using this project as a template

To create your own site from this project, follow [Start with a prepopulated
site][template-guide] in the Docsy user guide, which walks through cloning or
templating this repo and previewing the result.

## Running the website locally

Install the [prerequisites][]: Node.js and npm (minimum versions enforced at
install time), plus Go and Git. Hugo itself comes from the pinned
[hugo-extended][] npm package. On Windows, npm scripts run under Bash (which
ships with [Git for Windows](https://gitforwindows.org/)): make sure `bash` is
on your `PATH`.

From the repo root folder, install the site's dependencies:

```bash
npm run install:safe
```

This performs a clean, script-free install of the pinned dependencies; the Hugo
binary self-installs at first use. For dependency management (lockfile,
generated theme manifest, Hugo updates), see the [maintainer notes][].

Then run:

```bash
npm run serve
```

Run Hugo through the npm scripts, as above: they put the [Dart Sass][] `sass`
CLI from `node_modules` on the `PATH`; a direct `hugo` invocation fails without
it.

## Running a container locally

You can run docsy-example inside a Docker container: follow the [Docker
quickstart][] in the Docsy user guide. Two notes specific to this repo:

- The container builds the site from your working copy: on your host, first
  install the site's npm dependencies as described in
  [Running the website locally](#running-the-website-locally).
- The Docker setup is best-effort: not officially supported, and not exercised
  by CI.

## Troubleshooting

For build and preview problems, see the user guide's [prerequisites][] and
[troubleshooting][] pages.

[Dart Sass]:
  https://www.docsy.dev/docs/get-started/docsy-as-module/installation-prerequisites/#install-dart-sass
[Docker quickstart]: https://www.docsy.dev/docs/get-started/quickstart-docker/
[Docsy user guide]: https://docsy.dev/docs
[hugo-extended]: https://www.npmjs.com/package/hugo-extended
[Docsy]: https://github.com/google/docsy
[maintainer notes]: CONTRIBUTING.md#maintainer-notes
[example.docsy.dev]: https://example.docsy.dev
[Hugo theme module]: https://gohugo.io/hugo-modules/
[Netlify]: https://netlify.com
[prerequisites]:
  https://www.docsy.dev/docs/get-started/docsy-as-module/installation-prerequisites/
[template-guide]:
  https://www.docsy.dev/docs/get-started/docsy-as-module/example-site-as-template/
[troubleshooting]: https://www.docsy.dev/docs/get-started/troubleshooting/

<!-- cSpell:ignore hugo docsy -->
