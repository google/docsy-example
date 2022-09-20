---
title: "Config_structure"
linkTitle: "Config_structure"
date: 2022-09-20
description: >
  Docstrings for the Config_structure class
---
### Objects

[ConfigTypes()](#configtypes)<br />
[ConfigKeys()](#configkeys)<br />
[DataFile()](#datafile)<br />
[CodeProcessing()](#codeprocessing)<br />
[Dataset()](#dataset)<br />
[Domain()](#domain)<br />
[Config()](#config)<br />
[GriddedConfig()](#griddedconfig)<br />
[IndexedConfig()](#indexedconfig)<br />

Classes defining config structure.
#### ConfigTypes()
```python
class ConfigTypes(Enum):
```

```
Enum class containing the valid types for config files.
```

#### ConfigKeys()
```python
class ConfigKeys():
```

```
Class of constants representing valid keys within configuriation json.
```

#### DataFile()
```python
class DataFile():
```

```
General parent dataclass for holding common config attributes of datafiles.

Args:
    variable_map (dict): dict containing mapping for variable names.
    dimension_map (dict): dict containing mapping for dimension names.
    keep_all_vars (boolean): True if xarray is to retain all data file variables
                              otherwise False i.e keep only those in the json config file variable mappings.
```

#### CodeProcessing()
```python
class CodeProcessing():
```

```
Dataclass holding config attributes for static variables that might not need changing between model runs

Args:
    not_grid_variables (list): A list of variables not belonging to the grid.
    delete_variables (list):  A list of variables to drop from the dataset.
```

#### Dataset()
```python
class Dataset(DataFile):
```

```
Dataclass holding config attributes for Dataset datafiles. Extends DataFile.

Args:
    coord_var (list): list of dataset coordinate variables to apply once dataset is loaded
```

#### Domain()
```python
class Domain(DataFile):
```

```
Dataclass holding config attributes for Domain datafiles. Extends DataFile.
```

#### Config()
```python
class Config():
```

```
General dataclass for holding common config file attributes.

Args:
    dataset (Dataset): Dataset object representing 'dataset' config.
    processing_flags (list): List of processing flags.
    chunks (dict): dict for dask chunking config. (i.e. {"dim1":100, "dim2":100, "dim3":100}).
    type (ConfigTypes): Type of config. Must be a valid ConfigType.
```

#### GriddedConfig()
```python
class GriddedConfig(Config):
```

```
Dataclass for holding gridded-config specific attributes. Extends Config.

Args:
    type (ConfigTypes): Type of config. Set to ConfigTypes.GRIDDED.
    grid_ref (dict): dict containing key:value of grid_ref:[list of grid variables].
    domain (Domain): Domain object representing 'domain' config.
```

#### IndexedConfig()
```python
class IndexedConfig(Config):
```

```
Dataclass for holding indexed-config specific attributes. Extends Config.

Args:
    type (ConfigTypes): Type of config. Set to ConfigTypes.INDEXED.
```
