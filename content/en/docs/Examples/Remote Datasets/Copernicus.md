---
title: "Copernicus"
linkTitle: "Copernicus"
weight: 6
date: 2020-09-15
description: >
  Examples of access to Copernicus datasets via OPeNDAP.
---

# Intro
Remote access to Copernicus Marine Environment Monitoring Service CMEMS datasets is enabled via [OPeNDAP](https://en.wikipedia.org/wiki/OPeNDAP) and [Pydap](https://github.com/pydap/pydap).

OPeNDAP allows COAsT to stream data from Copernicus without downloading specific subsets or the dataset as a whole.

In order to access CMEMS data, you must first [create an account](https://resources.marine.copernicus.eu/registration-form).

After you have created your account, or if you already have one, a product ID can be selected from the [product catalogue](https://resources.marine.copernicus.eu/products).

# Example
```python
import coast


# Authenticate with Copernicus and select a database.
database = coast.Copernicus(USERNAME, PASSWORD, "nrt")

# Instantiate a product with its ID
forecast = database.get_product("global-analysis-forecast-phy-001-024")

# Create a COAsT object with the relevant config file
nemo_t = coast.Gridded(fn_data=forecast, config="./config/example_cmems_grid_t.json")
```
Look inside the COAsT gridded object: `nemo_t.dataset`

```
<xarray.Dataset>
Dimensions:      (x_dim: 4320, y_dim: 2041, z_dim: 50, t_dim: 912)
Coordinates:
    longitude    (x_dim) float32 -180.0 -179.9 -179.8 ... 179.8 179.8 179.9
    latitude     (y_dim) float32 -80.0 -79.92 -79.83 -79.75 ... 89.83 89.92 90.0
  * z_dim        (z_dim) float32 0.494 1.541 2.646 ... 5.275e+03 5.728e+03
    time         (t_dim) datetime64[ns] 2020-01-01T12:00:00 ... 2022-06-30T12...
Dimensions without coordinates: x_dim, y_dim, t_dim
Data variables:
    mlotst       (t_dim, y_dim, x_dim) float32 dask.array<chunksize=(1, 2041, 4320), meta=np.ndarray>
    ssh          (t_dim, y_dim, x_dim) float32 dask.array<chunksize=(1, 2041, 4320), meta=np.ndarray>
    bottomT      (t_dim, y_dim, x_dim) float32 dask.array<chunksize=(1, 2041, 4320), meta=np.ndarray>
    sithick      (t_dim, y_dim, x_dim) float32 dask.array<chunksize=(1, 2041, 4320), meta=np.ndarray>
    siconc       (t_dim, y_dim, x_dim) float32 dask.array<chunksize=(1, 2041, 4320), meta=np.ndarray>
    usi          (t_dim, y_dim, x_dim) float32 dask.array<chunksize=(1, 2041, 4320), meta=np.ndarray>
    vsi          (t_dim, y_dim, x_dim) float32 dask.array<chunksize=(1, 2041, 4320), meta=np.ndarray>
    temperature  (t_dim, z_dim, y_dim, x_dim) float32 dask.array<chunksize=(1, 50, 2041, 4320), meta=np.ndarray>
    salinity     (t_dim, z_dim, y_dim, x_dim) float32 dask.array<chunksize=(1, 50, 2041, 4320), meta=np.ndarray>
    uo           (t_dim, z_dim, y_dim, x_dim) float32 dask.array<chunksize=(1, 50, 2041, 4320), meta=np.ndarray>
    vo           (t_dim, z_dim, y_dim, x_dim) float32 dask.array<chunksize=(1, 50, 2041, 4320), meta=np.ndarray>
Attributes: (12/24)
    title:              daily mean fields from Global Ocean Physics Analysis ...
    easting:            longitude
    northing:           latitude
    history:            2022/06/21 00:05:41 MERCATOR OCEAN Netcdf creation
    source:             MERCATOR PSY4QV3R1
    institution:        MERCATOR OCEAN
                ...
    longitude_min:      -180.0
    longitude_max:      179.91667
    latitude_min:       -80.0
    latitude_max:       90.0
    z_min:              0.494025
    z_max:              5727.917
```

Or plot a snapshot of surface temperature. (This lazy loaded so may take time to render)

```
import matplotlib.pyplot as plt
plt.pcolormesh( nemo_t.dataset.temperature.isel(t_dim=1,z_dim=1))
plt.show()
```
