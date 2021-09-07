---
title: "Configuration files"
linkTitle: "Configuration files"
date: 2021-09-07
weight: 18
description: >
  Further information about the use of configuration files within the COAsT package.
---

Configuration file code can be found in
``coast/config`` in the [COAsT](https://github.com/British-Oceanographic-Data-Centre/COAsT/tree/master/coast/config) repository.
This code is used internally within the packages main classes.

## Configuration file usage
Configuration files are passed into a COAsT class on the instantiation of a new object. For example the ```Gridded class``` ```__init__``` method takes an argument ``config``.
This argument must be a String or Path object representing a path to the configuration file.
```python
# Add example of gridded here.
```

## Configuration file structure
Configuration files must follow a standard structure so that the ```ConfigParser``` class can parse the file correctly.
Example configuration files can be found in the ``config/`` directory within the [COAsT](https://github.com/British-Oceanographic-Data-Centre/COAsT/tree/master/config) repository.

Depending on the type of configuration file, there are a number of required keys:

### Gridded configuration
| Key     | Description |
| --- | ----------- |
| type | A string value representing the type of configuration file. In the case of gridded config this will always be "gridded".       |
| dimensionality | An integer value representing the number of dimensions within the data files.       |
| grid_ref | A dictionary containing the type of grid, and a list of grid variables defining the mapping from the domain file to NEMO file. |
| chunks | A list defining a dask uniform [chunk shape](https://docs.dask.org/en/latest/array-chunks.html), used when loading in data files. This is converted to a tuple automatically in code. |
| dataset   | Parent key for holding configuration specific to the dataset files. |
| domain   | Parent key for holding configuration specific to the domain files.       |
| dimension_map | Child key of dataset/domain. A dictionary defining the mappings between standard NEMO file dimension names and the datasets dimension names.  |
| variable_map | Child key of dataset/domain. A dictionary defining the mappings between standard NEMO file variable names and the datasets variable names. |
| processing_flags | A list of strings referring to any preliminary processing methods to be carried out on the data. |

### Indexed configuration
| Key     | Description |
| --- | ----------- |
| type | A string value representing the type of configuration file. In the case of indexed config this will always be "indexed".       |
| dimensionality | An integer value representing the number of dimensions within the data files.       |
| chunks | A list defining a dask uniform [chunk shape](https://docs.dask.org/en/latest/array-chunks.html), used when loading in data files. This is converted to a tuple automatically in code. |
| dataset   | Parent key for holding configuration specific to the dataset files. |
| dimension_map | Child key of dataset. A dictionary defining the mappings between standard NEMO file dimension names and the datasets dimension names.  |
| variable_map | Child key of dataset. A dictionary defining the mappings between standard NEMO file variable names and the datasets variable names. |
| processing_flags | A list of strings referring to any preliminary processing methods to be carried out on the data. |