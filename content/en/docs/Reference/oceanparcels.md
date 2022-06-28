---
title: "Oceanparcels"
linkTitle: "Oceanparcels"
date: 2022-06-28
description: >
  Docstrings for the Oceanparcels class
---
### Objects

[Oceanparcels()](#oceanparcels)<br />
[Oceanparcels.load_single()](#oceanparcelsload_single)<br />

Oceanparcels class for reading ocean parcels data.
#### Oceanparcels()
```python
class Oceanparcels(Lagrangian):
```

```
Reading ocean parcels data (netcdf format) into an xarray object.
```

##### Oceanparcels.load_single()
```python

def Oceanparcels.load_single(self, file_path):
```
> <br />
> Loads a single file into object's dataset variable.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  file_path (str): path to data file<br />
> <br />