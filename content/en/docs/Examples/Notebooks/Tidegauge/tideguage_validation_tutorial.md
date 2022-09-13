---
    title: "Tideguage validation tutorial"
    linkTitle: "Tideguage validation tutorial"
    weight: 5

    description: >
        Tideguage validation tutorial example.
---
This script gives an overview of some of validation tools available when
using the TidegaugeMultiple object in COAsT.

For this a script, a premade netcdf file containing tide gauge data is used.

### Import necessary libraries



```python
import xarray as xr
import numpy as np
import coast
import datetime
```

### Define paths



```python
fn_dom = "<PATH_TO_NEMO_DOMAIN>"
fn_dat = "<PATH_TO_NEMO_DATA>"
fn_config = "<PATH_TO_CONFIG.json>"
fn_tg = "<PATH_TO_TIDEGAUGE_NETCDF>"  # This should already be processed, on the same time dimension

# Change this to 0 to not use default files.
if 1:
    print(f"Use default files")
    dir = "./example_files/"
    fn_dom = dir + "coast_example_nemo_domain.nc"
    fn_dat = dir + "coast_example_nemo_data.nc"
    fn_config = "./config/example_nemo_grid_t.json"
    fn_tg = dir + "tg_amm15.nc"
```

    Use default files


### Create gridded object and load data


```python
nemo = coast.Gridded(fn_dat, fn_dom, multiple=True, config=fn_config)

# Create a landmask array and put it into the nemo object.
# Here, using the bottom_level == 0 variable from the domain file is enough.
nemo.dataset["landmask"] = nemo.dataset.bottom_level == 0

# Rename depth_0 to be depth
nemo.dataset = nemo.dataset.rename({"depth_0": "depth"})
nemo.dataset = nemo.dataset[["ssh", "landmask"]]
```

    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitGroomNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeGranularBitRoundNumberOfSignificantDigits'
        major: Attribute
        minor: Object not found
    HDF5-DIAG: Error detected in HDF5 (1.12.2) thread 1:
      #000: H5A.c line 528 in H5Aopen_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #001: H5VLcallback.c line 1091 in H5VL_attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #002: H5VLcallback.c line 1058 in H5VL__attr_open(): attribute open failed
        major: Virtual Object Layer
        minor: Can't open object
      #003: H5VLnative_attr.c line 130 in H5VL__native_attr_open(): can't open attribute
        major: Attribute
        minor: Can't open object
      #004: H5Aint.c line 545 in H5A__open_by_name(): unable to load attribute info from object header
        major: Attribute
        minor: Unable to initialize object
      #005: H5Oattribute.c line 494 in H5O__attr_open_by_name(): can't locate attribute: '_QuantizeBitRoundNumberOfSignificantBits'
        major: Attribute
        minor: Object not found


### Create TidegaugeMultiple object



