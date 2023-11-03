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
- [Miniconda](https://docs.conda.io/en/latest/miniconda.html#linux-installers) (if you are planning to install it using conda)

## Basic use installation via conda or pip

This package should be installed by run;
```shell
conda install -c bodc coast
```
However, there is also the option of;
```shell
pip install COAsT
```

### (Optional): Extra python packages
In order to try the [Examples described in this documentation](https://british-oceanographic-data-centre.github.io/COAsT/docs/examples/), you may also need to install the following python packages (as they are not natively part of the COAsT package):

```bash
# cartopy
pip install cartopy
# xesmf
pip install xesmf
```


## Development use installation

If you would prefer to work with a clone of the repository in a development
python environment do the following. First [clone the repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository) in the place
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

> **Warning:**
> Building the image is resource heavy

After cloning the repo (as above):

```shell
docker build . --tag coast
docker compose up -d
docker compose exec coast bash
```
You can now start a python session and `import coast`. Docker compose mounts 3
directories from you host machine onto the docker container:  

    ./example_files:/example_files   
    ./config:/config  
    ./example_scripts:/example_scripts  

## Check the installation!

Start by opening a python terminal and then importing COAsT:
```python
import coast
```
Before using coast, we will just check if the installation process (Anaconda or pip) has installed correct package versions. In the python console copy the following:
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
or later. If it is, great carry on. If it is not, problems may occur with some functionality in coast. In this case, please update these packages versions.


## Test it!

In order to test the package, example data files and configuration files are recommended.

### Example data files

Download example files and link them into a new directory:

```shell
wget -c https://linkedsystems.uk/erddap/files/COAsT_example_files/COAsT_example_files.zip &&  unzip COAsT_example_files.zip && rm -f COAsT_example_files.zip
```

### Example configuration files

To facilitate loading different types of data, key information is passed to COAsT using configuration files. The config files used in the Examples are in the repository, or can be downloaded as static files:

```shell
wget -c https://github.com/British-Oceanographic-Data-Centre/COAsT/archive/refs/heads/master.zip && unzip master.zip && rm -f master.zip
mv COAsT-master/config ./ && rm -rf COAsT-master
```

Explore the [API Reference Page](https://british-oceanographic-data-centre.github.io/COAsT/docs/references/) to access detailed information about specific objects and methods. Additionally, you can find practical usage examples on the [example pages](https://british-oceanographic-data-centre.github.io/COAsT/docs/examples/).

<br>

> **IMPORTANT**:
> If you are utilizing COAsT at the National Oceanography Centre (NOC) on Liverpool Servers, kindly access [this link on the NOC Intranet](https://nocacuk.sharepoint.com/sites/DigitalOcean/SitePages/COAsT-Installation-on-Liverpool-Servers.aspx) for additional details.

<br>