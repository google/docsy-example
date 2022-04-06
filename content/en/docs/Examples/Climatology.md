---
title: "Climatology"
linkTitle: "Climatology"
weight: 5

description: >
  Example useage of Climatology object
---


This is a demonstration script for using the Climatology object in the COAsT
package. This object has methods for analysing climatological data. Further examples can be found in the [COAsT github](https://github.com/British-Oceanographic-Data-Centre/COAsT/blob/master/example_scripts/climatology_example.py) repository.


# Climatological means
This section shows an example of how to use the ``Climatology.make_climatology()`` method to calculates mean over a given period of time. This method doesn't take different years into account, unless using the 'years' frequency. (See the [Multi-year climatological means](#multi-year-climatological-means) section for multi-yeared data.)

Begin by importing coast:
```python
import coast
```

And by defining some file paths for the data:
```python
# Path to a data file.
fn_nemo_dat  = "./example_files/coast_example_nemo_data.nc"
# Set path for domain file if required.
fn_nemo_dom  = "./example_files/coast_example_nemo_domain.nc"
# Set path for model configuration file
config = "./config/example_nemo_grid_t.json"

# Read in data (This example uses NEMO data.)
nemo = coast.Gridded(fn_nemo_dat, fn_nemo_dom, config=config)
```

Calculate the climatology for temperature and sea surface height (ssh) as an example:
```python
# Optional (This specifies an output file path.)
fn_out = "/path/to/outputfile.nc" 
# String is appended to "time." to create a valid xarray time period. (i.e. time.season, time.month...)
climatology_frequency = "month" 

clim = coast.Climatology()

# Not writing output to file:
clim_mean = clim.make_climatology(nemo[['temperature','ssh']], climatology_frequency)
# Writing output to file (may require a large amount of memory.)
clim_mean = clim.make_climatology(nemo[['temperature','ssh']], climatology_frequency, fn_out=fn_out)
```

Below shows the structure of a dataset returned, containing 1 month worth of meaned temperature and sea surface height data:
```
<xarray.Dataset>
Dimensions:      (y_dim: 375, x_dim: 297, z_dim: 51, month: 1)
Coordinates:
    longitude    (y_dim, x_dim) float32 ...
    latitude     (y_dim, x_dim) float32 ...
    depth_0      (z_dim, y_dim, x_dim) float32 0.5 0.5 0.5 ... 50.5 50.5 50.5
  * month        (month) int64 1
Dimensions without coordinates: y_dim, x_dim, z_dim
Data variables:
    temperature  (month, z_dim, y_dim, x_dim) float32 dask.array<chunksize=(1, 51, 375, 297), meta=np.ndarray>
    ssh          (month, y_dim, x_dim) float32 dask.array<chunksize=(1, 375, 297), meta=np.ndarray>
```


# Multi-year climatological means
This section shows an example of how to use the ``Climatology.multiyear_averages()`` method to generate annual averages across specified periods of time. This method is designed to be compatible with multi-year datasets, but will work with single year datasets too.

Begin by importing coast and helpful coast utilities:
```python
import coast
from coast import seasons 
```

And by defining some file paths for the data:
```python
# Path to a single or multiple NEMO files.
fn_nemo_data = "/Path/to/Nemo/*.nc"
# Set path for domain file if required.
fn_nemo_domain = "/Path/to/domain/domain.nc"
fn_config_t_grid = "/Path/to/config/file.json"

# Read in multiyear data (This example uses NEMO data from multiple datafiles.)
nemo = coast.Gridded(fn_data=fn_nemo_data, fn_domain=fn_nemo_domain, config=fn_config_t_grid, multiple=True)
```

Now calculate temperature and ssh means of each season across multiple years for specified data:
```python
clim = coast.Climatology()
# Using seasons module to specify time period.
# SPRING, SUMMER, AUTUMN, WINTER, ALL are valid values for seasons.
clim_multiyear = clim.multiyear_averages(nemo[['temperature','ssh']], seasons.ALL, time_var='time', time_dim='t_dim')

# Or explicitly defining specific month periods.
# A list of tuples defining start and end month integers. The start months should be in chronological order.
# (you may need to read/load the data again if it gives an error)
nemo = coast.Gridded(fn_data=fn_nemo_data, fn_domain=fn_nemo_domain, config=fn_config_t_grid, multiple=True)
month_periods = [(1,2), (12,2)] # Specifies January -> February and December -> February for each year of data. 
clim_multiyear = clim.multiyear_averages(nemo[['temperature','ssh']], month_periods , time_var='time', time_dim='t_dim')

```

Below shows the structure of a dataset returned from this method:
```
<xarray.Dataset>
Dimensions:              (y_dim: 375, x_dim: 297, z_dim: 51, year_period: 2)
Coordinates:
    longitude            (y_dim, x_dim) float32 -19.89 -19.78 ... 12.89 13.0
    latitude             (y_dim, x_dim) float32 40.07 40.07 40.07 ... 65.0 65.0
    depth_0              (z_dim, y_dim, x_dim) float32 0.5 0.5 0.5 ... 50.5 50.5
  * year_period          (year_period) MultiIndex
  - year_period_level_0  (year_period) int64 2006 2007
  - year_period_level_1  (year_period) object 'Dec-Feb' 'Jan-Feb'
Dimensions without coordinates: y_dim, x_dim, z_dim
Data variables:
    temperature          (year_period, z_dim, y_dim, x_dim) float32 dask.array<chunksize=(1, 51, 375, 297), meta=np.ndarray>
    ssh                  (year_period, y_dim, x_dim) float32 dask.array<chunksize=(1, 375, 297), meta=np.ndarray>
```

Data can be accessed by selecting on the year-period MultiIndex:
```python
# Selecting temperature data variable based on year:
clim_multiyear.sel(year_period=(2006))['temperature']

# Selecting temperature data variable based on year and period:
clim_multiyear.sel(year_period=(2006,'Dec-Feb'))['temperature']
```




