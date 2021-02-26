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

To update the master branch update only the **version** of the package in the
file *setup.py* (or the conda building wont work). E.g. shown as 0.4.1 below:

```shell
# setup.py

...
PACKAGE = SimpleNamespace(**{
    "name": "COAsT",
    "version": "0.4.1",
    "description": "This is the Coast Ocean Assessment Tool",
    "url": "https://www.bodc.ac.uk",
    "download_url": "https://github.com/British-Oceanographic-Data-Centre/COAsT/",
    ....
```

Version numbering follows the [semantic versioning convention](http://semver.org/).
Briefly, given a version number MAJOR.MINOR.PATCH, increment the:
* MAJOR version when you make incompatible API changes,
* MINOR version when you add functionality in a backwards compatible manner, and
* PATCH version when you make backwards compatible bug fixes.
Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

### 2. Issue new release

Then issue a [new release](https://github.com/British-Oceanographic-Data-Centre/COAsT/releases), with the new version label, and annotate the major changes.
