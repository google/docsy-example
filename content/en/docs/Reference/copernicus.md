---
title: "Copernicus"
linkTitle: "Copernicus"
date: 2022-06-28
description: >
  Docstrings for the Copernicus class
---
### Objects

[CopernicusBase()](#copernicusbase)<br />
[CopernicusBase.get_url()](#copernicusbaseget_url)<br />
[Product()](#product)<br />
[Product.from_copernicus()](#productfrom_copernicus)<br />
[Copernicus()](#copernicus)<br />
[Copernicus.get_product()](#copernicusget_product)<br />

Functionality for accessing Copernicus datasets via OPeNDAP.
#### CopernicusBase()
```python
class CopernicusBase():
```

```
Information required for accessing Copernicus datasets via OPeNDAP.
```

##### CopernicusBase.get_url()
```python

def CopernicusBase.get_url(self, product_id):
```
> <br />
> Get the URL required to access a Copernicus OPeNDAP dataset.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  product_id: The product ID belonging to the chosen dataset.<br />
> <br />
> <b>Returns:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  The constructed URL.<br />
> <br />
#### Product()
```python
class Product(OpendapInfo):
```

```
Information required to access and stream data from a Copernicus product.
```

##### Product.from_copernicus()
```python
@classmethod
def Product.from_copernicus(cls, product_id, copernicus):
```
> <br />
> Instantiate a Product using Copernicus information and a specific product ID.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  product_id: The product ID of the chosen Copernicus OPeNDAP dataset.<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  copernicus: A previously instantiated Copernicus info object.<br />
> <br />
> <b>Returns:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  An instantiated Product accessor.<br />
> <br />
#### Copernicus()
```python
class Copernicus(CopernicusBase):
```

```
An object for accessing Copernicus products via OPeNDAP.
```

##### Copernicus.get_product()
```python

def Copernicus.get_product(self, product_id):
```
> <br />
> Instantiate a Product related to a specific product ID.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  product_id: The product ID of the chosen Copernicus OPeNDAP dataset.<br />
> <br />
> <b>Returns:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  The instantiated Product accessor.<br />
> <br />