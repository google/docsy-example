---
title: "Index"
linkTitle: "Index"
date: 2022-11-23
description: >
  Docstrings for the Index class
---
### Objects

[setup_dask_client()](#setup_dask_client)<br />
[Indexed()](#indexed)<br />
[Indexed.apply_config_mappings()](#indexedapply_config_mappings)<br />
[Indexed.insert_dataset()](#indexedinsert_dataset)<br />

Index class.
#### setup_dask_client()
```python

def setup_dask_client(workers=2, threads=2, memory_limit_per_worker=2GB):
```
> <br />
> None<br />
> <br />
#### Indexed()
```python
class Indexed(Coast):
```

```
None
```

##### Indexed.apply_config_mappings()
```python

def Indexed.apply_config_mappings(self):
```
> <br />
> Applies json configuration and mappings<br />
> <br />
##### Indexed.insert_dataset()
```python

def Indexed.insert_dataset(self, dataset, apply_config_mappings=False):
```
> <br />
> Insert a dataset straight into this object instance<br />
> <br />