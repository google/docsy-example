---
title: "Example Page"
linkTitle: "Example Page"
date: 2017-01-05
description: >
  This page contains some cut and paste code-snippet examples to show what this
  package does.
---


## Load and inspect Data

Much of the capability leverages the excellent [xarray](http://xarray.pydata.org/en/stable/#) package. Following an import of the package. Load some data and inspect:

``` python
import coast
dir = '<path-to-files>'
sci = coast.NEMO()
sci.load(dir + 'AMM7_1d_20070101_20070131_25hourm_grid_T.nc',{'time_counter':10})

sci.dataset
```


### Multiple loads

Alternatively multiple files can be loaded simultaneously using wildcards:

``` python
sci.load_multiple(dir + 'AMM7_1d*nc', {'time_counter': 25})   
```


## Subsetting methods for data

To subsetting data there are methods to find the appropriate indices from the domain configuration data.

### Transects

Transects through data can be found using a method in the DOMAIN class to extract
the indices along a transect defined by end points in a grid.  

First load the domain configuration data:

``` python
# load domain data
dir = '<path-to-files>'
sci_dom = coast.DOMAIN()
sci_dom.load(dir+'domain_cfg.nc')
```
Then use the ``transect_indices`` method between defined lat-lon end points:
``` python
yt, xt, length_of_line = sci_dom.transect_indices([42,-3],[43,-2], grid_ref='t')
```
(For ``grid_ref`` any of the following is allowed: t,u,v,f. If missing ``t`` is assumed.)

Optionally visualize:
``` python
# Visualise
import numpy as np
import matplotlib.pyplot as plt
lon = np.array( sci_dom.dataset.nav_lon )
lat = np.array( sci_dom.dataset.nav_lat )
plt.plot( lon[yt,xt], lat[yt,xt], '.'); plt.show()
```

### Within a distance from a point

Alternatively indices can be sought in proximity to a defined point in lat-lon space:
``` python
# load domain data
dir = '<path-to-files>'
sci_dom = coast.DOMAIN()
sci_dom.load(dir+'domain_cfg.nc')

# Find indices for points with 111 km from 0E, 51N
ind = sci_dom.subset_indices_by_distance(0,51,111)
lon = np.array( sci_dom.dataset.nav_lon )
lat = np.array( sci_dom.dataset.nav_lat )

# Visualise
import matplotlib.pyplot as plt
plt.plot( lon[ind[0], ind[1]], lat[ind[0], ind[1]], '+'  )
plt.show()
```

## Extract the variable on the subset subset_indices

Then you have to extract the desired variable on the subset of indices. For example,
loading a single file and extracting temperature

``` python
import coast

dir = '<path-to-files>'
sci_dom = coast.DOMAIN()
sci = coast.NEMO()
sci_dom.load(dir+"domain_cfg.nc")
sci.load(dir+'AMM7_1d_20070101_20070131_25hourm_grid_T.nc', {'time_counter': 25})
yi,xi,line_len = sci_dom.transect_indices([51,-5],[49,-9], grid_ref='t')

# Extact the variable
data_t =  sci.get_subset_of_var("votemper",xi,yi)
```

or loading multiple files and extracting temperature

``` python
import coast

dir = '<path-to-files>'
sci_dom = coast.DOMAIN()
sci_multiple = coast.NEMO()
sci_dom.load(dir+"domain_cfg.nc")
sci_multiple.load_multiple(dir+"A*.nc", {'time_counter': 25})
yi,xi,line_len = sci_dom.transect_indices([51,-5],[49,-9], grid_ref='t')

# Extact the variable
data_multiple_t = sci_multiple.get_subset_of_var("votemper",xi,yi)
```

Or extracting velocity (on a different grid)
``` python
import coast

dir = '<path-to-files>'
sci_dom = coast.DOMAIN()
sci = coast.NEMO()
sci_dom.load(dir+"domain_cfg.nc")
sci.load(dir+'AMM7_1d_20070101_20070131_25hourm_grid_U.nc', {'time_counter': 25}) # load in a velocity dataset
yi,xi,line_len = sci_dom.transect_indices([51,-5],[49,-9], grid_ref='u') # Extract transect indices on u-pts

# Extract the variable
data_u = sci.get_subset_of_var("vozocrtx",xi,yi)
```

## Other stuff
Just a mo. Will probably put the extract a transect and plot example here.

## Continuous Ranked Probability Score (CRPS)
This is a basic script for running the CRPS function with the example NEMO data and Altimetry data. Altimetry data currently being read in using netCDF4 and cut out of global domain before being given to the routine.

```
import numpy as np
from netCDF4 import Dataset as ds
import xarray as xr
import coast

fn_dom = 'COAsT_example_NEMO_domain.nc'
fn_dat = 'COAsT_example_NEMO_data.nc'
fn_alt = 'COAsT_example_altimetry_data.nc'

nemo_dom = coast.DOMAIN()
nemo_var = coast.NEMO()
nemo_dom.load(fn_dom)
nemo_var.load(fn_dat)

# Read Altimetry data
ncalt = ds(fn_alt)
alt_lon = ncalt.variables['longitude'][:]
alt_lat = ncalt.variables['latitude'][:]
alt_ssh = ncalt.variables['sla_filtered'][:]
alt_time = ncalt.variables['time'][:]
ncalt.close()

# Convert altimetry times to datetime and adjust longitudes
alt_time = nemo_dom.num_to_date(alt_time, datetime.datetime(1950,1,1), alt_units = 'days')
alt_lon[alt_lon>180] = alt_lon[alt_lon>180] - 360

# Extract some altimetry data around the AMM7 domain
ind_box = nemo_dom.extract_lonlat_box(alt_lon, alt_lat, [-10,10],[45,65])
alt_lon = xr.DataArray( alt_lon[ind_box] )
alt_lat = xr.DataArray( alt_lat[ind_box] )
alt_time = xr.DataArray( alt_time[ind_box] )
alt_ssh = xr.DataArray( alt_ssh[ind_box] )

# Run CRPS for a small selection of the observations
crps_test = nemo_var.crps_sonf("sossheig", nemo_dom,
                       alt_lon[0:3], alt_lat[0:3], alt_ssh[0:3], alt_time[0:3],
                       plot=True, cdf_type = 'empirical', nh_type = 'radius')
```



```
This is the final element on the page and there should be no margin below this.
```
