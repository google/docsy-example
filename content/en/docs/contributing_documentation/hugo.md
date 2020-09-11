---
title: "Using Hugo"
linkTitle: "Using Hugo"
weight: 2
description: >
  What do you need to know to build a local version of this site
---

This page will walk you though a simple setup for hugo extended - which is needed if want to view any changes you make to this site locally.

For more details please [read this](https://gohugo.io/getting-started/installing/).

## Installation
### Manual
1) Download hugo extended from [GitHub](https://github.com/gohugoio/hugo/releases)
2) Unzip into preferred location (I use C:\hugo)
3) Add to OS PATH
    * optional but makes usage easier
### Via a Package Manager
On Windows you can use [Chocolately](https://chocolatey.org/) to install with:
```shell
choco install hugo-extended
```
Or on macOS/Linux you can use [Homebrew](https://brew.sh/) to install with:
```shell
brew install hugo
```
## Try it out!
You should now be able to try the following in a terminal
```shell
$ hugo --help
```

if you have cloned the COAsT-site [repo](github_repo) you should also now be able to;

```shell
$ cd COAsT-site
$ hugo server
```
the above will start a local hugo powered version of the website. you can edit any of the files under /content and see your changes at http://localhost:1313/COAsT/
