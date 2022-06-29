---
    title: "Amm15 example plot"
    linkTitle: "Amm15 example plot"
    weight: 5

    description: >
        Amm15 example plot example.
---
Make simple AMM15 SST plot.

### Import dependencies


```python
import coast
import matplotlib.pyplot as plt
```

### Load data


```python
config = "AMM15"
dir_nam = "/projectsa/NEMO/gmaya/2013p2/"
fil_nam = "20130415_25hourm_grid_T.nc"
dom_nam = "/projectsa/NEMO/gmaya/AMM15_GRID/amm15.mesh_mask.cs3x.nc"
config = "/work/jelt/GitHub/COAsT/config/example_nemo_grid_t.json"

sci_t = coast.Gridded(dir_nam + fil_nam, dom_nam, config=config)  # , chunks=chunks)
chunks = {
    "x_dim": 10,
    "y_dim": 10,
    "t_dim": 10,
}  # Chunks are prescribed in the config json file, but can be adjusted while the data is lazy loaded.

sci_t.dataset.chunk(chunks)

# create an empty w-grid object, to store stratification
sci_w = coast.Gridded(fn_domain=dom_nam, config=config.replace("t_nemo", "w_nemo"))
sci_w.dataset.chunk({"x_dim": 10, "y_dim": 10})  # Can reset after loading config json

print("* Loaded ", config, " data")
```

### Subset data and domain


```python
# Pick out a North Sea subdomain
print("* Extract North Sea subdomain")
ind_sci = sci_t.subset_indices(start=[51, -4], end=[62, 15])
sci_nwes_t = sci_t.isel(y_dim=ind_sci[0], x_dim=ind_sci[1])  # nwes = northwest europe shelf
ind_sci = sci_w.subset_indices(start=[51, -4], end=[62, 15])
sci_nwes_w = sci_w.isel(y_dim=ind_sci[0], x_dim=ind_sci[1])  # nwes = northwest europe shelf
```

### Mask data


```python
#%% Apply masks to temperature and salinity
if config == "AMM15":
    sci_nwes_t.dataset["temperature_m"] = sci_nwes_t.dataset.temperature.where(
        sci_nwes_t.dataset.mask.expand_dims(dim=sci_nwes_t.dataset["t_dim"].sizes) > 0
    )
    sci_nwes_t.dataset["salinity_m"] = sci_nwes_t.dataset.salinity.where(
        sci_nwes_t.dataset.mask.expand_dims(dim=sci_nwes_t.dataset["t_dim"].sizes) > 0
    )
else:
    # Apply fake masks to temperature and salinity
    sci_nwes_t.dataset["temperature_m"] = sci_nwes_t.dataset.temperature
    sci_nwes_t.dataset["salinity_m"] = sci_nwes_t.dataset.salinity
```

### Plot data


```python
#%% Plots
fig = plt.figure()

plt.pcolormesh(sci_t.dataset.longitude, sci_t.dataset.latitude, sci_t.dataset.temperature.isel(z_dim=0).squeeze())
plt.xlabel('longitude')
plt.ylabel('latitude')
plt.colorbar()
plt.axis("off")
plt.show()
```

### Save plot


```python
fig.savefig("AMM15_SST_nocolorbar.png", dpi=120)
```
