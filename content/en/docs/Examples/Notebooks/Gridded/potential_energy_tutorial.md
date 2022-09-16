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
strat = coast.GriddedStratification(nemo_t)
```


```python
# calculate PEA for unmasked depths
strat.calc_pea(nemo_t, Zd_mask)
```

## make a plot


```python
strat.quick_plot('PEA')
```


    
![png](/COAsT/potential_energy_tutorial_files/potential_energy_tutorial_10_0.png)
    





    (<Figure size 1000x1000 with 2 Axes>,
     <AxesSubplot: title={'center': '01 Aug 2015: Potential Energy Anomaly (J / m^3)'}, xlabel='longitude', ylabel='latitude'>)




```python

```
