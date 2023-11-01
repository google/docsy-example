# COAsT docsy

This is the website repo for the COAsT python package it uses [Docsy](https://github.com/google/docsy) a Hugo theme for technical documentation sites, providing easy site navigation, structure, and more.


## Pre requitises

1. Install Node.js and npm

You can download and install Node.js, which includes npm, from the official Node.js website. We recommend any version 18 or greater.

2. Install Hugo

You need a recent extended version (we recommend version 0.120.1 or later) of Hugo to do local builds and previews of sites (like this one) that use Docsy. If you install from the release page, make sure to get the **extended Hugo version**, which supports SCSS; you may need to scroll down the list of releases to see it.

After the installation, you can run the command `hugo version`, You should see something like this:

```
hugo v0.120.2-9c2b2414d231ec1bdaf3e3a030bf148a45c7aa17+extended linux/amd64 BuildDate=2023-10-31T16:27:18Z VendorInfo=gohugoio
```
Please note that the string *"extended"* have to be in your version name.

## Usage

The following will give you a project that is set up and ready to use. The first thing you have to do is clone the repository:


```bash
git clone --recurse-submodules --depth 1  git@github.com:British-Oceanographic-Data-Centre/COAsT-site.git
cd COAsT-site
```

Now you need to install the dependencies and some of the scripts:

```bash
npm install # install the package dependences
npm run prepare # it sill get the submodule that is used as a theme for this website and then install the dependencies of this submodule
```
When you run `npm run prepare` it will install for you all the dependencies of your theme, including `PostCSS`, `Bootstrap` and `Autoprefixer`


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

## Running the website locally

Once you've cloned the site repo, from the repo root folder, run:

```
hugo server
```
The `hugo server` command builds and serves the site. If you just want to build the site, run `hugo` instead.
