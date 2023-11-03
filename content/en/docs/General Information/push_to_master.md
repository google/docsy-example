---
title: "Push to master"
linkTitle: "Push to master"
weight: 7
menu:
  documentation:
    weight: 20
description: >
  Procedure for pushing to master / publishing.
---

To date the workflow has been to unit test anything and everything that goes
into the develop branch and then periodically push to master less frequently
and issue a new github release.

With the push to master Git Actions build the conda and pip packages and the
package receives a zenodo update (https://zenodo.org/account/settings/github/repository/British-Oceanographic-Data-Centre/COAsT) and DOI.

### 1. Push to master

Any push to master initiates the Git Actions to build and release the package. It is advisable then to prepare the release in develop and only ever pull into master from develop. (Pulling from master to develop could bring unexpected Git Actions to develop). In order for the package builds to work the version of the package must be unique. The **version** of the package is set in
file *setup.py*. E.g. shown as 2.0.1 below:

```shell
# setup.py

...
PACKAGE = SimpleNamespace(**{
    "name": "COAsT",
    "version": "2.0.1",
    "description": "This is the Coast Ocean Assessment Tool",
    "url": "https://www.bodc.ac.uk",
    "download_url": "https://github.com/British-Oceanographic-Data-Centre/COAsT/",
    ....
```

Package version also appears in CITATION.cff file, which therefore also needs updating. E.g.:
```
...
title: British-Oceanographic-Data-Centre/COAsT: v2.0.1
version: v2.0.1
date-released: 2022-04-07
```

Version numbering follows the [semantic versioning convention](http://semver.org/).
Briefly, given a version number MAJOR.MINOR.PATCH, increment the:
* MAJOR version when you make incompatible API changes,
* MINOR version when you add functionality in a backwards compatible manner, and
* PATCH version when you make backwards compatible bug fixes.
Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

### 2. Issue new release

Then issue a [new release](https://github.com/British-Oceanographic-Data-Centre/COAsT/releases), with the new version label, and annotate the major changes.
