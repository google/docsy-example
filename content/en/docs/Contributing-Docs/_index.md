---
title: "Contributing: Documentation"
linkTitle: "Contributing: Documentation"
weight: 4
date: 2017-01-05
description: >
  Guidelines for contributing to the COAsT documentation site.
---

We use [Hugo](https://gohugo.io/) Extended Version to format and generate our website, the
[Docsy](https://github.com/google/docsy) theme for styling and site structure,
and [GitHub pages](https://help.github.com/en/github/working-with-github-pages) to manage the deployment of the site.
Hugo is an open-source static site generator that provides us with templates,
content organisation in a standard directory structure, and a website generation engine. You write the pages in Markdown (or HTML if you want), and Hugo wraps them up into a website.

All submissions, including submissions by project members, require review. We
use GitHub pull requests for this purpose. Consult
[GitHub Help](https://help.github.com/articles/about-pull-requests/) for more
information on using pull requests.

## Updating a single page

If you've just spotted something you'd like to change while using the docs, Docsy has a shortcut for you:

1. Click **Edit this page** in the top right hand corner of the page.
1. If you don't already have an up to date fork of the project repo, you are prompted to get one - click **Fork this repository and propose changes** or **Update your Fork** to get an up to date version of the project to edit. The appropriate page in your fork is displayed in edit mode.
1. make your edit
1. submit a pull request with a summary of the changes

## Previewing your changes locally

If you want to run your own local Hugo server to preview your changes as you work:

1. Follow the instructions in [Getting started](/docs/contributing_documentation/hugo) to install Hugo and any other tools you need. You'll need at least **Hugo version 0.45** (we recommend using the most recent available version), and it must be the **extended** version, which supports SCSS.
1. Fork the [COAsT-site repo](https://github.com/British-Oceanographic-Data-Centre/COAsT-site.git) repo into your own project, then create a local copy using `git clone`. Don’t forget to use `--recurse-submodules` or you won’t pull down some of the code you need to generate a working site.

    ```
    git clone --recurse-submodules --depth 1 https://github.com/British-Oceanographic-Data-Centre/COAsT-site.git
    ```
1. Run `npm install` to install Node.js dependencies.
2. Run `hugo server` in the site root directory. By default your site will be available at http://localhost:1313/COAsT. Now that you're serving your site locally, Hugo will watch for changes to the content and automatically refresh your site.
2. Continue with the usual GitHub workflow to edit files, commit them, push the
  changes up to your fork, and create a pull request.

## Creating an issue

If you've found a problem in the docs, but you're not sure how to fix it yourself, please create an issue in the [COAsT-site repo](https://github.com/British-Oceanographic-Data-Centre/COAsT-site.git). You can also create an issue about a specific page by clicking the **Create Issue** button in the top right hand corner of the page.

## Useful resources

* [Docsy user guide](https://www.docsy.dev/about/): All about Docsy, including how it manages navigation, look and feel, and multi-language support.
* [Hugo documentation](https://gohugo.io/documentation/): Comprehensive reference for Hugo.
* [Github Hello World!](https://guides.github.com/activities/hello-world/): A basic introduction to GitHub concepts and workflow.
