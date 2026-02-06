---
title: Upgrade Docsy to 0.14.0
cSpell:ignore: docsy hugo
---

**Note:** v0.14.0 is not yet released. This upgrade uses the latest Docsy from
`main`.

From this prompt:

> Read through Docsy 0.14.0 Upgrade blog post at
> https://main--docsydocs.netlify.app/blog/2026/0.14.0/ (or
> https://raw.githubusercontent.com/google/docsy/refs/heads/main/docsy.dev/content/en/blog/2026/0.14.0.md
> if you prefer the raw source).
>
> Produce a report, based on the Docsy 0.14.0 Upgrade blog that details which
> updates are required in this, the docsy-example, repo; which optional changes
> and cleanup opportunities there are (to reduce technical debt), and which
> enhancements we can apply.

I got the instructions below.

## Upgrade report

Now let me examine the docsy-example repository to understand what files and
configurations it has that might be affected by this upgrade.Based on my
analysis of the Docsy 0.14.0 Upgrade blog post and the current state of the
`google/docsy-example` repository, here is a comprehensive upgrade report:

---

# Docsy 0.14.0 Upgrade Report for `google/docsy-example`

## Executive Summary

The docsy-example repository is currently on **Docsy v0.13.1 (pre-release
build)** and requires upgrading to the **latest Docsy from `main`** (v0.14.0 is
not yet released). The repository already meets the **Hugo 0.155.0** minimum
requirement. The upgrade impact is **relatively low** since the example site
uses standard Docsy project files and doesn't override internal theme files.

---

## 1. Required Updates ⚠️

### 1.1 Update Docsy Module Version

```bash
go get github.com/google/docsy@main
# or: hugo mod get -u github.com/google/docsy@main

hugo mod tidy && hugo mod graph
```

### 1.2 Navbar Theme Behavior Change

**Impact:** The navbar now follows the site's light/dark theme by default
instead of always being dark.

**Files potentially affected:** The homepage and about pages use `blocks/cover`
which interacts with the navbar.

**Action required:** If you want to restore the previous **always-dark navbar**
behavior, add `navbar_theme: dark` under `params.ui` in `hugo.yaml`.

**Current status:** No `navbar_theme` is set. The navbar follows the site
light/dark theme by default. **No change made**—we do not need to enforce dark
mode for the nav.

### 1.3 `blocks/cover` Markdown Processing

**Breaking change:** The shortcode now uses `.Inner` content directly, relying
on Hugo's native Markdown processing.

**Affected files:**

