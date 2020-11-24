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

The base package should now be installed on your system. The following packages might be required for some of the advanced features;

- cartopy
- graphviz

## Development use installation

If you would prefer to work with a clone of the repository in a development
python environment do the following. First clone the repoitory in the place
where you want to work:
```
git clone https://github.com/British-Oceanographic-Data-Centre/COAsT.git
```
Then start building a python environment. Here (for example) called ``coast_env``:

```
module load anaconda/3-5.1.0 # or whatever it takes to activate conda
conda config --add channels conda-forge # add conda-forge to your conda channels

conda create -n conda_env python=3.8 # create a new environment. E.g. `conda_env`
conda activate conda_env # activate new environment
```
Install packages to the environment:
```
conda install --file COAsT/conda_requirements.txt
```
At the time of writing the contents of `conda_requirements.txt` was:
```
less COAsT/conda_requirements.txt
numpy>=1.16
dask>=2
dask[complete]>=2
xarray>=0.1
matplotlib>=3
netCDF4>=1
scipy>=1
gsw==3.3.1
scikit-learn>=0.2
scikit-image>=0.15
cartopy
spyder>=4
```

Finally, you might want to download and unzip the example netCDF files:
```
cd COAsT
wget https://linkedsystems.uk/erddap/files/COAsT_example_files/COAsT_example_files.zip
unzip COAsT_example_files.zip
mv COAsT_example_files example_files
```

## Preparation for Workshop

How to install COAsT in a conda environment and download demonstration files
for the COAsT Workshop on 30th November 2020.

### Installation

Assuming a linux environment and that you have anaconda on your system:

```shell
## Fresh build in new conda environment
module load anaconda/3-5.1.0 # or whatever it takes to make conda available
yes |  conda env remove --name workshop_env # remove environment 'workshop_env' if it exists
yes | conda create --name workshop_env python=3.8 # create a new environment
conda activate workshop_env # activate new environment
yes | conda install -c conda-forge -c bodc coast # install COAsT within new environment
yes | conda install cartopy=0.18.0
```

### Example files

Download example files and link them into a new directory:

```shell
rm -rf coast_demo
mkdir coast_demo
cd coast_demo
wget -c https://linkedsystems.uk/erddap/files/COAsT_example_files/COAsT_example_files.zip &&  unzip COAsT_example_files.zip
ln -s COAsT_example_files example_files
```

### Try it out!
The below example works best with the COAsT example data. Start by opening a
python terminal and then importing COAsT:
```python
import coast
```
Now load a NEMO output file and domain file into a NEMO object, specifying the
  grid (using example data just downloaded above):
```python
data_file = 'example_files/COAsT_example_NEMO_data.nc' # <Path to NEMO data file>
domain_file = 'example_files/COAsT_example_NEMO_domain.nc' # <Path to NEMO domain file>
sci = coast.NEMO(data_file, domain_file, grid_ref = 't-grid')
```
There are a bunch of warnings that can be ignored (and we might have fixed before the
  workshop! It is on the [Issue tracker](https://github.com/British-Oceanographic-Data-Centre/COAsT/issues/123)). You can now start having a look at some
  of the methods inside the NEMO class. Interrogate the NEMO data by taking a look inside ``sci.dataset``. This contains all the information from the netCDF file.

Let's take a look at some altimetry data around the UK too. Load in the data:
```python
altimetry_file = 'example_files/COAsT_example_altimetry_data.nc' # <Path to Altimetry data file>
altimetry = coast.ALTIMETRY(altimetry_file)
```
Subset the data so that only data over the North West European Shelf remains in the object.
```
ind = altimetry.subset_indices_lonlat_box([-10,10], [45,60])
altimetry = altimetry.isel(t_dim=ind)
```
Now take a look at the data inside the object:
```
altimetry.quick_plot('sla_filtered')
```

Nice one! Hopefully that all worked and you're ready to take a look at the rest of the
package and documentation. Take a look at the example pages for more information on
specific objects and methods.
