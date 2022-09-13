---
    title: "Wod bgc ragged example"
    linkTitle: "Wod bgc ragged example"
    weight: 5

    description: >
        Wod bgc ragged example example.
---
An example of using COAsT to analysis observational profile data alongside gridded NEMO data. 

### Load modules


```python
import coast
import glob  # For getting file paths
import gsw
import matplotlib.pyplot as plt
import datetime
import numpy as np
import xarray as xr
import coast._utils.general_utils as general_utils
import scipy as sp

# ====================== UNIV PARAMS ===========================
path_examples = "./example_files/"
path_config = "./config/"
```

### load and preprocess profile and model data


```python
fn_wod_var = path_examples + "WOD_example_ragged_standard_level.nc"
fn_wod_config = path_config + "example_wod_profiles.json"

wod_profile_1d = coast.Profile(config=fn_wod_config)
wod_profile_1d.read_wod(fn_wod_var)
```

    ./config/example_wod_profiles.json


Reshape into 2D.
Choose which observed variables you want.


```python
var_user_want = ["salinity", "temperature", "nitrate", "oxygen", "dic", "phosphate", "alkalinity"]
wod_profile = coast.Profile.reshape_2d(wod_profile_1d, var_user_want)
```

    Depth OK reshape successful
    salinity
    observed variable exist
    OK reshape successful
    temperature
    observed variable exist
    OK reshape successful
    nitrate
    variable not in observations
    oxygen
    observed variable exist
    OK reshape successful
    dic
    observed variable exist
    OK reshape successful
    phosphate
    observed variable exist
    OK reshape successful
    alkalinity
    variable not in observations


Keep subset.


```python
wod_profile_sub = wod_profile.subset_indices_lonlat_box(lonbounds=[90, 120], latbounds=[-5, 5])

```


```python
#wod_profile_sub.dataset # uncomment to print data object summary
```

SEAsia read BGC.
Note in this simple test nemo data are only for 3 months from 1990 so the comparisons are not going to be correct but just as a demo.


```python
fn_seasia_domain = path_examples + "coast_example_domain_SEAsia.nc"
fn_seasia_config_bgc = path_config + "example_nemo_bgc.json"
fn_seasia_var = path_examples + "coast_example_SEAsia_BGC_1990.nc"

seasia_bgc = coast.Gridded(
    fn_data=fn_seasia_var, fn_domain=fn_seasia_domain, config=fn_seasia_config_bgc, multiple=True
)
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
      #005: H5Oattribute.c line 476 in H5O__attr_open_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #006: H5Adense.c line 394 in H5A__dense_open(): can't locate attribute in name index
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
      #005: H5Oattribute.c line 476 in H5O__attr_open_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #006: H5Adense.c line 394 in H5A__dense_open(): can't locate attribute in name index
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
      #005: H5Oattribute.c line 476 in H5O__attr_open_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #006: H5Adense.c line 394 in H5A__dense_open(): can't locate attribute in name index
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
      #005: H5Oattribute.c line 476 in H5O__attr_open_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #006: H5Adense.c line 394 in H5A__dense_open(): can't locate attribute in name index
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
      #005: H5Oattribute.c line 476 in H5O__attr_open_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #006: H5Adense.c line 394 in H5A__dense_open(): can't locate attribute in name index
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
      #005: H5Oattribute.c line 476 in H5O__attr_open_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #006: H5Adense.c line 394 in H5A__dense_open(): can't locate attribute in name index
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
      #005: H5Oattribute.c line 476 in H5O__attr_open_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #006: H5Adense.c line 394 in H5A__dense_open(): can't locate attribute in name index
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
      #005: H5Oattribute.c line 476 in H5O__attr_open_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #006: H5Adense.c line 394 in H5A__dense_open(): can't locate attribute in name index
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
      #005: H5Oattribute.c line 476 in H5O__attr_open_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #006: H5Adense.c line 394 in H5A__dense_open(): can't locate attribute in name index
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
      #005: H5Oattribute.c line 476 in H5O__attr_open_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #006: H5Adense.c line 394 in H5A__dense_open(): can't locate attribute in name index
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
      #005: H5Oattribute.c line 476 in H5O__attr_open_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #006: H5Adense.c line 394 in H5A__dense_open(): can't locate attribute in name index
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
      #005: H5Oattribute.c line 476 in H5O__attr_open_by_name(): can't open attribute
        major: Attribute
        minor: Can't open object
      #006: H5Adense.c line 394 in H5A__dense_open(): can't locate attribute in name index
        major: Attribute
        minor: Object not found


Domain file does not have mask so this is just a trick.


```python
seasia_bgc.dataset["landmask"] = seasia_bgc.dataset.bottom_level == 0
seasia_bgc.dataset = seasia_bgc.dataset.rename({"depth_0": "depth"})
model_profiles = wod_profile_sub.obs_operator(seasia_bgc)
#model_profiles.dataset # uncomment to print data object summary
```

Remove any points that are far from model.


```python
too_far = 5
keep_indices = model_profiles.dataset.interp_dist <= too_far
model_profiles = model_profiles.isel(id_dim=keep_indices)
wod_profile = wod_profile_sub.isel(id_dim=keep_indices)
```


```python
#wod_profile.dataset # uncomment to print data object summary
```

### Plot profiles
Transform observed DIC from mmol/l to mmol C/ m^3 that the model has.


```python
fig = plt.figure()
plt.plot(1000 * wod_profile.dataset.dic[8, :], wod_profile.dataset.depth[8, :], linestyle="", marker="o")
plt.plot(model_profiles.dataset.dic[8, :], model_profiles.dataset.depth[:, 8], linestyle="", marker="o")
plt.ylim([2500, 0])
plt.title("DIC vs depth")
plt.show()

fig = plt.figure()
plt.plot(wod_profile.dataset.oxygen[8, :], wod_profile.dataset.depth[8, :], linestyle="", marker="o")
plt.plot(model_profiles.dataset.oxygen[8, :], model_profiles.dataset.depth[:, 8], linestyle="", marker="o")
plt.ylim([2500, 0])
plt.title("Oxygen vs depth")
plt.show()
```


    
![png](/COAsT/wod_bgc_ragged_example_files/wod_bgc_ragged_example_17_0.png)
    



    
![png](/COAsT/wod_bgc_ragged_example_files/wod_bgc_ragged_example_17_1.png)
    


### Perform profile analysis to evaluate differences
Interpolate seasia to profile depths, using `ProfileAnalysis` class.


```python
reference_depths = wod_profile.dataset.depth[20, :].values
model_profiles.dataset = model_profiles.dataset[["dic"]] / 1000

pa = coast.ProfileAnalysis()
model_interpolated = pa.interpolate_vertical(model_profiles, wod_profile)
```

Calculate differences.


```python
differences = pa.difference(model_interpolated, wod_profile)
#differences.dataset.load() # uncomment to print data object summary
```


```python

```