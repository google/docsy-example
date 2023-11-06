# COAsT Documentation Website

This is the repository for the COAsT Python package documentation website. This site utilizes the [Docsy](https://github.com/google/docsy) theme, a Hugo theme designed for technical documentation sites, offering streamlined navigation, structure, and more.

## Prerequisites

Before you get started, make sure you have the following prerequisites in place:

1. **Node.js and npm Installation**: Download and install Node.js, which includes npm, from the official [Node.js website](https://nodejs.org/). We recommend using version 18 or later.

2. **Hugo Installation**: You'll need an extended version of Hugo, preferably version 0.120.1 or later, for local builds and previews of sites that use Docsy. To ensure you have the correct Hugo version, follow these steps:

   - If you install Hugo from the release page, make sure to select the **extended Hugo version** to support SCSS.

   - After installation, verify your Hugo version by running `hugo version`. Your output should resemble the following:

     ```bash
     hugo v0.120.2-9c2b2414d231ec1bdaf3e3a030bf148a45c7aa17+extended linux/amd64 BuildDate=2023-10-31T16:27:18Z VendorInfo=gohugoio
     ```

     Ensure that the version name includes the string *"extended"*.

## Getting Started

Follow these steps to set up your project and get it ready for use. Begin by cloning the repository:

```bash
git clone --recurse-submodules --depth 1 git@github.com:British-Oceanographic-Data-Centre/COAsT-site.git
cd COAsT-site
```

Now, proceed to install the dependencies and essential scripts:

```bash
npm install      # Install package dependencies 
npm run prepare  # Fetch the submodule used as the theme for this website and install its dependencies
```

The `npm run prepare` command will install all the necessary dependencies for your theme, including `PostCSS`, `Bootstrap`, and `Autoprefixer`.

## Running the Website Locally

After cloning the site repository, navigate to the repository's root folder, and execute the following command to serve the website locally:

```bash
hugo server
```

The `hugo server` command builds and serves the site. If you only want to build the site without serving it locally, run `hugo` instead.

<!--### Cloning the Example from the Theme Project


```bash
git clone --recurse-submodules --depth 1 https://github.com/docsy.git
cd tech-doc-hugo-theme/exampleSite
HUGO_THEMESDIR="../.." hugo server
```


Note that the Hugo Theme Site requires the `exampleSite` to live in a subfolder of the theme itself. To avoid recursive duplication, the example site is added as a Git subtree:

```bash
git subtree add --prefix exampleSite https://github.com/google/docsy.git  master --squash
```

To pull in changes, see `pull-deps.sh` script in the theme.-->