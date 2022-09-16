---
title: "Getting Started at Liverpool"
linkTitle: "Getting Started at Liverpool"
weight: 2
description: >
  Download, install and use.
---

![image info](https://github.githubassets.com/images/icons/emoji/unicode/26a0.png)
**For use on Liverpool servers only**

## Prerequisites

This package requires;
- python version 3.8+
- Anaconda version 4.10+

Are there any system requirements for using this project? What languages are supported (if any)? Do users need to already have any software or tools installed?

## Basic use installation via conda or pip

This package should be installed by run;
```shell
conda install -c bodc coast
```
However, there is also the option of;
```shell
pip install COAsT
```

if you wish to install from source then got to [GitHub](https://github.com/british-oceanographic-data-centre/COAsT) and follow the README instructions

The base package should now be installed on your system. The following packages might be required for some of the advanced plotting features;

- cartopy

## Development use installation

If you would prefer to work with a clone of the repository in a development
python environment do the following. First clone the repoitory in the place
where you want to work:
```
git clone https://github.com/British-Oceanographic-Data-Centre/COAsT.git
```
Then start building a python environment. Here (for example) called ``coast_dev``:

```
module load anaconda/5-2021 # or whatever it takes to activate conda
conda config --add channels conda-forge # add conda-forge to your conda channels

conda create -n coast_dev python=3.8 # create a new environment. E.g. `coast_dev`
conda activate coast_dev # activate new environment
```
Install packages to the environment:
```
cd COAsT
conda install --file conda_dev_requirements.txt
```


## Obtaining Example files

In order to try the Examples, example data files and configuration files are recommended.

#### Example data files

Download example files and link them into a new directory:

```shell
rm -rf coast_demo
mkdir coast_demo
cd coast_demo
wget -c https://linkedsystems.uk/erddap/files/COAsT_example_files/COAsT_example_files.zip &&  unzip COAsT_example_files.zip
ln -s COAsT_example_files example_files
```

#### Example configuration files

To facilitate loading different types of data, key information is passed to COAsT using configuration files. The config files used in the Examples are in the repository, or can be downloaded as static files:

```shell
cd ../coast_demo
wget -c https://github.com/British-Oceanographic-Data-Centre/COAsT/archive/refs/heads/master.zip && unzip COAsT-master.zip
ln -s COAsT-master/config config
```

## Preparation for Workshop

#### Package Installation with conda

Assuming a linux environment and that you have anaconda on your system:

```shell
## Fresh build in new conda environment
module load anaconda/5-2021 # or whatever it takes to activate conda
yes | conda env remove --name workshop_env # remove environment 'workshop_env' if it exists
yes | conda create --name workshop_env python=3.8 # create a new environment
conda activate workshop_env # activate new environment
yes | conda install -c bodc coast=2.0.3 # install COAsT within new environment
yes | conda install -c conda-forge cartopy=0.20.2 # install cartopy
```
Then obtain the Example data and configuration files (as above).


## External Requirements
All required packages should be defined in the [environment.yml](https://github.com/British-Oceanographic-Data-Centre/COAsT/blob/develop/environment.yml).

## Test it!
The below example works best with the COAsT example data. Start by opening a
python terminal and then importing COAsT:
```python
import coast
```
Before using coast, we will just check that Anaconda has installed correct package versions. In the python console copy the following:
```python
import gsw
import matplotlib
print(gsw.__version__)
print(matplotlib.__version__)
```
The output should be
```python
3.4.0
3.5.1
```
If it is, great carry on. If it is not, problems may occur with some functionality in coast. Please get in contact using the contacts in the workshop email.

Take a look at the example pages for more information on
specific objects and methods.
