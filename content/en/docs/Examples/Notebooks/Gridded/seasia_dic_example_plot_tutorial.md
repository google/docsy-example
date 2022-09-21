---
    title: "Seasia dic example plot tutorial"
    linkTitle: "Seasia dic example plot tutorial"
    weight: 5

    description: >
        Seasia dic example plot tutorial example.
---
Tutorial to make a simple SEAsia 1/12 deg DIC plot.

### Import the relevant packages


```python
import coast
import matplotlib.pyplot as plt
```

### Define file paths for data


```python
root = "./"
dn_files = root + "./example_files/"
path_config = root + "./config/"

fn_seasia_domain = dn_files + "coast_example_domain_SEAsia.nc"
fn_seasia_var = dn_files + "coast_example_SEAsia_BGC_1990.nc"
fn_seasia_config_bgc = path_config + "example_nemo_bgc.json"
```

### Create a Gridded object


```python
seasia_bgc = coast.Gridded(fn_data=fn_seasia_var, fn_domain=fn_seasia_domain, config=fn_seasia_config_bgc)
```

### Plot DIC


```python
fig = plt.figure()
plt.pcolormesh(
    seasia_bgc.dataset.longitude,
    seasia_bgc.dataset.latitude,
    seasia_bgc.dataset.dic.isel(t_dim=0).isel(z_dim=0),
    cmap="RdYlBu_r",
    vmin=1600,
    vmax=2080,
)
plt.colorbar()
plt.title("DIC, mmol/m^3")
plt.xlabel("longitude")
plt.ylabel("latitude")
plt.show()
```

    /tmp/ipykernel_3858/1161426776.py:2: UserWarning: The input coordinates to pcolormesh are interpreted as cell centers, but are not monotonically increasing or decreasing. This may lead to incorrectly calculated cell edges, in which case, please supply explicit cell edges to pcolormesh.
      plt.pcolormesh(



    
![png](/COAsT/seasia_dic_example_plot_tutorial_files/seasia_dic_example_plot_tutorial_8_1.png)
    



```python

```
