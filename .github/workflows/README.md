## Automated deployment on GitHub pages on each commit and/or pull request

To enable automatic deployment on each push to your repo, move the the corresponding [workflow file](.github/workflows/example/deploy-github-pages.yml) into this folder `.github/workflows`.

```
mv example/deploy-github-pages.yml .
```

For further details, refer to the section `` in the `REDAME.md file located in the root of this repo.

## Automated link check on each commit and/or pull request

Inside the example subdirectory, you will find a GitHub action file that allows you to check the internal links of your page using the fast [hyperlink](https://github.com/untitaker/hyperlink) link checker. To enable automatic link checking on each push to your repo, move the the corresponding [workflow file](example/link-check.yml) into this folder `.github/workflows`. 

```
mv example/link-check.yml .
```

Afterwards, the link check action will be performed on each push to your repo.
