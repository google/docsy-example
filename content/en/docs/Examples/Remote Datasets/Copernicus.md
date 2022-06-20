---
title: "Copernicus"
linkTitle: "Copernicus"
weight: 6

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
from coast import Copernicus


# Authenticate with Copernicus and select a database.
database = Copernicus(USERNAME, PASSWORD, "nrt")

# Instantiate a product with its ID
forecast = database.get_product("global-analysis-forecast-phy-001-024")

# Create a COAsT object with the relevant config file
nemo_t = coast.Gridded(fn_data=forecast, config="./config/example_cmems_grid_t.json")

# TODO: Do some sciency things with the dataset
```
