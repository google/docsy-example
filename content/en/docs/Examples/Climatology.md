---
title: "Climatology"
linkTitle: "Climatology"
weight: 5

description: >
  Example useage of CLIMATOLOGY object.
---


This is a demonstration script for using the CLIMATOLOGY object in the COAsT
package. This object has methods for analysing climatological data. Further examples can be found in the [COAsT github](https://github.com/British-Oceanographic-Data-Centre/COAsT/blob/master/example_scripts/climatology_example.py) repository.


# Climatological means
This section shows and example of how to use the ``CLIMATOLOGY.make_climatology()`` method to calculates mean over a given period of time. This method doesn't take different years into account, unless using the 'years' frequency. (See the [Multi-year climatological means](#multi-year-climatological-means) section for multi-yeared data.)

Begin by importing coast:
```python
import coast
```

And by defining some file paths for the data:
```python
# Path to a data file.
fn_nemo_data = "/path/to/Nemo/data.nc"
# Set path for domain file if required.
fn_nemo_domain = "/path/to/domain/domain.nc"

# Read in data (This example uses NEMO data.)
nemo_data = coast.NEMO(fn_data=fn_nemo_data, fn_domain=fn_nemo_domain, chunks={}).dataset
```

Calculate the climatology:
```python
# Optional (This specifies an output file path.)
fn_out = "/path/to/outputfile.nc" 
# String is appended to "time." to create a valid xarray time period. (i.e. time.season, time.month...)
climatology_frequency = "month" 

clim = coast.CLIMATOLOGY()

# Not writing output to file:
clim_mean = clim.make_climatology(nemo_data, climatology_frequency)
# Writing output to file (may require a large amount of memory.)
clim_mean = clim.make_climatology(nemo_data, climatology_frequency, fn_out=fn_out)
```

Below shows the structure of a dataset returned, containing 3 months worth of meaned data:
```
<xarray.Dataset>
Dimensions:      (y_dim: 1345, x_dim: 1458, z_dim: 51, month: 3)
Coordinates:
    nav_lat      (y_dim, x_dim) float32 dask.array<chunksize=(1345, 1458), meta=np.ndarray>
    nav_lon      (y_dim, x_dim) float32 dask.array<chunksize=(1345, 1458), meta=np.ndarray>
    deptht       (z_dim) float32 3.038 9.367 16.1 ... 5.618e+03 5.822e+03
  * month        (month) int64 1 2 3
Dimensions without coordinates: y_dim, x_dim, z_dim
Data variables:
    temperature  (month, z_dim, y_dim, x_dim) float32 dask.array<chunksize=(1, 51, 1345, 1458), meta=np.ndarray>
    ssh          (month, y_dim, x_dim) float32 dask.array<chunksize=(1, 1345, 1458), meta=np.ndarray>
    salinity     (month, z_dim, y_dim, x_dim) float32 dask.array<chunksize=(1, 51, 1345, 1458), meta=np.ndarray>
```


# Multi-year climatological means
This section shows an example of how to use the ``CLIMATOLOGY.multiyear_averages()`` method to generate annual averages across specified periods of time. This method is designed to be compatible with multi-year datasets, but will work with single year datasets too.

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

# Read in multiyear data (This example uses NEMO data from multiple datafiles.)
nemo_data = coast.NEMO(fn_data=fn_nemo_data, fn_domain=fn_nemo_domain, multiple=True, chunks={}).dataset
```

Now calculate means of each season across multiple years for specified data:
```python
clim = coast.CLIMATOLOGY()
# Using seasons module to specify time period.
# SPRING, SUMMER, AUTUMN, WINTER, ALL are valid values for seasons.
clim_multiyear = clim.multiyear_averages(data, seasons.ALL, time_var='time', time_dim='t_dim')

# Or explicitly defining specific month periods.
# A list of tuples defining start and end month integers. The start months should be in chronological order.
month_periods = [(6,8), (12,2)] # Specifies June -> August and December -> February for each year of data.
clim_multiyear = clim.multiyear_averages(data, month_periods , time_var='time', time_dim='t_dim')

```

Below shows the structure of a dataset returned from this method:
```
<xarray.Dataset>
Dimensions:              (y_dim: 1345, x_dim: 1458, z_dim: 51, year_period: 3)
Coordinates:
    nav_lat              (y_dim, x_dim) float32 dask.array<chunksize=(1345, 1458), meta=np.ndarray>
    nav_lon              (y_dim, x_dim) float32 dask.array<chunksize=(1345, 1458), meta=np.ndarray>
    deptht               (z_dim) float32 3.038 9.367 ... 5.618e+03 5.822e+03
  * year_period          (year_period) MultiIndex
  - year_period_level_0  (year_period) int64 2004 2005 2005
  - year_period_level_1  (year_period) object 'Dec-Feb' 'Mar-May' 'Dec-Feb'
Dimensions without coordinates: y_dim, x_dim, z_dim
Data variables:
    temperature          (year_period, z_dim, y_dim, x_dim) float32 dask.array<chunksize=(1, 51, 1345, 1458), meta=np.ndarray>
    ssh                  (year_period, y_dim, x_dim) float32 dask.array<chunksize=(1, 1345, 1458), meta=np.ndarray>
    salinity             (year_period, z_dim, y_dim, x_dim) float32 dask.array<chunksize=(1, 51, 1345, 1458), meta=np.ndarray>
done
```

Data can be accessed by selecting on the year-period MultiIndex:
```python
# Selecting salinity data variable based on year:
clim_multiyear.sel(year_period=(2004))['salinity']

# Selecting salinity data variable based on year and period:
clim_multiyear.sel(year_period=(2004,'Dec-Feb'))['salinity']
```




