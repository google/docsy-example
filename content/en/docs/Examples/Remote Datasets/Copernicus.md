---
title: "Copernicus"
linkTitle: "Copernicus"
weight: 6
date: 2020-09-15
toc_hide: false
hide_summary: false
description: >
  Examples of access to Copernicus datasets via OPeNDAP.
---

Remote access to Copernicus Marine Environment Monitoring Service CMEMS datasets is enabled via [OPeNDAP](https://en.wikipedia.org/wiki/OPeNDAP) and [Pydap](https://github.com/pydap/pydap).

OPeNDAP allows COAsT to stream data from Copernicus without downloading specific subsets or the dataset as a whole.

In order to access CMEMS data, you must first [create an account](https://resources.marine.copernicus.eu/registration-form).

After you have created your account, or if you already have one, a product ID can be selected from the [product catalogue](https://resources.marine.copernicus.eu/products).

## Example
```python3
import coast

# Replace with your own credentials
username = "my_username"
password = "my_password"

# Authenticate with Copernicus and select a database.
database = coast.Copernicus(username, password, "nrt")

# Instantiate a product with its ID.
forecast = database.get_product("cmems_mod_glo_phy-thetao_anfc_0.083deg_PT6H-i")

# Create a COAsT object with the relevant config file.
nemo_t = coast.Gridded(fn_data=forecast, config="./config/example_cmems_grid_t.json")
```

Look inside the COAsT gridded object:
```
>>> nemo_t.dataset 
<xarray.Dataset>
Dimensions:      (x_dim: 4320, y_dim: 2041, z_dim: 50, t_dim: 4409)
Coordinates:
  * longitude    (x_dim) float32 -180.0 -179.9 -179.8 ... 179.8 179.8 179.9
  * latitude     (y_dim) float32 -80.0 -79.92 -79.83 -79.75 ... 89.83 89.92 90.0
  * z_dim        (z_dim) float32 0.494 1.541 2.646 ... 5.275e+03 5.728e+03
  * time         (t_dim) datetime64[ns] 2020-11-01 ... 2023-11-08
Dimensions without coordinates: x_dim, y_dim, t_dim
Data variables:
    temperature  (t_dim, z_dim, y_dim, x_dim) float32 dask.array<chunksize=(1, 50, 2041, 4320), meta=np.ndarray>
Attributes: (12/16)
    title:                         Instantaneous fields for product GLOBAL_AN...
    references:                    http://marine.copernicus.eu
    credit:                        E.U. Copernicus Marine Service Information...
    licence:                       http://marine.copernicus.eu/services-portf...
    contact:                       servicedesk.cmems@mercator-ocean.eu
    producer:                      CMEMS - Global Monitoring and Forecasting ...
    ...                            ...
    source:                        MERCATOR GLO12
    product_user_manual:           http://marine.copernicus.eu/documents/PUM/...
    quality_information_document:  http://marine.copernicus.eu/documents/QUID...
    compute_hosts:                 fidjim01-sihpc,fidjim02-sihpc,fidjim03-sih...
    n_workers:                     4
    sshcluster_timeout:            2700
```

View temperature data directly:
```
>>> nemo_t.dataset.temperature.isel(t_dim=1,z_dim=1)
<xarray.DataArray 'temperature' (y_dim: 2041, x_dim: 4320)>
dask.array<getitem, shape=(2041, 4320), dtype=float32, chunksize=(2041, 4320), chunktype=numpy.ndarray>
Coordinates:
  * longitude  (x_dim) float32 -180.0 -179.9 -179.8 -179.8 ... 179.8 179.8 179.9
  * latitude   (y_dim) float32 -80.0 -79.92 -79.83 -79.75 ... 89.83 89.92 90.0
    z_dim      float32 1.541
    time       datetime64[ns] 2020-11-01T06:00:00
Dimensions without coordinates: y_dim, x_dim
Attributes:
    long_name:      Temperature
    standard_name:  sea_water_potential_temperature
    units:          degrees_C
    unit_long:      Degrees Celsius
    valid_min:      -10
    valid_max:      40
    cell_methods:   area: mean
    _ChunkSizes:    [1, 6, 256, 540]

```

Or plot a snapshot of surface temperature (this loaded "lazily" from Copernicus so may take time to render):
```python3
import matplotlib.pyplot as plt
plt.pcolormesh(nemo_t.dataset.temperature.isel(t_dim=1,z_dim=1))
plt.show()
```