```python

# Create the object and then inset the netcdf dataset
obs = coast.Tidegauge(dataset=xr.open_dataset(fn_tg))
obs.dataset = obs.dataset.set_coords("time")

# Shift the timestamp so it overlaps with the tidegauge data - Not ideal but this is only a demo
obs.dataset.coords["time"] = obs.dataset.coords["time"] + 1000000000 * 3600 * 24 * 365 * 3

# Cut down data to be only in 2018 to match model data.
start_date = datetime.datetime(2007, 1, 1)
end_date = datetime.datetime(2007, 1, 31)
obs = obs.time_slice(start_date, end_date)
```


    ---------------------------------------------------------------------------

    KeyError                                  Traceback (most recent call last)

    File /usr/local/lib/python3.8/site-packages/xarray/backends/file_manager.py:201, in CachingFileManager._acquire_with_cache_info(self, needs_lock)
        200 try:
    --> 201     file = self._cache[self._key]
        202 except KeyError:


    File /usr/local/lib/python3.8/site-packages/xarray/backends/lru_cache.py:55, in LRUCache.__getitem__(self, key)
         54 with self._lock:
    ---> 55     value = self._cache[key]
         56     self._cache.move_to_end(key)


    KeyError: [<class 'netCDF4._netCDF4.Dataset'>, ('/example_scripts/notebooks/runnable_notebooks/example_files/tg_amm15.nc',), 'r', (('clobber', True), ('diskless', False), ('format', 'NETCDF4'), ('persist', False))]

    
    During handling of the above exception, another exception occurred:


    FileNotFoundError                         Traceback (most recent call last)

    Cell In [4], line 2
          1 # Create the object and then inset the netcdf dataset
    ----> 2 obs = coast.Tidegauge(dataset=xr.open_dataset(fn_tg))
          3 obs.dataset = obs.dataset.set_coords("time")
          5 # Shift the timestamp so it overlaps with the tidegauge data - Not ideal but this is only a demo


    File /usr/local/lib/python3.8/site-packages/xarray/backends/api.py:531, in open_dataset(filename_or_obj, engine, chunks, cache, decode_cf, mask_and_scale, decode_times, decode_timedelta, use_cftime, concat_characters, decode_coords, drop_variables, inline_array, backend_kwargs, **kwargs)
        519 decoders = _resolve_decoders_kwargs(
        520     decode_cf,
        521     open_backend_dataset_parameters=backend.open_dataset_parameters,
       (...)
        527     decode_coords=decode_coords,
        528 )
        530 overwrite_encoded_chunks = kwargs.pop("overwrite_encoded_chunks", None)
    --> 531 backend_ds = backend.open_dataset(
        532     filename_or_obj,
        533     drop_variables=drop_variables,
        534     **decoders,
        535     **kwargs,
        536 )
        537 ds = _dataset_from_backend_dataset(
        538     backend_ds,
        539     filename_or_obj,
       (...)
        547     **kwargs,
        548 )
        549 return ds


    File /usr/local/lib/python3.8/site-packages/xarray/backends/netCDF4_.py:555, in NetCDF4BackendEntrypoint.open_dataset(self, filename_or_obj, mask_and_scale, decode_times, concat_characters, decode_coords, drop_variables, use_cftime, decode_timedelta, group, mode, format, clobber, diskless, persist, lock, autoclose)
        534 def open_dataset(
        535     self,
        536     filename_or_obj,
       (...)
        551     autoclose=False,
        552 ):
        554     filename_or_obj = _normalize_path(filename_or_obj)
    --> 555     store = NetCDF4DataStore.open(
        556         filename_or_obj,
        557         mode=mode,
        558         format=format,
        559         group=group,
        560         clobber=clobber,
        561         diskless=diskless,
        562         persist=persist,
        563         lock=lock,
        564         autoclose=autoclose,
        565     )
        567     store_entrypoint = StoreBackendEntrypoint()
        568     with close_on_error(store):


    File /usr/local/lib/python3.8/site-packages/xarray/backends/netCDF4_.py:384, in NetCDF4DataStore.open(cls, filename, mode, format, group, clobber, diskless, persist, lock, lock_maker, autoclose)
        378 kwargs = dict(
        379     clobber=clobber, diskless=diskless, persist=persist, format=format
        380 )
        381 manager = CachingFileManager(
        382     netCDF4.Dataset, filename, mode=mode, kwargs=kwargs
        383 )
    --> 384 return cls(manager, group=group, mode=mode, lock=lock, autoclose=autoclose)


    File /usr/local/lib/python3.8/site-packages/xarray/backends/netCDF4_.py:332, in NetCDF4DataStore.__init__(self, manager, group, mode, lock, autoclose)
        330 self._group = group
        331 self._mode = mode
    --> 332 self.format = self.ds.data_model
        333 self._filename = self.ds.filepath()
        334 self.is_remote = is_remote_uri(self._filename)


    File /usr/local/lib/python3.8/site-packages/xarray/backends/netCDF4_.py:393, in NetCDF4DataStore.ds(self)
        391 @property
        392 def ds(self):
    --> 393     return self._acquire()


    File /usr/local/lib/python3.8/site-packages/xarray/backends/netCDF4_.py:387, in NetCDF4DataStore._acquire(self, needs_lock)
        386 def _acquire(self, needs_lock=True):
    --> 387     with self._manager.acquire_context(needs_lock) as root:
        388         ds = _nc4_require_group(root, self._group, self._mode)
        389     return ds


    File /usr/local/lib/python3.8/contextlib.py:113, in _GeneratorContextManager.__enter__(self)
        111 del self.args, self.kwds, self.func
        112 try:
    --> 113     return next(self.gen)
        114 except StopIteration:
        115     raise RuntimeError("generator didn't yield") from None


    File /usr/local/lib/python3.8/site-packages/xarray/backends/file_manager.py:189, in CachingFileManager.acquire_context(self, needs_lock)
        186 @contextlib.contextmanager
        187 def acquire_context(self, needs_lock=True):
        188     """Context manager for acquiring a file."""
    --> 189     file, cached = self._acquire_with_cache_info(needs_lock)
        190     try:
        191         yield file


    File /usr/local/lib/python3.8/site-packages/xarray/backends/file_manager.py:207, in CachingFileManager._acquire_with_cache_info(self, needs_lock)
        205     kwargs = kwargs.copy()
        206     kwargs["mode"] = self._mode
    --> 207 file = self._opener(*self._args, **kwargs)
        208 if self._mode == "w":
        209     # ensure file doesn't get overridden when opened again
        210     self._mode = "a"


    File src/netCDF4/_netCDF4.pyx:2353, in netCDF4._netCDF4.Dataset.__init__()


    File src/netCDF4/_netCDF4.pyx:1963, in netCDF4._netCDF4._ensure_nc_success()


    FileNotFoundError: [Errno 2] No such file or directory: b'/example_scripts/notebooks/runnable_notebooks/example_files/tg_amm15.nc'


### Interpolate model data onto obs locations


