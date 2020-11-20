---
title: "Configuration Gallery"
linkTitle: "Gallery"
date: 2020-09-15
weight: 20
description: >
  Example scripts and gallery for other NEMO configurations. Scripts from
  [example_scripts](https://github.com/British-Oceanographic-Data-Centre/COAsT/tree/master/example_scripts)
---

# AMM15 - 1.5km resolution Atlantic Margin Model

```python
"""
AMM15_example_plot.py

Make simple AMM15 SST plot.

"""

#%%
import coast
import numpy as np
import xarray as xr
import matplotlib.pyplot as plt
import matplotlib.colors as colors # colormap fiddling

#################################################
#%%  Loading  data
#################################################


config = 'AMM15'
dir_nam = "/projectsa/NEMO/gmaya/2013p2/"
fil_nam = "20130415_25hourm_grid_T.nc"
dom_nam = "/projectsa/NEMO/gmaya/AMM15_GRID/amm15.mesh_mask.cs3x.nc"



sci_t = coast.NEMO(dir_nam + fil_nam,
        dom_nam, grid_ref='t-grid', multiple=False)

# create an empty w-grid object, to store stratification
sci_w = coast.NEMO( fn_domain = dom_nam, grid_ref='w-grid')


print('* Loaded ',config, ' data')

#################################################
#%% subset of data and domain ##
#################################################
# Pick out a North Sea subdomain
print('* Extract North Sea subdomain')
ind_sci = sci_t.subset_indices([51,-4], [62,15])
sci_nwes_t = sci_t.isel(y_dim=ind_sci[0], x_dim=ind_sci[1]) #nwes = northwest europe shelf
ind_sci = sci_w.subset_indices([51,-4], [62,15])
sci_nwes_w = sci_w.isel(y_dim=ind_sci[0], x_dim=ind_sci[1]) #nwes = northwest europe shelf

#%% Apply masks to temperature and salinity
if config == 'AMM15':
    sci_nwes_t.dataset['temperature_m'] = sci_nwes_t.dataset.temperature.where( sci_nwes_t.dataset.mask.expand_dims(dim=sci_nwes_t.dataset['t_dim'].sizes) > 0)
    sci_nwes_t.dataset['salinity_m'] = sci_nwes_t.dataset.salinity.where( sci_nwes_t.dataset.mask.expand_dims(dim=sci_nwes_t.dataset['t_dim'].sizes) > 0)

else:
    # Apply fake masks to temperature and salinity
    sci_nwes_t.dataset['temperature_m'] = sci_nwes_t.dataset.temperature
    sci_nwes_t.dataset['salinity_m'] = sci_nwes_t.dataset.salinity



#%% Plots
fig = plt.figure()

plt.pcolormesh( sci_t.dataset.longitude, sci_t.dataset.latitude, sci_t.dataset.temperature.isel(z_dim=0).squeeze())
#plt.xlabel('longitude')
#plt.ylabel('latitude')
#plt.colorbar()
plt.axis('off')
plt.show()


fig.savefig('AMM15_SST_nocolorbar.png', dpi=120)

```
{{< imgproc AMM15_SST_nocolorbar Fit "600x700" >}}
{{< /imgproc >}}



# India subcontinent maritime domain. WCSSP India configuration

``` python
#%%
import coast
import numpy as np
import xarray as xr
import dask
import matplotlib.pyplot as plt
import matplotlib.colors as colors # colormap fiddling

#################################################
#%%  Loading  data
#################################################


dir_nam = "/projectsa/COAsT/NEMO_example_data/MO_INDIA/"
fil_nam = "ind_1d_cat_20180101_20180105_25hourm_grid_T.nc"
dom_nam = "domain_cfg_wcssp.nc"


sci_t = coast.NEMO(dir_nam + fil_nam, \
        dir_nam + dom_nam, grid_ref='t-grid', multiple=False)

#%% Plot
fig = plt.figure()

plt.pcolormesh( sci_t.dataset.longitude, sci_t.dataset.latitude, sci_t.dataset.temperature.isel(t_dim=0).isel(z_dim=0))
plt.xlabel('longitude')
plt.ylabel('latitude')
plt.title('WCSSP India SST')
plt.colorbar()
plt.show()
fig.savefig('WCSSP_India_SST.png', dpi=120)

```
{{< imgproc WCSSP_India_SST Fit "600x700" >}}
{{< /imgproc >}}



# South East Asia, 1/12 deg configuration (ACCORD: SEAsia_R12)

``` python
#%%
import coast
import numpy as np
import xarray as xr
import dask
import matplotlib.pyplot as plt
import matplotlib.colors as colors # colormap fiddling

#################################################
#%%  Loading  data
#################################################


dir_nam = "/projectsa/COAsT/NEMO_example_data/SEAsia_R12/"
fil_nam = "SEAsia_R12_5d_20120101_20121231_gridT.nc"
dom_nam = "domain_cfg_ORCA12_adj.nc"


sci_t = coast.NEMO(dir_nam + fil_nam, \
        dir_nam + dom_nam, grid_ref='t-grid', multiple=False)

#%% Plot
fig = plt.figure()

plt.pcolormesh( sci_t.dataset.longitude, sci_t.dataset.latitude, sci_t.dataset.soce.isel(t_dim=0).isel(z_dim=0))
plt.xlabel('longitude')
plt.ylabel('latitude')
plt.title('SE Asia, surface salinity (psu)')
plt.colorbar()
plt.show()
fig.savefig('SEAsia_R12_SSS.png', dpi=120)

```
{{< imgproc SEAsia_R12_SSS Fit "600x700" >}}
{{< /imgproc >}}
