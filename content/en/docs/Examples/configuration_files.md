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
```python
from pathlib import Path
from coast.gridded import Gridded

config_file = Path("path/to/config_file.json")
gridded_obj = Gridded(fn_data="data-file.nc", fn_domain="domain-file.nc", config=config_file)
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
| ``chunks`` | A list defining a dask uniform [chunk shape](https://docs.dask.org/en/latest/array-chunks.html), used when loading in data files. This is converted to a tuple automatically in code. |
| ``dataset``   | Parent key for holding configuration specific to the dataset files. |
| ``domain`` | Parent key for holding configuration specific to domain files. This is an __optional__ key depending on whether a domain file is required or not.     |
| ``dimension_map`` | Child key of dataset/domain. A dictionary defining the mappings between input data dimension names and the framework's standardised dimension names.  |
| ``variable_map`` | Child key of dataset/domain. A dictionary defining the mappings between input data variable names and the framework's standardised variable names. |
|``static_variables``| Parent key for holding configuration used for merging domain variables into the main dataset. |
|``not_grid_vars``| Child key of static_variables. A list of grid independant variables to pull across from the domain file. |
|``coord_vars``| Child key of static_variables. A list of variables to be set as coordinates after the merge. (Coordinates are reset and then set again as part of the merge.) |
|``delete_vars``| Child key of static_variables. A list of variables to drop following the merge of domain and dataset. |
| ``processing_flags`` | A list of strings referring to any preliminary processing methods to be carried out on the data. |

### Indexed configuration
| Key     | Description |
| --- | ----------- |
| ``type`` | A string value representing the type of configuration file. In the case of indexed config this will always be "indexed".       |
| ``dimensionality`` | An integer value representing the number of dimensions within the data files.       |
| ``chunks`` | A list defining a dask uniform [chunk shape](https://docs.dask.org/en/latest/array-chunks.html), used when loading in data files. This is converted to a tuple automatically in code. |
| ``dataset``   | Parent key for holding configuration specific to the dataset files. |
| ``dimension_map`` | Child key of dataset. A dictionary defining the mappings between input data dimension names and the framework's standardised dimension names.  |
| ``variable_map`` | Child key of dataset. A dictionary defining the mappings between input data variable names and the framework's standardised variable names. |
| ``processing_flags`` | A list of strings referring to any preliminary processing methods to be carried out on the data. |

### Example configuration file
Below is the template of a gridded configuration file:
```json
{
	"type": "gridded",
	"dimensionality": 3,
	"chunks": [
		1000,
		1000,
		1000
	],
	"grid_ref": {
		"t-grid": [
			"glamt",
			"gphit",
			"e1t",
			"e2t",
			"e3t_0",
			"deptht_0",
			"tmask",
			"bottom_level"
		]
	},
	"dataset": {
		"dimension_map": {
			"ex1": "time_counter",
			"ex2": "deptht",
			"ex3": "depthu",
			"ex4": "depthv",
			"ex5": "y",
			"ex6": "x",
			"ex7": "x_grid_T",
			"ex8": "y_grid_T"
		},
		"variable_map": {
			"ex1": "time_counter",
			"ex2": "votemper",
			"ex3": "thetao",
			"ex4": "temp",
			"ex5": "toce",
			"ex6": "so",
			"ex7": "vosaline",
			"ex8": "soce",
			"ex9": "voce",
			"ex10": "vomecrty",
			"ex11": "uoce",
			"ex12": "vozocrtx",
			"ex13": "sossheig",
			"ex14": "zos"
		}
	},
	"domain": {
		"dimension_map": {
			"ex1": "t",
			"ex2": "x",
			"ex3": "y",
			"ex4": "z"
		},
		"variable_map": {
			"ex1": "time_counter",
			"ex2": "glamt",
			"ex3": "glamu",
			"ex4": "glamv",
			"ex5": "glamf",
			"ex6": "gphit",
			"ex7": "gphiu",
			"ex8": "gphiv",
			"ex9": "gphif",
			"ex10": "e1t",
			"ex11": "e1u",
			"ex12": "e1v",
			"ex13": "e1f",
			"ex14": "e2t",
			"ex15": "e2u",
			"ex16": "e2v",
			"ex17": "e2f",
			"ex18": "ff_t",
			"ex19": "ff_f",
			"ex20": "e3t_0",
			"ex21": "e3w_0",
			"ex22": "e3u_0",
			"ex23": "e3v_0",
			"ex24": "e3f_0",
			"ex25": "tmask",
			"ex26": "depthf_0",
			"ex27": "depthu_0",
			"ex28": "depthv_0",
			"ex29": "depthw_0",
			"ex30": "deptht_0",
			"ex31": "ln_sco",
			"ex32": "bottom_level"
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
		"coord_vars": [
			"longitude",
			"latitude",
			"time",
			"depth_0"
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
Raw __example configuration__ files can be found in the ``config/`` directory within the [COAsT](https://github.com/British-Oceanographic-Data-Centre/COAsT/tree/master/config) github repository.