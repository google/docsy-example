---
title: "Contributing: Documentation"
linkTitle: "Contributing: Documentation"
date: 2021-10-05
weight: 2
description: >
  Guidelines for contributing to the COAsT documentation site.
---

If you're not a developer, your contributions to the documentation are still of huge value, even if you're not an expert in COAsT. In fact, some sections of our docs may benefit from your fresh perspective. If you come across something that doesn't make sense to you, updating that section once you figure it out can greatly assist the next person.

All submissions, including those from project members, require review. We use GitHub pull requests for this purpose. For more information on using pull requests, consult [GitHub Help](https://help.github.com/articles/about-pull-requests/).

## About COAsT Documentation

We rely on the following technologies to create our Documentation:

- [Hugo](https://gohugo.io/) Extended Version for formatting and generating our Documentation website.
- The [Docsy](https://github.com/google/docsy) theme for styling and site structure.
- [GitHub Pages](https://help.github.com/en/github/working-with-github-pages) for site deployment.

Hugo, an open-source static site generator, provides templates, a standardized content organization, and website generation. You write pages in Markdown (or HTML if you prefer), and Hugo transforms them into a website.

Here are some key points about our documentation:

- COAsT documentation consists of three parts: tutorial notebooks within the code itself, docstrings within the code, and the [documentation repository](https://github.com/British-Oceanographic-Data-Centre/COAsT-site).

- The tutorial notebooks provide guidance on using the code for analysis, docstrings explain individual function usage, and the documentation offers topic-based overviews along with other information (overviews, installation, usage, etc).

- Our docstrings adhere to the **Numpy Docstring Standard**, widely used in the Scientific Python community. This standard specifies the docstring's different sections. Refer to [this document](https://numpydoc.readthedocs.io/en/latest/format.html#docstring-standard) for a detailed explanation or use existing functions as examples.

## Updating a Single Page

If you come across something you'd like to change while using the docs, Docsy provides a convenient way to do so:

1. Click **Edit this page** in the top right-hand corner of the page.

2. If you don't already have an up-to-date fork of the project repo, you'll be prompted to get one. Click **Fork this repository and propose changes** or **Update your Fork** to obtain an up-to-date version of the project to edit. The relevant page in your fork will be displayed in edit mode.

3. Make your edits.

4. Submit a pull request with a summary of the changes.

## Previewing Your Changes Locally

To preview your changes locally, run your own Hugo server. Ensure you have the following prerequisites:

1. **Node.js and npm Installation**: Download and install Node.js, including npm, from the official [Node.js website](https://nodejs.org/). We recommend using version 18 or later.

2. **Hugo Installation**: You'll need an extended version of Hugo, preferably version 0.120.1 or later, for local builds and previews of sites using Docsy. To ensure you have the correct Hugo version, follow these steps:

   - If you install Hugo from the release page, select the **extended Hugo version** to support SCSS.

   - After installation, verify your Hugo version with `hugo version`. It should resemble the following:

     ```bash
     hugo v0.120.2-9c2b2414d231ec1bdaf3e3a030bf148a45c7aa17+extended linux/amd64 BuildDate=2023-10-31T16:27:18Z VendorInfo=gohugoio
     ```

   - Ensure the version name includes "extended."

   - For more details, see [this installation guide](https://gohugo.io/getting-started/installing/).

Next, fork the [COAsT-site repo](https://github.com/British-Oceanographic-Data-Centre/COAsT-site.git) into your project and create a local copy using `git clone`:

```bash
git clone --recurse-submodules --depth 1 git@github.com:British-Oceanographic-Data-Centre/COAsT-site.git
cd COAsT-site
```

Now, install the necessary dependencies and scripts:

```bash
npm install      # Install package dependencies 
npm run prepare  # Fetch the submodule used as the theme and install its dependencies
```

After cloning the site repository, navigate to the root folder and execute the following command to serve the website locally:

```bash
hugo server
```

The `hugo server` command builds and serves the site at http://localhost:1313/COAsT by default. While serving your site locally, Hugo will monitor content changes and refresh your site automatically.

Follow the standard GitHub workflow to edit files, commit changes, push them to your fork, and create a pull request.

## Creating an Issue

If you've identified a problem in the documentation but aren't sure how to fix it yourself, please create an issue in the [COAsT-site repo](https://github.com/British-Oceanographic-Data-Centre/COAsT-site.git). You can also create an issue about a specific page by clicking the **Create Issue** button in the top right-hand corner of the page.

## Useful Resources

- [Docsy User Guide](https://www.docsy.dev/about/): All about Docsy, including navigation, design, and multi-language support.
- [Hugo Documentation](https://gohugo.io/documentation/): A comprehensive reference for Hugo.
- [GitHub Hello World!](https://guides.github.com/activities/hello-world/): A basic introduction to GitHub concepts and workflow.