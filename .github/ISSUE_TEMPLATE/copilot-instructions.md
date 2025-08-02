# GitHub Copilot Instructions - Docsy Hugo Website

## Project Context
This is a Docsy-based Hugo static site for Maakaf Home. Follow Hugo and Docsy best practices when generating code.

## Hugo Configuration (hugo.yaml)

### Main Configuration Structure
```yaml
baseURL: "https://your-site.com"
title: "Maakaf Home"
languageCode: "en-us"
defaultContentLanguage: "en"

# Hugo Configuration
paginate: 10
enableRobotsTXT: true
enableGitInfo: true
enableEmoji: true

# Theme
theme: ["docsy"]

# Markup Configuration
markup:
  goldmark:
    renderer:
      unsafe: true
  highlight:
    style: "github"
    lineNos: true
    anchorLineNos: false
    codeFences: true
    guessSyntax: false
    hl_Lines: ""
    lineAnchors: ""
    lineNoStart: 1
    lineNumbersInTable: true
    noClasses: true
    noHl: false
    tabWidth: 4

# Language Configuration
languages:
  en:
    title: "Maakaf Home"
    description: "Description in English"
    languageName: "English"
    weight: 1
  he:
    title: "בית מעקף"
    description: "תיאור בעברית"
    languageName: "עברית"
    weight: 2
    contentDir: "content/he"
    params:
      time_format_default: "02.01.2006"

# Menu Configuration
menu:
  main:
    - name: "Documentation"
      url: "/docs/"
      weight: 10
    - name: "Blog"
      url: "/blog/"
      weight: 20
    - name: "Community"
      url: "/community/"
      weight: 30

# Docsy Theme Parameters
params:
  # GitHub Configuration
  github_repo: "https://github.com/user/repo"
  github_branch: "main"
  
  # UI Configuration
  ui:
    sidebar_menu_compact: false
    sidebar_menu_foldable: true
    sidebar_cache_limit: 10
    breadcrumb_disable: false
    taxonomy_breadcrumb_disable: false
    navbar_logo: true
    footer_about_disable: false
    
  # Search Configuration
  algolia_docsearch: false
  offlineSearch: true
  offlineSearchSummaryLength: 70
  offlineSearchMaxResults: 10
  
  # Edit Page
  edit_page: true
  edit_source: "github"
  
  # Version Configuration
  version_menu: "Releases"
  archived_version: false
  version: "main"
  
  # Social Links
  links:
    user:
      - name: "GitHub"
        url: "https://github.com/maakaf-org"
        icon: "fab fa-github"
        desc: "Development takes place here!"
    developer:
      - name: "GitHub"
        url: "https://github.com/maakaf-org"
        icon: "fab fa-github"
        desc: "Development takes place here!"

# Module Configuration (for Hugo Modules)
module:
  imports:
    - path: "github.com/google/docsy"
      disable: false
    - path: "github.com/google/docsy/dependencies"
      disable: false

# Security Configuration
security:
  enableInlineShortcodes: false
  funcs:
    getenv:
      - "^HUGO_"
      - "^WC_"
  http:
    methods:
      - "(?i)GET|POST"
    urls:
      - ".*"

# Build Configuration
build:
  writeStats: true
  
# Development Server
server:
  headers:
    - for: "/**"
      values:
        X-Frame-Options: "DENY"
        X-XSS-Protection: "1; mode=block"
        X-Content-Type-Options: "nosniff"
        Referrer-Policy: "strict-origin-when-cross-origin"
        Content-Security-Policy: "script-src localhost:1313"
```

### Configuration Best Practices
- Use environment-specific configs in `config/_default/`, `config/development/`, `config/production/`
- Set proper `baseURL` for each environment
- Configure multilingual support for Hebrew/English
- Enable Git info for content versioning
- Set up proper security headers
- Configure search (offline or Algolia)
- Set up GitHub integration for edit links

