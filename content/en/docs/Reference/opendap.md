---
title: "Opendap"
linkTitle: "Opendap"
date: 2022-09-22
description: >
  Docstrings for the Opendap class
---
### Objects

[OpendapInfo()](#opendapinfo)<br />
[OpendapInfo.get_store()](#opendapinfoget_store)<br />
[OpendapInfo.open_dataset()](#opendapinfoopen_dataset)<br />
[OpendapInfo.from_cas()](#opendapinfofrom_cas)<br />

Functionality for accessing OPeNDAP datasets.
#### OpendapInfo()
```python
class OpendapInfo():
```

```
A class for accessing streamable OPeNDAP data.
```

##### OpendapInfo.get_store()
```python

def OpendapInfo.get_store(self):
```
> <br />
> Access an OPeNDAP data store.<br />
> <br />
> <b>Returns:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  The OPeNDAP data store accessed from the instance's URL.<br />
> <br />
##### OpendapInfo.open_dataset()
```python

def OpendapInfo.open_dataset(self, chunks=None):
```
> <br />
> Open the remote XArray dataset for streaming.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  chunks: Chunks to use in Dask.<br />
> <br />
> <b>Returns:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  The opened XArray dataset.<br />
> <br />
##### OpendapInfo.from_cas()
```python
@classmethod
def OpendapInfo.from_cas(cls, url, cas_url, username, password):
```
> <br />
> Instantiate OpendapInfo with a session authenticated against CAS.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  url: The OPeNDAP dataset URL.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  cas_url: The CAS login URL.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  username: The username to authenticate with.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  password: The password to authenticate with.<br />
> <br />
> <b>Returns:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  The instantiated OPeNDAP accessor.<br />
> <br />