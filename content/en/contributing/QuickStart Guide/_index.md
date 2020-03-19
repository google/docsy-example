---
title: "Quick Start Guide"
linkTitle: "Quick Start Guide"
date: 2020-03-18
weight: 10
description: >
 This guide is designed as a quick reference guide for those who are already familiar with the various tools which are in play here around Hugo, Brew, Git, VS Code.
---

## Become a Contributor

In order to publish content to [https://vmc-onboarding.com](https://vmc-onboarding.com) you will need to be added as a contributor to this repository [https://github.com/bohleadam/vmc-onboarding](https://github.com/bohleadam/vmc-onboarding) as this is the repository which is used to build the website. Please reach out to the owner of this repository to be approved and added as a contributor.

## Install Hugo

### MacOS Hugo Instructions

```bash
brew install hugo
```

### Windows Hugo Instructions

If you are on a Windows machine and use [Chocolatey](https://chocolatey.org/) for package management, you can install Hugo with the following one-liner:

```bash
choco install hugo -confirm
```

## Install Git

If you do not have git installed locally on your computer, please follow these simple instructions to install the git command line tools

### MacOS Git Instructions

```bash
brew install git
```

### Windows Git Instructions

On Windows you can download [Git](https://gitforwindows.org/) and follow the instructions to get up and running.

## Install Visual Studio Code

VS code is very straight forward to install, simply navigate to [Visual Studio Code](https://code.visualstudio.com/) and you can download the binaries from the landing page, VS code is available for Mac, Windows and Linux OSs.

### Install Visual Studio Code Extensions

[Markdown All in One](https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one)

[Dictionary Completion](https://marketplace.visualstudio.com/items?itemName=yzhang.dictionary-completion)

[Code Spell Checker](https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker)

## Cloning the repository and getting starting ready to contribute

``` bash
git clone --recurse-submodules --depth 1 https://github.com/bohleadam/vmc-onboarding.git
```

Change into the cloned repository directory

``` bash
cd vmc-onboarding
```

Run the following command to preview the site locally

``` bash
hugo server
```

Navigate to [http://localhost:1313](http://localhost:1313) to preview the site.

## Commit changes and updates to the Repository

```bash
git commit -a -m "My change message"
```

## Push changes and updates to the Repository

```bash
git push origin master
```
## If you enabled 2 factor Auth in your Github account you will need to create an access token

See here: https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line