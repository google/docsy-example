---
title: "Configuration files"
linkTitle: "Configuration files"
date: 2021-09-07
weight: 18
description: >
  Information regarding the use of configuration files within the COAsT package.
---

Configuration file code can be found in
``coast/config`` within the [COAsT](https://github.com/British-Oceanographic-Data-Centre/COAsT/tree/master/coast/config) github repository.
This code is used internally within the package.

## Configuration file usage
Configuration files are passed into a COAsT class on the instantiation of a new object. For example the ```Gridded class``` ```__init__``` method takes an argument ``config``.
This argument must be a String or Path object representing a path to the configuration file.
E.g.
```python
config_file = "./config/example_nemo_grid_t.json" # path to json config file
fn_nemo_dat = "coast_example_nemo_data.nc"
fn_nemo_dom = "coast_example_nemo_domain.nc"

gridded_obj = coast.Gridded(fn_data=fn_nemo_dat, fn_domain=fn_nemo_dom, config=config_file)
```

For convenience, as indicated above, the path to the configuration file could be alternatively expressed as a path object. E.g.:
```python
from pathlib import Path
config_file = Path("path/to/config_file.json")
```
## Configuration file structure
Configuration files must follow a standard structure so that the ```ConfigParser``` class can parse the file correctly.

Depending on the type of configuration file, there are a number of required keys:

### Gridded configuration

| Key     | Description |
| --- | ----------- |
| ``type`` | A string value representing the type of configuration file. In the case of gridded config this will always be "gridded".       |
| ``dimensionality`` | An integer value representing the number of dimensions within the data files.       |
| ``grid_ref`` | A dictionary containing the type of grid, and a list of grid variables defining the mapping from the domain file to NEMO file. |
| ``chunks`` | A dictionary defining a dask [chunk shape](https://docs.dask.org/en/latest/array-chunks.html), used when loading in data files. JSON doesn't support integer keys, and so the dimensions name should be provided as the key instead. An empty dictionary will result in auto chunking. Rechunking can be applied subsequently with the standardised dimension names. |
| ``dataset``   | Parent key for holding configuration specific to the dataset files. |
| ``domain`` | Parent key for holding configuration specific to domain files. This is an __optional__ key depending on whether a domain file is required or not.     |
| ``dimension_map`` | Child key of dataset/domain. A dictionary defining the mappings between input data dimension names and the framework's standardised dimension names.  |
| ``variable_map`` | Child key of dataset/domain. A dictionary defining the mappings between input data variable names and the framework's standardised variable names. |
|``keep_all_vars``| Optional child key of dataset/domain. If "True", all variables from the input datafile will be carried over to the Gridded dataset. If "False", only mapped variables will be carried over.  "False" is assumed if the key is not present. |
|``coord_vars``| Child key of dataset. A list of dataset coordinate variables to apply once dataset is loaded. |
|``static_variables``| Parent key for holding configuration used for merging domain variables into the main dataset. |
|``not_grid_vars``| Child key of static_variables. A list of grid independant variables to pull across from the domain file. |
|``delete_vars``| Child key of static_variables. A list of variables to drop following the merge of domain and dataset. |
| ``processing_flags`` | A list of strings referring to any preliminary processing methods to be carried out on the data. |

### Indexed configuration
| Key     | Description |
| --- | ----------- |
| ``type`` | A string value representing the type of configuration file. In the case of indexed config this will always be "indexed".       |
| ``dimensionality`` | An integer value representing the number of dimensions within the data files.       |
| ``chunks`` | A dictionary defining a dask [chunk shape](https://docs.dask.org/en/latest/array-chunks.html), used when loading in data files. JSON doesn't support integer keys, and so the dimensions name should be provided as the key instead. An empty dictionary will result in auto chunking. Rechunking can be applied subsequently with the standardised dimension names. |
| ``dataset``   | Parent key for holding configuration specific to the dataset files. |
| ``dimension_map`` | Child key of dataset. A dictionary defining the mappings between input data dimension names and the framework's standardised dimension names.  |
| ``variable_map`` | Child key of dataset. A dictionary defining the mappings between input data variable names and the framework's standardised variable names. |
|``keep_all_vars``| Optional child key of dataset/domain. If "True", all variables from the input datafile will be carried over to the Indexed dataset. If "False", only mapped variables will be carried over.  "False" is assumed if the key is not present. |
|``coord_vars``| Child key of dataset. A list of dataset coordinate variables to apply once dataset is loaded. |
| ``processing_flags`` | A list of strings referring to any preliminary processing methods to be carried out on the data. |

### Example configuration file
Below is the template of a gridded configuration file:
```json
{
	"type": "gridded",
	"dimensionality": 4,
	"chunks": {
		"time_counter":2,
		"x":4,
		"y":4
	},
  "grid_ref": {
		"t-grid": [
			"glamt",
			"gphit",
			"e1t",
			"e2t",
			"e3t_0",
			"deptht_0",
			"tmask",
			"bottom_level",
			"hbatt"
		]
	},
	"dataset": {
		"dimension_map": {
			"time_counter": "t_dim",
			"deptht": "z_dim",
			"y": "y_dim",
			"x": "x_dim",
			"x_grid_T": "x_dim",
			"y_grid_T": "y_dim"
		},
		"variable_map": {
			"time_counter": "time",
			"votemper": "temperature",
			"thetao": "temperature",
			"temp": "temperature",
			"toce": "temperature",
			"so": "salinity",
			"vosaline": "salinity",
			"soce": "salinity",
			"sossheig": "ssh",
			"zos": "ssh"
		},
		"coord_vars": [
			"longitude",
			"latitude",
			"time",
			"depth_0"
		]
	},
	"domain": {
		"dimension_map": {
			"t": "t_dim0",
			"x": "x_dim",
			"y": "y_dim",
			"z": "z_dim"
		},
		"variable_map": {
			"time_counter": "time0",
			"glamt": "longitude",
			"gphit": "latitude",
			"e1t": "e1",
			"e2t": "e2",
			"e3t_0": "e3_0",
			"tmask":"mask",
			"deptht_0": "depth_0",
			"bottom_level": "bottom_level",
			"hbatt":"bathymetry"
		}
	},
	"static_variables": {
		"not_grid_vars": [
			"jpiglo",
			"jpjglo",
			"jpkglo",
			"jperio",
			"ln_zco",
			"ln_zps",
			"ln_sco",
			"ln_isfcav"
		],
		"delete_vars": [
			"nav_lat",
			"nav_lon",
			"deptht"
		]
	},
	"processing_flags": [
		"example_flag1",
		"example_flag2"
	]
}
```
__Example configuration__ files can be found in the ``config/`` directory within the [COAsT](https://github.com/British-Oceanographic-Data-Centre/COAsT/tree/master/config) github repository.
