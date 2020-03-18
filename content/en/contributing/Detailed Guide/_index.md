---
title: "Detailed Setup instructions"
linkTitle: "Detailed Setup instructions"
date: 2020-03-18
weight: 20
description: >
 In this article we will go through the detailed instructions to setup your local copy of this repository in order for you to become a contributor, this article is designed for those who are not familiar with Hugo or Git. If you are familiar with these tools and you just want the quick start setup guide please follow this link [Quick Start Guide](../quickstart-guide/)
---

## Become a Contributor

In order to publish content to [https://vmc-onboarding.com](https://vmc-onboarding.com) you will need to be added as a contributor to this repository [https://github.com/bohleadam/vmc-onboarding](https://github.com/bohleadam/vmc-onboarding) as this is the repository which is used to build the website. Please reach out to the owner of this repository to be approved and added as a contributor.

## Install Hugo

This site is built using [Hugo](https://gohugo.io/). Hugo is a static site generator. if you wish to build the site locally for the purposes of testing then you will need to install Hugo locally in order to preview the site before you commit changes back to this repository. Please follow the below steps to do this.

### MacOS Hugo Instructions

If you are on macOS and using [Homebrew](https://brew.sh/), you can install Hugo with the following one-liner:

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

On Windows you can download [Git](https://gitforwindows.org/) and follow the instructions to get up and running

## Install Visual Studio Code

There are multiple options for editing the markdown and making site changes, the best option, IMHO, is to use [Visual Studio Code](https://code.visualstudio.com/) This comprehensive Developer text editor has everything you need to be able to contribute to the [https://vmc-onboarding.com](https://vmc-onboarding.com) site as well as a number of extensions which will help with contributing. We will explore some of these extensions once we have installed VS Code.

### Install Visual Studio Code (Mac and Windows)

VS code is very straight forward to install, simply navigate to [Visual Studio Code](https://code.visualstudio.com/) and you can download the binaries from the landing page, VS code is available for Mac, Windows and Linux OSs.

### Install Visual Studio Code Extensions

VS Code has a number of extensions for working with various different development languages, cloud platforms, automation tools and so on. Here are a few which you may find useful for contributing to this site

[Markdown All in One](https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one)

[Dictionary Completion](https://marketplace.visualstudio.com/items?itemName=yzhang.dictionary-completion)

[Code Spell Checker](https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker)

There are lots of extensions which can be installed for VS Code, these are just a few which you may find useful for Markdown editing

### Useful Links

Since we are mainly going to be editing markdown as part of contributing content to this site, it is useful to have access to a  Markdown cheat-sheet, especially if you are not editing markdown on a regular basis. Markdown has various syntax requirements which need to be adhered to, the below sites are useful for referencing purposes

[Markdown Guide](https://www.markdownguide.org/)

[Daring Fireball](https://daringfireball.net/projects/markdown/syntax)

## Cloning the repository and getting starting ready to contribute

In order to get started with contributing content to this site, we will first need to clone the repository to our local machine in order to start working on it.

I will be describing this instructions for MacOS

1. It's best to create a folder structure and organize your git repositories on your machine, for the purposes of these instructions I will create a folder in my "Documents" folder on my Mac called "Hugo" in here I keep all my Hugo sites which I am working on.

2. Open VS Code and goto **View** > **Terminal** to open the VS code integrated terminal.

3. Navigate to your parent directory where you plan to clone this repository to, in my case that is the Hugo Directory in the Documents folder

4. Clone the repository with the below command

    ``` bash
    git clone --recurse-submodules --depth 1 https://github.com/bohleadam/vmc-onboarding.git
    ```

5. Now change into the cloned repository directory

    ``` bash
    cd vmc-onboarding
    ```

6. You now have a local copy of everything you need to start editing the site and content in order to contribute to the site

7. Next we can test our local development environment and make sure that we can build the site locally on your laptop and make changes and add content

8. Run the below command from your VS Code integrated terminal, assuming you are still in the vmc-onboarding directory. This will use Hugo to interpret the files we have in this directory and build the website locally on your machine. If this goes well, which it should, you will see that the web server is available at [http://localhost:1313](http://localhost:1313) open a web browser and navigate to this location and you will be able to browse the whole site locally

    ``` bash
    hugo server
    ```

9. Should you want to stop serving the site locally you can use (ctrl+c) to stop Hugo from serving the site

10. In VS Code you can view the directory tree, you can do this by using the shortcut key combination "Command+Shift+E" and then clicking **Open Folder** and navigating to the vmc-onboarding folder, which in my case sites in **Documents/Hugo/**, select the folder and click **open**.

## How to edit content and contribute

Now that we have the site locally on our machine we can get started with contributing. Now you may be looking at the directory structure and it may appear a little bit daunting, especially if you are new to Hugo and new to website development. Fear not, we only need to focus on one top level root folder.

/Content

This is the folder which will contain the markdown files which we will edit in order to build the site content

Within the Content directory you will find folders related to language, for the purposes of this tutorial we will focus on the "en" directory for English content.

Here you will find various subfolders for content. The Hugo site we are using is built using a Hugo Theme, the theme we are using is called [Docsy](https://themes.gohugo.io/docsy/) this theme is a really good theme for technical documentation which makes it ideal for our purposes. The Docsy theme also has very good documentation, hosted on a docsy themed site, which you can reference below

[Docsy Documentation](https://www.docsy.dev/docs/)

As a content contributor you will find the below section of the Docsy documentation very useful.

[Docsy Documentation - Adding Content](https://www.docsy.dev/docs/adding-content/content/)

Please review the above documentation links, view the structure of the /content/en/ directory and open a documentation issue for this page if you feel more clarification is needed.

## Commit changes and updates to the Repository

As you are making updates to the content on the site you can always keep the site running locally on your machine using the below command which we went through earlier.

 ``` bash
    hugo server
```

As you save the markdown files which you are working on you will see the hugo site will be redeployed and you can see your changes and updates in realtime, this way you can ensure that your content it formatting as you expect it too.

**Note:** You can also view how your markdown file will look by rendering it in VS Code using the (command+shift+v) shortcut.

When you are ready to commit changes following the below steps to upload your changes to the repository

1. If you do not have the int