```python
model_timeseries = obs.obs_operator(nemo)

# In this case, transpose the interpolated dataset
model_timeseries.dataset = model_timeseries.dataset.transpose()
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    Cell In [5], line 1
    ----> 1 model_timeseries = obs.obs_operator(nemo)
          3 # In this case, transpose the interpolated dataset
          4 model_timeseries.dataset = model_timeseries.dataset.transpose()


    NameError: name 'obs' is not defined


### Do some processing


```python
# This routine searches for missing values in each dataset and applies them
# equally to each corresponding dataset
tganalysis = coast.TidegaugeAnalysis()
obs_new, model_new = tganalysis.match_missing_values(obs.dataset.ssh, model_timeseries.dataset.ssh)

# Subtract means from all time series
obs_new = tganalysis.demean_timeseries(obs_new.dataset)
model_new = tganalysis.demean_timeseries(model_new.dataset)

# Now you have equivalent and comparable sets of time series that can be
# easily compared.
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    Cell In [6], line 4
          1 # This routine searches for missing values in each dataset and applies them
          2 # equally to each corresponding dataset
          3 tganalysis = coast.TidegaugeAnalysis()
    ----> 4 obs_new, model_new = tganalysis.match_missing_values(obs.dataset.ssh, model_timeseries.dataset.ssh)
          6 # Subtract means from all time series
          7 obs_new = tganalysis.demean_timeseries(obs_new.dataset)


    NameError: name 'obs' is not defined


## Calculate non tidal residuals



### First, do a harmonic analysis. This routine uses utide



```python
ha_mod = tganalysis.harmonic_analysis_utide(model_new.dataset.ssh, min_datapoints=1)
ha_obs = tganalysis.harmonic_analysis_utide(obs_new.dataset.ssh, min_datapoints=1)

```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    Cell In [7], line 1
    ----> 1 ha_mod = tganalysis.harmonic_analysis_utide(model_new.dataset.ssh, min_datapoints=1)
          2 ha_obs = tganalysis.harmonic_analysis_utide(obs_new.dataset.ssh, min_datapoints=1)


    NameError: name 'model_new' is not defined



### Create new TidegaugeMultiple objects containing reconstructed tides



```python
tide_mod = tganalysis.reconstruct_tide_utide(model_new.dataset.time, ha_mod)
tide_obs = tganalysis.reconstruct_tide_utide(obs_new.dataset.time, ha_obs)

```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    Cell In [8], line 1
    ----> 1 tide_mod = tganalysis.reconstruct_tide_utide(model_new.dataset.time, ha_mod)
          2 tide_obs = tganalysis.reconstruct_tide_utide(obs_new.dataset.time, ha_obs)


    NameError: name 'model_new' is not defined



### Get new TidegaugeMultiple objects containing non tidal residuals.



```python
ntr_mod = tganalysis.calculate_non_tidal_residuals(model_new.dataset.ssh, tide_mod.dataset.reconstructed)
ntr_obs = tganalysis.calculate_non_tidal_residuals(obs_new.dataset.ssh, tide_obs.dataset.reconstructed)

```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    Cell In [9], line 1
    ----> 1 ntr_mod = tganalysis.calculate_non_tidal_residuals(model_new.dataset.ssh, tide_mod.dataset.reconstructed)
          2 ntr_obs = tganalysis.calculate_non_tidal_residuals(obs_new.dataset.ssh, tide_obs.dataset.reconstructed)


    NameError: name 'model_new' is not defined



### Other applications

Other applications here included only reconstructing specified tidal frequency bands and validating this.

#### Calculate errors

The difference() routine will calculate differences, absolute_differences and squared differenced for all variables:


```python
ntr_diff = tganalysis.difference(ntr_obs.dataset, ntr_mod.dataset)
ssh_diff = tganalysis.difference(obs_new.dataset, model_new.dataset)

# We can then easily get mean errors, MAE and MSE
mean_stats = ntr_diff.dataset.mean(dim="t_dim", skipna=True)
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    Cell In [10], line 1
    ----> 1 ntr_diff = tganalysis.difference(ntr_obs.dataset, ntr_mod.dataset)
          2 ssh_diff = tganalysis.difference(obs_new.dataset, model_new.dataset)
          4 # We can then easily get mean errors, MAE and MSE


    NameError: name 'ntr_obs' is not defined


#### Threshold Statistics for Non-tidal residuals

This is a simple extreme value analysis of whatever data you use. It will count the number of peaks and the total time spent over each threshold provided. It will also count the numbers of daily and monthly maxima over each threshold



```python
thresh_mod = tganalysis.threshold_statistics(ntr_mod.dataset, thresholds=np.arange(0, 2, 0.2))
thresh_obs = tganalysis.threshold_statistics(ntr_obs.dataset, thresholds=np.arange(0, 2, 0.2))
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    Cell In [11], line 1
    ----> 1 thresh_mod = tganalysis.threshold_statistics(ntr_mod.dataset, thresholds=np.arange(0, 2, 0.2))
          2 thresh_obs = tganalysis.threshold_statistics(ntr_obs.dataset, thresholds=np.arange(0, 2, 0.2))


    NameError: name 'ntr_mod' is not defined



```python

```
