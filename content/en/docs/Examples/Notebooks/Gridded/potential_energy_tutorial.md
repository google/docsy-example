---
    title: "Potential energy tutorial"
    linkTitle: "Potential energy tutorial"
    weight: 5

    description: >
        Potential energy tutorial example.
---
A demonstration to calculate the Potential Energy Anomaly.


### Relevant imports and filepath configuration


```python
import coast
import numpy as np
import os
import matplotlib.pyplot as plt
import matplotlib.colors as colors  # colormap fiddling
```


```python
# set some paths
root = "./"
dn_files = root + "./example_files/"
fn_nemo_grid_t_dat = dn_files + "nemo_data_T_grid_Aug2015.nc"
fn_nemo_dom = dn_files + "coast_example_nemo_domain.nc"
config_t = root + "./config/example_nemo_grid_t.json"
config_w = root + "./config/example_nemo_grid_w.json"
```

### Loading data


```python
# Create a Gridded object and load in the data:
nemo_t = coast.Gridded(fn_nemo_grid_t_dat, fn_nemo_dom, config=config_t)
```

### Calculates Potential Energy Anomaly

The density and depth averaged density can be supplied within gridded_t as `density` and
`density_bar` DataArrays, respectively. If they are not supplied they will be calculated.
`density_bar` is calcuated using depth averages of temperature and salinity.




```python
# Compute a vertical max to exclude depths below 200m
Zd_mask, kmax, Ikmax = nemo_t.calculate_vertical_mask(200.)

# Initiate a stratification diagnostics object
IT = coast.InternalTide(nemo_t)
```


```python
# calculate PEA for unmasked depths
IT.calc_pea(nemo_t, Zd_mask)
```

### Plotting data

Finally we plot potential energy anomaly using an InternalTide method:


```python
IT.quick_plot('PEA')
```


    
![png](/COAsT/potential_energy_tutorial_files/potential_energy_tutorial_10_0.png)
    





    (<Figure size 1000x1000 with 2 Axes>,
     <AxesSubplot:title={'center':'01 Aug 2015: Potential Energy Anomaly (J / m^3)'}, xlabel='longitude', ylabel='latitude'>)




```python
IT.quick_plot()

```


    ---------------------------------------------------------------------------

    AttributeError                            Traceback (most recent call last)

    Cell In [7], line 1
    ----> 1 IT.quick_plot()


    File /usr/local/lib/python3.8/site-packages/coast/diagnostics/internal_tide.py:313, in InternalTide.quick_plot(self, var)
        310 debug(f"Generating quick plot for {get_slug(self)}")
        312 if var is None:
    --> 313     var_lst = [self.dataset.strat_1st_mom_masked, self.dataset.strat_2nd_mom_masked]
        314 else:
        315     var_lst = [self.dataset[var]]


    File /usr/local/lib/python3.8/site-packages/xarray/core/common.py:256, in AttrAccessMixin.__getattr__(self, name)
        254         with suppress(KeyError):
        255             return source[name]
    --> 256 raise AttributeError(
        257     f"{type(self).__name__!r} object has no attribute {name!r}"
        258 )


    AttributeError: 'Dataset' object has no attribute 'strat_1st_mom_masked'

