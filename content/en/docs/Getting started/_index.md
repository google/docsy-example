---
title: "Getting Started"
linkTitle: "Getting Started"
weight: 2
description: >
  Download, install and use.
---

## Prerequisites

This package requires;
- a linux environment or [docker](https://docs.docker.com/desktop/install/windows-install/) for Windows
- python version 3.8.10
- [Miniconda](https://docs.conda.io/en/latest/miniconda.html#linux-installers)

## Basic use installation via conda or pip

This package should be installed by run;
```shell
conda install -c bodc coast
```
However, there is also the option of;
```shell
pip install COAsT
```

## Development use installation

If you would prefer to work with a clone of the repository in a development
python environment do the following. First [clone the repoitory](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository) in the place
where you want to work:
```
git clone https://github.com/British-Oceanographic-Data-Centre/COAsT.git
cd COAsT
```
Then build a python environment:

```
conda env update --prune --file environment.yml 
conda activate coast
```

## Building the docker image and executing an interactive environment
Warning, building the image is resource heavy.  
After cloning the repo (as above). 
```shell
docker build . --tag coast
docker compose up -d
docker compose exec coast bash
```
You can now start a python session and `import coast`.
docker compose mounts 3 directories from you host machine onto the docker container:  
  ./example_files:/example_files   
  ./config:/config  
  ./example_scripts:/example_scripts  



## Obtaining Example files

In order to try the Examples, example data files and configuration files are recommended.

#### Example data files

Download example files and link them into a new directory:

```shell
wget -c https://linkedsystems.uk/erddap/files/COAsT_example_files/COAsT_example_files.zip &&  unzip COAsT_example_files.zip
```

#### Example configuration files

To facilitate loading different types of data, key information is passed to COAsT using configuration files. The config files used in the Examples are in the repository, or can be downloaded as static files:

```shell
wget -c https://github.com/British-Oceanographic-Data-Centre/COAsT/archive/refs/heads/master.zip && unzip COAsT-master.zip
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
3.4.0
3.5.1
```
If it is, great carry on. If it is not, problems may occur with some functionality in coast. Please get in contact using the contacts in the workshop email.

Take a look at the example pages for more information on
specific objects and methods.
