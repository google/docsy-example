---
title: "Build test"
linkTitle: "Build test"
weight: 6
menu:
  documentation:
    weight: 20
description: >
  Build testing on master branch.
---

A short script to install COAsT in a conda environment, download and run some
build tests.

```shell
# Fresh build
module load anaconda/3-5.1.0 # or whatever it takes to activate conda
yes |  conda env remove --name test_env
yes | conda create -n test_env python=3.8 # create a new environment
conda activate test_env
yes | conda install -c conda-forge -c bodc coast
yes | conda install -c conda-forge cartopy=0.18.0 # used for some of the map plotting

# Download bits and bobs
rm -rf coast_test
mkdir coast_test
cd coast_test
git clone https://github.com/British-Oceanographic-Data-Centre/COAsT.git
wget -c https://linkedsystems.uk/erddap/files/COAsT_example_files/COAsT_example_files.zip &&  unzip COAsT_example_files.zip
ln -s COAsT/unit_testing/ .
ln -s COAsT_example_files example_files

# Run unit tests
python COAsT/unit_testing/unit_test.py > coast_test.txt

## If OK then clean up
cd ..
rm -rf coast_test
```