- [`content/fa/about/index.html`](https://github.com/google/docsy-example/blob/834cb7a89aa10d50dfd8bf5df6349cfe002bc1f9/content/fa/about/index.html) -
  Uses `{{< blocks/cover >}}` in an `.html` file

**Action:** If Markdown content inside `blocks/cover` doesn't render correctly
in HTML files, change from:

```html
{{< blocks/cover title="..." >}}
```

to the Markdown call syntax:

```html
{{% blocks/cover title="..." %}}
```

**Note:** The English about page
([`content/en/about/index.md`](https://github.com/google/docsy-example/blob/834cb7a89aa10d50dfd8bf5df6349cfe002bc1f9/content/en/about/index.md))
already correctly uses `{{% blocks/cover %}}`.

---

## 2. Optional Changes & Cleanup Opportunities 🧹

These reduce technical debt and adopt improved patterns:

### 2.1 Switch to Markdown Alert Syntax

**Current state:** The repo uses **both** Markdown alerts and the `alert`
shortcode in
[`content/en/docs/getting-started/example-page.md`](https://github.com/google/docsy-example/blob/834cb7a89aa10d50dfd8bf5df6349cfe002bc1f9/content/en/docs/getting-started/example-page.md#L210-L288):

```markdown
<!-- Current: Markdown alerts (already using new syntax!) -->

> [!NB] This is an alert.

> [!TIP]
>
> This is a successful alert.

<!-- Current: Alert shortcodes (consider migrating) -->

{{% alert %}} This is an alert. {{% /alert %}}
{{% alert title="Alert title" color="secondary" %}} ... {{% /alert %}}
```

**Recommendation:** Since this is an example site, **keep both syntaxes** to
demonstrate both options to users. Add a comment explaining the Markdown syntax
is recommended for new content.

### 2.2 Navbar Height Customization

**New in 0.14.0:** You can now adjust navbar height via the
`$td-navbar-min-height` SCSS variable.

**File:**
[`assets/scss/_variables_project.scss`](https://github.com/google/docsy-example/blob/cac635841b0955e46a3d82c814b308c17a6dc87c/assets/scss/_variables_project.scss)

**Current state:** The file is essentially empty (just comments).

**Opportunity:** If navbar height customization is desired, add:

```scss
$td-navbar-min-height: 4rem; // Adjust as needed
```

### 2.3 New `td-below-navbar` Helper Class

**Enhancement:** You can now position `blocks/cover` below the navbar instead of
behind it.

**Opportunity:** For pages like the About page, you could use:

```markdown
{{% blocks/cover title="About Goldydocs" height="auto td-below-navbar" %}}
```

This positions the cover content below the fixed navbar on desktop.

### 2.4 Internal SCSS File Reorganization

**Good news:** The docsy-example repo does **not** override any internal SCSS
files. The only SCSS files present are:

- `assets/scss/_styles_project.scss` - Uses supported imports
- `assets/scss/_variables_project.scss` - Minimal/empty

The `_styles_project.scss` imports are from `td/` prefix which is the
**correct** pattern:

```scss
@import 'td/color-adjustments-dark';
@import 'td/code-dark';
@import 'td/gcs-search-dark';
```

**No action required** - the repo already follows best practices.

---

## 3. Enhancements to Consider ✨

### 3.1 Experimental Netlify Build Info Shortcode

**New in 0.14.0:** The `td/site-build-info/netlify` shortcode displays Netlify
build information.

**Opportunity:** Since docsy-example uses Netlify (see
[`netlify.toml`](https://github.com/google/docsy-example/blob/cac635841b0955e46a3d82c814b308c17a6dc87c/netlify.toml)),
consider adding this to a footer or about page:

```markdown
{{< td/site-build-info/netlify >}}
```

### 3.2 Experimental Extra Styles

**New in 0.14.0:**

- Navbar link decoration for active/hover states
- Nested-list margin fix

These are experimental and can be enabled per Docsy documentation.

### 3.3 New CSS Variables for Navbar Customization

**New experimental CSS variables:**

- `--td-navbar-bg-color`
- `--td-navbar-backdrop-filter`
- `--td-navbar-border-bottom`
- `--bs-bg-opacity`
- `--bs-link-underline-opacity`

**Opportunity:** Document these in the example site to help users understand
customization options.

---

## 4. Items NOT Applicable to docsy-example ✅

The following breaking changes do **NOT** affect this repo:

| Breaking Change                                                                         | Status                |
| --------------------------------------------------------------------------------------- | --------------------- |
| `td-offset-anchor` class usage                                                          | ❌ Not found in repo  |
| `navbar-bg-on-scroll` / `navbar-bg-onscroll--fade` classes                              | ❌ Not found in repo  |
| Swagger UI style customizations (`_swagger.scss`)                                       | ❌ Not present        |
| Override of `blocks/lead.html`, `blocks/section.html`, or `layouts/community/list.html` | ❌ No overrides found |
| Override of `navbar.html` partial                                                       | ❌ Not overridden     |
| Project-level i18n files                                                                | ❌ Not present        |

---

## 5. Post-Upgrade Sanity Checks ✓

After upgrading, verify:

- [ ] **Build output**: Site builds without errors, warnings, or deprecation
      notices
- [ ] **Navbar appearance**: Theme matches expectations (light in light mode,
      dark in dark mode)
- [ ] **Cover pages**: Homepage and About page render correctly with navbar
      overlay
- [ ] **Fragment links**: In-page anchor links scroll to correct position below
      navbar
- [ ] **Alert rendering**: Both Markdown alerts and `alert` shortcodes display
      properly
- [ ] **`<details>` elements**: Spacing is correct in content pages
- [ ] **TOC sidebar**: h1 entries are visually distinct

---

## 6. Summary of Actions

| Priority     | Action                                                   | File(s)                           |
| ------------ | -------------------------------------------------------- | --------------------------------- |
| 🔴 Required  | Update Docsy module to latest from `main`                | `go.mod`, `go.sum`                |
| ⚪ No action | Navbar follows site theme; dark mode not enforced        | —                                 |
| 🟡 Review    | Test `blocks/cover` in HTML files for Markdown rendering | `content/fa/about/index.html`     |
| 🟢 Optional  | Consider `td-below-navbar` for cover positioning         | Content files with `blocks/cover` |
| 🟢 Optional  | Add Netlify build info shortcode                         | Any appropriate page              |
| ⚪ No action | SCSS files already follow correct patterns               | `assets/scss/`                    |

---

## References

- [Docsy 0.14.0 Release Blog Post](https://main--docsydocs.netlify.app/blog/2026/0.14.0/)
- [Hugo 0.152.0-0.155.x Upgrade Guide](https://main--docsydocs.netlify.app/blog/2026/hugo-0.152.0+/)
- [Docsy 0.14.0 Changelog](https://www.docsy.dev/project/about/changelog/#v0.14.0)
