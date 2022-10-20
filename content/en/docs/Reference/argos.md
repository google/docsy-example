---
title: "Argos"
linkTitle: "Argos"
date: 2022-10-20
description: >
  Docstrings for the Argos class
---
### Objects

[Argos()](#argos)<br />
[Argos.read_data()](#argosread_data)<br />

Argos class
#### Argos()
```python
class Argos(Indexed):
```

```
Class for reading Argos CSV formatted data files into an xarray object
```

##### Argos.read_data()
```python

def Argos.read_data(self, file_path):
```
> <br />
> Read the data file<br />
> <br />
> Expected format and variable names are<br />
> <br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  DATIM,LAT,LON,SST,SST_F,PSST,PSST_F,PPRES,PPRES_F,BEN<br />
> <br />
> xarray dataset to have dimension as time and coordinates as time, latitude and longitude<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  file_path (str) : path of data file<br />
> <br />