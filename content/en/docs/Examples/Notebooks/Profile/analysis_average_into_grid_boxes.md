---
    title: "Analysis average into grid boxes"
    linkTitle: "Analysis average into grid boxes"
    weight: 5

    description: >
        Analysis average into grid boxes example.
---
Script for showing use of `Profile.average_into_grid_boxes()`. This routines
takes all data in a Profile obejct and averages it into lat/lon grid boxes.

This script can be used for comparing observed and modelled climatologies. 
It should be run AFTER the nearest profiles have been extracted from the model
data, such as shown in `analysis_extract_and_compare.py`. 

Input and output files should be provided as a list. If you only have
one input file, then just enclose the string in []. 

### Relevant imports and filepath configuration


```python
import coast
import numpy as np
import xarray as xr
import os
from os import path

# List of input files
fn_prof = path.join('./example_files', "coast_example_en4_201008.nc")
fn_cfg_prof = path.join('./config', "example_en4_profiles.json")  # If needed
fn_out = path.join('./example_files', 'mask_mean.nc')  # Names of output files (coresponding to fn_in_list), include ".nc"
```

    Matplotlib is building the font cache; this may take a moment.


Define longitude and latitude grid.


```python
grid_lon = np.arange(-15, 15, 0.5)
grid_lat = np.arange(45, 65, 0.5)
```

### Load the data
Load in data for averaging (e.g. surface data).


```python
prof_data = coast.Profile(config=fn_cfg_prof)
prof_data.read_en4(fn_prof)
profile_analysis = coast.ProfileAnalysis()
```

    ./config/example_en4_profiles.json


Take just the data we want so it is faster


```python
prof_data.dataset = prof_data.dataset[["temperature", "practical_salinity"]]
```

### Process, merge and save

Average all data across all seasons.


```python
prof_gridded = profile_analysis.average_into_grid_boxes(prof_data, grid_lon, grid_lat)
```

Average data for each season.


```python
prof_gridded_DJF = profile_analysis.average_into_grid_boxes(
    prof_data, grid_lon, grid_lat, season="DJF", var_modifier="_DJF"
)
prof_gridded_MAM = profile_analysis.average_into_grid_boxes(
    prof_data, grid_lon, grid_lat, season="MAM", var_modifier="_MAM"
)
prof_gridded_JJA = profile_analysis.average_into_grid_boxes(
    prof_data, grid_lon, grid_lat, season="JJA", var_modifier="_JJA"
)
prof_gridded_SON = profile_analysis.average_into_grid_boxes(
    prof_data, grid_lon, grid_lat, season="SON", var_modifier="_SON"
)
```

Merge together.


```python
ds_prof_gridded = xr.merge(
    (
        prof_gridded.dataset,
        prof_gridded_DJF.dataset,
        prof_gridded_MAM.dataset,
        prof_gridded_JJA.dataset,
        prof_gridded_SON.dataset,
    )
)
```

Save to file.


```python
ds_prof_gridded.to_netcdf(fn_out)
```


```python

```
