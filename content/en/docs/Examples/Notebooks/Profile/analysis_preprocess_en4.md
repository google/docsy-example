---
    title: "Analysis preprocess en4"
    linkTitle: "Analysis preprocess en4"
    weight: 5

    description: >
        Analysis preprocess en4 example.
---
Script for processing raw EN4 data prior to analysis.
See docstring of `Profile.process_en4()` for more specifics on what it does.

This script will just load modules, read in raw EN4 data, cut out a geographical box, call the processing routine and write the processed data to file.

You don't have to do this for each EN4 file individually if you don't want, you can read in multiple using `multiple = True` on the creation of the profile object. However, if analysing model data in parallel chunks, you may want to split up the processing into smaller files to make the analysis faster.


```python
import sys

# IF USING A DEVELOPMENT BRANCH OF COAST, ADD THE REPOSITORY TO PATH:
# sys.path.append('<PATH_TO_COAST_REPO')
import coast
import pandas as pd
from datetime import datetime
from os import path

print("Modules loaded")

# File paths - input en4, output processed file and read config file
"""
fn_prof = "<PATH_TO_RAW_EN4_DATA_FILE(S)>"
fn_out = "<PATH_TO_OUTPUT_LOCATION_FOR_PROCESSED_PROFILES>"
fn_cfg_prof = "<PATH_TO_COAST_PROFILE_CONFIG_FILE>"
"""

fn_out = "./output.nc"
fn_prof = path.join('./example_files', "coast_example_en4_201008.nc")
fn_cfg_prof = path.join('./config', "example_en4_profiles.json")


# Some important settings, easier to get at here
longitude_bounds = [-15, 15]  # Geo box to cut out from data (match to model)
latitude_bounds = [40, 65]
multiple = True  # Reading multple files?
```

    Modules loaded


Create profile object containing data


```python
profile = coast.Profile(config=fn_cfg_prof)
profile.read_en4(fn_prof, multiple=multiple)
```

    ./config/example_en4_profiles.json


Get geographical indices to extract.


```python
profile = profile.subset_indices_lonlat_box(longitude_bounds, latitude_bounds)
```

Cut out a time slice of the data.


```python
profile = profile.time_slice(date0=datetime(2010, 1, 1), date1=datetime(2010, 1, 20))
```

Process the extracted data into new processed profile.


```python
processed_profile = profile.process_en4()
```

Sometimes the following line is needed to avoid an error::  
`processed_profile.dataset["time"] = ("id_dim", pd.to_datetime(processed_profile.dataset.time.values))`

Write processed profiles to file.


```python
processed_profile.dataset.to_netcdf(fn_out)
```


```python

```
