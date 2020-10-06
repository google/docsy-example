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

## Installation

This package should be installed by run;
```shell
conda install -c conda-forge -c bodc coast
```
However, there is also the option of;
```shell
pip install COAsT
```

if you wish to install from source then got to [GitHub](https://github.com/british-oceanographic-data-centre/COAsT) and follow the README instructions


## Setup
The base package should now be installed on your system. The following packages might be required for some of the advanced features;

- cartopy
- graphviz


## Try it out!
The below example works best with the COAsT example data. Start by importing COAsT:
```python
import coast
```
Now load a NEMO output file and domain file into a NEMO object (specifying the grid):
```python
data_file = '<Path to NEMO data file>'
domain_file = '<Path to NEMO domain file>'
sci = coast.NEMO(data_file, domain_file, grid_ref = 't-grid')
```
You can now start having a look at some of the methods inside the NEMO class. 
Interrogate the NEMO data by taking a look inside sci.dataset. This contains all the
information from the netCDF file.

Lets take a look at some altimetry data around the UK too. Load in the data:
```python
altimetry_file = '<Path to Altimetry data file>'
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
