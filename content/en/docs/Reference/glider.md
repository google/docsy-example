---
title: "Glider"
linkTitle: "Glider"
date: 2022-09-22
description: >
  Docstrings for the Glider class
---
### Objects

[Glider()](#glider)<br />
[Glider.load_single()](#gliderload_single)<br />

Glider class
#### Glider()
```python
class Glider(Indexed):
```

```
Glider class for reading in glider data (netcdf format) into an xarray object.
```

##### Glider.load_single()
```python

def Glider.load_single(self, file_path, chunks=None):
```
> <br />
> Loads a single file into object's dataset variable.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  file_path (str): path to data file<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  chunks (dict): chunks<br />
> <br />