### Environment-Specific Configuration
**config/production/hugo.yaml:**
```yaml
baseURL: "https://maakaf.org"
enableRobotsTXT: true
canonifyURLs: true

params:
  ui:
    feedback:
      enable: true
  links:
    user:
      - name: "Contact"
        url: "mailto:contact@maakaf.org"
        icon: "fa fa-envelope"
```

**config/development/hugo.yaml:**
```yaml
baseURL: "http://localhost:1313"
enableRobotsTXT: false
disableKinds: ["sitemap", "robotsTXT"]

markup:
  goldmark:
    renderer:
      unsafe: true
  highlight:
    noClasses: false
```

## Hugo/Docsy Specific Guidelines

### Content Structure
- Use proper Hugo front matter in YAML format
- Follow Docsy content organization patterns
- Generate content in appropriate sections (`content/en/docs/`, `content/en/blog/`, etc.)
- Use Hugo's page bundles for complex content

### Front Matter Standards
```yaml
---
title: "Page Title"
linkTitle: "Short Title"
weight: 10
description: >
  Brief description of the page content
---
```

### Shortcode Usage
- Prefer Docsy built-in shortcodes over custom HTML
- Use `{{< alert >}}`, `{{< pageinfo >}}`, `{{< tabpane >}}` appropriately
- Generate responsive image shortcodes: `{{< imgproc >}}`
- Use code highlighting: `{{< highlight lang >}}`

### Layout and Templating

**Hugo Template Patterns:**
```go
{{ range .Pages }}
  <article class="card">
    <h2><a href="{{ .RelPermalink }}">{{ .Title }}</a></h2>
    <p>{{ .Summary }}</p>
  </article>
{{ end }}
```

**Partial Templates:**
- Create reusable partials in `layouts/partials/`
- Use semantic HTML5 elements
- Include proper ARIA attributes for accessibility
- Follow Docsy's CSS class conventions

### Content Guidelines
- Write in Markdown with proper heading hierarchy (H1 → H6)
- Use Hugo's built-in image processing
- Implement proper cross-references with `{{< ref >}}` and `{{< relref >}}`
- Include proper meta descriptions and SEO tags

### Styling and Assets
- Use Hugo Pipes for asset processing
- Follow Docsy's SCSS structure in `assets/scss/`
- Implement responsive design patterns
- Use Bootstrap 4/5 classes (Docsy's base framework)

### Multilingual Support
- Structure content with language codes (`content/en/`, `content/he/`)
- Use proper language configuration in front matter
- Implement i18n strings in `i18n/` directory
- Generate language-aware navigation

### Performance and SEO
- Optimize images with Hugo's image processing
- Generate proper structured data (JSON-LD)
- Implement lazy loading for images
- Use Hugo's minification and bundling
- Generate proper sitemap and robots.txt

### Quality Checklist for Hugo/Docsy
Before suggesting code, ensure it:
- [ ] Uses proper Hugo syntax and functions
- [ ] Follows Docsy theme conventions
- [ ] Includes responsive design
- [ ] Has proper front matter
- [ ] Uses semantic HTML
- [ ] Includes accessibility features
- [ ] Optimizes for performance
- [ ] Works with Hugo's build process
- [ ] Follows content structure guidelines
- [ ] Includes proper navigation integration
- [ ] Respects hugo.yaml configuration settings

## Common Hugo Functions to Use
- `{{ .Title }}`, `{{ .Content }}`, `{{ .Summary }}`
- `{{ range .Pages }}`, `{{ with .Params.param }}`
- `{{ partial "name" . }}`, `{{ block "name" . }}`
- `{{ .RelPermalink }}`, `{{ .Permalink }}`
- `{{ dateFormat "2006-01-02" .Date }}`
- `{{ .Site.BaseURL }}`, `{{ .Site.Params.param }}`
- `{{ .Site.Language.Lang }}`, `{{ i18n "key" }}`