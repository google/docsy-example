---
title: "Getting Started"
linkTitle: "Getting Started"
weight: 2
description: >
  Download, install and use.
---

## Prerequisites

This package requires;
- python version 3.7+
- Anaconda version 3.7

Are there any system requirements for using your project? What languages are supported (if any)? Do users need to already have any software or tools installed?

## Basic use installation via conda or pip

This package should be installed by run;
```shell
conda install -c conda-forge -c bodc coast
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
Then start building a python environment. Here (for example) called ``coast_env``:

```
module load anaconda/5-2021 # or whatever it takes to activate conda
conda config --add channels conda-forge # add conda-forge to your conda channels

conda create -n coast_env python=3.8 # create a new environment. E.g. `coast_env`
conda activate coast_env # activate new environment
```
Install packages to the environment:
```
cd COAsT
conda install --file conda_requirements.txt
```
At the time of writing (06/10/2021) the contents of `conda_requirements.txt` was:
```
less COAsT/conda_requirements.txt
numpy>=1.16
dask>=2
dask[complete]>=2
xarray>=0.19
matplotlib>=3.4.3
netCDF4>=1
scipy>=1
gsw==3.3.1
utide>=0.2
scikit-learn>=0.2
scikit-image>=0.15
cartopy>=0.20.1
spyder>=4
```

Finally, you might want to download and unzip the example netCDF files:
```
cd COAsT
wget https://linkedsystems.uk/erddap/files/COAsT_example_files/COAsT_example_files.zip
unzip COAsT_example_files.zip
mv COAsT_example_files example_files
```


### Preparation for Workshop

#### Installation

Assuming a linux environment and that you have anaconda on your system:

```shell
## Fresh build in new conda environment
module load anaconda/5-2021 # or whatever it takes to activate conda
yes | conda env remove --name workshop_env # remove environment 'workshop_env' if it exists
yes | conda create --name workshop_env python=3.8 # create a new environment
conda activate workshop_env # activate new environment
yes | conda install -c conda-forge -c bodc coast # install COAsT within new environment
yes | conda install -c conda-forge cartopy=0.20.1 # install cartopy
```

#### Example files

Download example files and link them into a new directory:

```shell
rm -rf coast_demo
mkdir coast_demo
cd coast_demo
wget -c https://linkedsystems.uk/erddap/files/COAsT_example_files/COAsT_example_files.zip &&  unzip COAsT_example_files.zip
ln -s COAsT_example_files example_files
```

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
3.3.1
3.4.3
```
If it is, great carry on. If it is not, problems may occur with some functionality in coast. Please get in contact using the contacts in the workshop email.

Take a look at the example pages for more information on
specific objects and methods.
