---
    title: "Mask maker tutorial"
    linkTitle: "Mask maker tutorial"
    weight: 5

    description: >
        Mask maker tutorial example.
---
A demonstration of the MaskMaker class to build and use regional masking

MaskMasker is a class of methods to assist with making regional masks within COAsT.
Presently the mask generated are external to MaskMaker.
Masks are constructed as gridded boolean numpy array for each region, which are stacked over a dim_mask dimension. 
The mask arrays are generated on a supplied horizontal grid. The masks are then stored in xarray objects along with regions names.

Examples are given working with Gridded and Profile data.

### Relevant imports and filepath configuration


```python
import coast
import numpy as np
from os import path
import matplotlib.pyplot as plt
import matplotlib.colors as colors  # colormap fiddling
import xarray as xr
```

    /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/pydap/lib.py:5: DeprecationWarning: pkg_resources is deprecated as an API. See https://setuptools.pypa.io/en/latest/pkg_resources.html
    /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/pkg_resources/__init__.py:2871: DeprecationWarning: Deprecated call to `pkg_resources.declare_namespace('pydap')`.
    Implementing implicit namespace packages (as specified in PEP 420) is preferred to `pkg_resources.declare_namespace`. See https://setuptools.pypa.io/en/latest/references/keywords.html#keyword-namespace-packages
    /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/pkg_resources/__init__.py:2871: DeprecationWarning: Deprecated call to `pkg_resources.declare_namespace('pydap.responses')`.
    Implementing implicit namespace packages (as specified in PEP 420) is preferred to `pkg_resources.declare_namespace`. See https://setuptools.pypa.io/en/latest/references/keywords.html#keyword-namespace-packages
    /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/pkg_resources/__init__.py:2350: DeprecationWarning: Deprecated call to `pkg_resources.declare_namespace('pydap')`.
    Implementing implicit namespace packages (as specified in PEP 420) is preferred to `pkg_resources.declare_namespace`. See https://setuptools.pypa.io/en/latest/references/keywords.html#keyword-namespace-packages
    /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/pkg_resources/__init__.py:2871: DeprecationWarning: Deprecated call to `pkg_resources.declare_namespace('pydap.handlers')`.
    Implementing implicit namespace packages (as specified in PEP 420) is preferred to `pkg_resources.declare_namespace`. See https://setuptools.pypa.io/en/latest/references/keywords.html#keyword-namespace-packages
    /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/pkg_resources/__init__.py:2350: DeprecationWarning: Deprecated call to `pkg_resources.declare_namespace('pydap')`.
    Implementing implicit namespace packages (as specified in PEP 420) is preferred to `pkg_resources.declare_namespace`. See https://setuptools.pypa.io/en/latest/references/keywords.html#keyword-namespace-packages
    /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/pkg_resources/__init__.py:2871: DeprecationWarning: Deprecated call to `pkg_resources.declare_namespace('pydap.tests')`.
    Implementing implicit namespace packages (as specified in PEP 420) is preferred to `pkg_resources.declare_namespace`. See https://setuptools.pypa.io/en/latest/references/keywords.html#keyword-namespace-packages
    /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/pkg_resources/__init__.py:2350: DeprecationWarning: Deprecated call to `pkg_resources.declare_namespace('pydap')`.
    Implementing implicit namespace packages (as specified in PEP 420) is preferred to `pkg_resources.declare_namespace`. See https://setuptools.pypa.io/en/latest/references/keywords.html#keyword-namespace-packages
    /usr/share/miniconda/envs/coast/lib/python3.10/site-packages/pkg_resources/__init__.py:2871: DeprecationWarning: Deprecated call to `pkg_resources.declare_namespace('sphinxcontrib')`.
    Implementing implicit namespace packages (as specified in PEP 420) is preferred to `pkg_resources.declare_namespace`. See https://setuptools.pypa.io/en/latest/references/keywords.html#keyword-namespace-packages



```python
# set some paths
root = "./"
dn_files = root + "./example_files/"
fn_nemo_grid_t_dat = dn_files + "nemo_data_T_grid_Aug2015.nc"
fn_nemo_dom = dn_files + "coast_example_nemo_domain.nc"
config_t = root + "./config/example_nemo_grid_t.json"
```

### Loading data


```python
# Create a Gridded object and load in the data:
nemo = coast.Gridded(fn_nemo_grid_t_dat, fn_nemo_dom, config=config_t)
```

# Initialise MaskMaker and define target grid



```python
mm = coast.MaskMaker()

# Define Regional Masks
regional_masks = []

# Define convenient aliases based on nemo data
lon = nemo.dataset.longitude.values
lat = nemo.dataset.latitude.values
bathy = nemo.dataset.bathymetry.values

```

# Use MaskMaker to define new regions

MaskMaker can build a stack of boolean masks in an xarray dataset for regional analysis. Regions can be supplied by providing vertices coordiates to the `make_region_from_vertices` method. (Vertices coordinates can be passed as xarray objects or as numpy arrays).
The method returns a numpy array of booleans.


```python
# Draw and fill a square
vertices_lon = [-5, -5, 5, 5]
vertices_lat = [40, 60, 60, 40]

# input lat/lon as xr.DataArray
filled1 = mm.make_region_from_vertices(nemo.dataset.longitude, nemo.dataset.latitude, vertices_lon, vertices_lat)
# input lat/lon as np.ndarray
filled2 = mm.make_region_from_vertices(
    nemo.dataset.longitude.values, nemo.dataset.latitude.values, vertices_lon, vertices_lat
)

check = (filled1 == filled2).all()
print(f"numpy array outputs are the same? {check}")
```

    numpy array outputs are the same? True


The boolean numpy array can then be converted to an xarray object using `make_mask_dataset()` for improved interactions with other xarray objects. 


```python
mask_xr = mm.make_mask_dataset(nemo.dataset.longitude.values, nemo.dataset.latitude.values, filled1)
```

# Use MaskMaker for predefined regions

The NWS has a number of predefined regions. These are numpy boolean arrays as functions of the specified latitude, longitude and bathymetry. They can be appended into a list of arrays, which can be similarly converted into an xarray object.


```python
masks_list = []

# Add regional mask for whole domain
masks_list.append(np.ones(lon.shape))

# Add regional mask for English Channel
masks_list.append(mm.region_def_nws_north_north_sea(lon, lat, bathy))
masks_list.append(mm.region_def_nws_south_north_sea(lon, lat, bathy))
masks_list.append(mm.region_def_nws_outer_shelf(lon, lat, bathy))
masks_list.append(mm.region_def_nws_norwegian_trench(lon, lat, bathy))
masks_list.append(mm.region_def_nws_english_channel(lon, lat, bathy))
masks_list.append(mm.region_def_nws_off_shelf(lon, lat, bathy))
masks_list.append(mm.region_def_nws_irish_sea(lon, lat, bathy))
masks_list.append(mm.region_def_nws_kattegat(lon, lat, bathy))
masks_list.append(mm.region_def_nws_fsc(lon, lat, bathy))

masks_names = ["whole domain", "northern north sea", "southern north sea", "outer shelf",
               "norwegian trench", "english_channel",  "off shelf",
                "irish sea", "kattegat", "fsc"]
```

As before the numpy arrays (here as a list) can be converted into an xarray dataset where each mask is separated along the `dim_mask` dimension


```python
mask_xr = mm.make_mask_dataset(lon, lat, masks_list, masks_names)
```

Inspect mask xarray object structure

``mask_xr``

## Plot masks

Inspect the mask with a `quick_plot()` method.


```python
mm.quick_plot(mask_xr)

```


    
![png](/COAsT/mask_maker_tutorial_files/mask_maker_tutorial_18_0.png)
    


NB overlapping regions are not given special treatment, the layers are blindly superimposed on each other. E.g. as demonstrated with "Norwegian Trench" and "off shelf", "FSC" and "off shelf", or "whole domain" and any other region.


```python
plt.subplot(2,2,1)
mm.quick_plot(mask_xr.sel(dim_mask=[0,3,9]))

plt.subplot(2,2,2)
mm.quick_plot(mask_xr.sel(dim_mask=[1,2,4,5,6,7,8]))

plt.tight_layout()
```


    
![png](/COAsT/mask_maker_tutorial_files/mask_maker_tutorial_20_0.png)
    



```python
# Show overlap
mask_xr.mask.sum(dim='dim_mask').plot(levels=(1,2,3,4))

# Save if required
#plt.savefig('tmp.png')
```




    <matplotlib.collections.QuadMesh at 0x7fe58f3b8c10>




    
![png](/COAsT/mask_maker_tutorial_files/mask_maker_tutorial_21_1.png)
    


# Regional analysis with Profile data

Apply the regional masks to average SST


```python
# Read EN4 data into profile object
fn_prof = path.join(dn_files, "coast_example_en4_201008.nc")
fn_cfg_prof = path.join("config","example_en4_profiles.json")
profile = coast.Profile(config=fn_cfg_prof)
profile.read_en4( fn_prof )

```

    config/example_en4_profiles.json


Then we use `ProfileAnalysis.determine_mask_indices()` to figure out which profiles in a Profile object lie within each regional mask:


```python
analysis = coast.ProfileAnalysis()
mask_indices = analysis.determine_mask_indices(profile, mask_xr)
```

This returns an object called `mask_indices`, which is required to pass to `ProfileAnalysis.mask_means()`. This routine will return a new xarray dataset containing averaged data for each region:


```python
profile_mask_means = analysis.mask_means(profile, mask_indices)
```

This routine operates over all variables in the `profile` object. It calculates means by region preserving depth information (`profile_mean_*`) and also averaging over depth information (`all_mean_*`). The variables are returned with these prefixes accordingly. 


```python
profile_mask_means
```




<div><svg style="position: absolute; width: 0; height: 0; overflow: hidden">
<defs>
<symbol id="icon-database" viewBox="0 0 32 32">
<path d="M16 0c-8.837 0-16 2.239-16 5v4c0 2.761 7.163 5 16 5s16-2.239 16-5v-4c0-2.761-7.163-5-16-5z"></path>
<path d="M16 17c-8.837 0-16-2.239-16-5v6c0 2.761 7.163 5 16 5s16-2.239 16-5v-6c0 2.761-7.163 5-16 5z"></path>
<path d="M16 26c-8.837 0-16-2.239-16-5v6c0 2.761 7.163 5 16 5s16-2.239 16-5v-6c0 2.761-7.163 5-16 5z"></path>
</symbol>
<symbol id="icon-file-text2" viewBox="0 0 32 32">
<path d="M28.681 7.159c-0.694-0.947-1.662-2.053-2.724-3.116s-2.169-2.030-3.116-2.724c-1.612-1.182-2.393-1.319-2.841-1.319h-15.5c-1.378 0-2.5 1.121-2.5 2.5v27c0 1.378 1.122 2.5 2.5 2.5h23c1.378 0 2.5-1.122 2.5-2.5v-19.5c0-0.448-0.137-1.23-1.319-2.841zM24.543 5.457c0.959 0.959 1.712 1.825 2.268 2.543h-4.811v-4.811c0.718 0.556 1.584 1.309 2.543 2.268zM28 29.5c0 0.271-0.229 0.5-0.5 0.5h-23c-0.271 0-0.5-0.229-0.5-0.5v-27c0-0.271 0.229-0.5 0.5-0.5 0 0 15.499-0 15.5 0v7c0 0.552 0.448 1 1 1h7v19.5z"></path>
<path d="M23 26h-14c-0.552 0-1-0.448-1-1s0.448-1 1-1h14c0.552 0 1 0.448 1 1s-0.448 1-1 1z"></path>
<path d="M23 22h-14c-0.552 0-1-0.448-1-1s0.448-1 1-1h14c0.552 0 1 0.448 1 1s-0.448 1-1 1z"></path>
<path d="M23 18h-14c-0.552 0-1-0.448-1-1s0.448-1 1-1h14c0.552 0 1 0.448 1 1s-0.448 1-1 1z"></path>
</symbol>
</defs>
</svg>
<style>/* CSS stylesheet for displaying xarray objects in jupyterlab.
 *
 */

:root {
  --xr-font-color0: var(--jp-content-font-color0, rgba(0, 0, 0, 1));
  --xr-font-color2: var(--jp-content-font-color2, rgba(0, 0, 0, 0.54));
  --xr-font-color3: var(--jp-content-font-color3, rgba(0, 0, 0, 0.38));
  --xr-border-color: var(--jp-border-color2, #e0e0e0);
  --xr-disabled-color: var(--jp-layout-color3, #bdbdbd);
  --xr-background-color: var(--jp-layout-color0, white);
  --xr-background-color-row-even: var(--jp-layout-color1, white);
  --xr-background-color-row-odd: var(--jp-layout-color2, #eeeeee);
}

html[theme=dark],
body[data-theme=dark],
body.vscode-dark {
  --xr-font-color0: rgba(255, 255, 255, 1);
  --xr-font-color2: rgba(255, 255, 255, 0.54);
  --xr-font-color3: rgba(255, 255, 255, 0.38);
  --xr-border-color: #1F1F1F;
  --xr-disabled-color: #515151;
  --xr-background-color: #111111;
  --xr-background-color-row-even: #111111;
  --xr-background-color-row-odd: #313131;
}

.xr-wrap {
  display: block !important;
  min-width: 300px;
  max-width: 700px;
}

.xr-text-repr-fallback {
  /* fallback to plain text repr when CSS is not injected (untrusted notebook) */
  display: none;
}

.xr-header {
  padding-top: 6px;
  padding-bottom: 6px;
  margin-bottom: 4px;
  border-bottom: solid 1px var(--xr-border-color);
}

.xr-header > div,
.xr-header > ul {
  display: inline;
  margin-top: 0;
  margin-bottom: 0;
}

.xr-obj-type,
.xr-array-name {
  margin-left: 2px;
  margin-right: 10px;
}

.xr-obj-type {
  color: var(--xr-font-color2);
}

.xr-sections {
  padding-left: 0 !important;
  display: grid;
  grid-template-columns: 150px auto auto 1fr 20px 20px;
}

.xr-section-item {
  display: contents;
}

.xr-section-item input {
  display: none;
}

.xr-section-item input + label {
  color: var(--xr-disabled-color);
}

.xr-section-item input:enabled + label {
  cursor: pointer;
  color: var(--xr-font-color2);
}

.xr-section-item input:enabled + label:hover {
  color: var(--xr-font-color0);
}

.xr-section-summary {
  grid-column: 1;
  color: var(--xr-font-color2);
  font-weight: 500;
}

.xr-section-summary > span {
  display: inline-block;
  padding-left: 0.5em;
}

.xr-section-summary-in:disabled + label {
  color: var(--xr-font-color2);
}

.xr-section-summary-in + label:before {
  display: inline-block;
  content: '►';
  font-size: 11px;
  width: 15px;
  text-align: center;
}

.xr-section-summary-in:disabled + label:before {
  color: var(--xr-disabled-color);
}

.xr-section-summary-in:checked + label:before {
  content: '▼';
}

.xr-section-summary-in:checked + label > span {
  display: none;
}

.xr-section-summary,
.xr-section-inline-details {
  padding-top: 4px;
  padding-bottom: 4px;
}

.xr-section-inline-details {
  grid-column: 2 / -1;
}

.xr-section-details {
  display: none;
  grid-column: 1 / -1;
  margin-bottom: 5px;
}

.xr-section-summary-in:checked ~ .xr-section-details {
  display: contents;
}

.xr-array-wrap {
  grid-column: 1 / -1;
  display: grid;
  grid-template-columns: 20px auto;
}

.xr-array-wrap > label {
  grid-column: 1;
  vertical-align: top;
}

.xr-preview {
  color: var(--xr-font-color3);
}

.xr-array-preview,
.xr-array-data {
  padding: 0 5px !important;
  grid-column: 2;
}

.xr-array-data,
.xr-array-in:checked ~ .xr-array-preview {
  display: none;
}

.xr-array-in:checked ~ .xr-array-data,
.xr-array-preview {
  display: inline-block;
}

.xr-dim-list {
  display: inline-block !important;
  list-style: none;
  padding: 0 !important;
  margin: 0;
}

.xr-dim-list li {
  display: inline-block;
  padding: 0;
  margin: 0;
}

.xr-dim-list:before {
  content: '(';
}

.xr-dim-list:after {
  content: ')';
}

.xr-dim-list li:not(:last-child):after {
  content: ',';
  padding-right: 5px;
}

.xr-has-index {
  font-weight: bold;
}

.xr-var-list,
.xr-var-item {
  display: contents;
}

.xr-var-item > div,
.xr-var-item label,
.xr-var-item > .xr-var-name span {
  background-color: var(--xr-background-color-row-even);
  margin-bottom: 0;
}

.xr-var-item > .xr-var-name:hover span {
  padding-right: 5px;
}

.xr-var-list > li:nth-child(odd) > div,
.xr-var-list > li:nth-child(odd) > label,
.xr-var-list > li:nth-child(odd) > .xr-var-name span {
  background-color: var(--xr-background-color-row-odd);
}

.xr-var-name {
  grid-column: 1;
}

.xr-var-dims {
  grid-column: 2;
}

.xr-var-dtype {
  grid-column: 3;
  text-align: right;
  color: var(--xr-font-color2);
}

.xr-var-preview {
  grid-column: 4;
}

.xr-index-preview {
  grid-column: 2 / 5;
  color: var(--xr-font-color2);
}

.xr-var-name,
.xr-var-dims,
.xr-var-dtype,
.xr-preview,
.xr-attrs dt {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  padding-right: 10px;
}

.xr-var-name:hover,
.xr-var-dims:hover,
.xr-var-dtype:hover,
.xr-attrs dt:hover {
  overflow: visible;
  width: auto;
  z-index: 1;
}

.xr-var-attrs,
.xr-var-data,
.xr-index-data {
  display: none;
  background-color: var(--xr-background-color) !important;
  padding-bottom: 5px !important;
}

.xr-var-attrs-in:checked ~ .xr-var-attrs,
.xr-var-data-in:checked ~ .xr-var-data,
.xr-index-data-in:checked ~ .xr-index-data {
  display: block;
}

.xr-var-data > table {
  float: right;
}

.xr-var-name span,
.xr-var-data,
.xr-index-name div,
.xr-index-data,
.xr-attrs {
  padding-left: 25px !important;
}

.xr-attrs,
.xr-var-attrs,
.xr-var-data,
.xr-index-data {
  grid-column: 1 / -1;
}

dl.xr-attrs {
  padding: 0;
  margin: 0;
  display: grid;
  grid-template-columns: 125px auto;
}

.xr-attrs dt,
.xr-attrs dd {
  padding: 0;
  margin: 0;
  float: left;
  padding-right: 10px;
  width: auto;
}

.xr-attrs dt {
  font-weight: normal;
  grid-column: 1;
}

.xr-attrs dt:hover span {
  display: inline-block;
  background: var(--xr-background-color);
  padding-right: 10px;
}

.xr-attrs dd {
  grid-column: 2;
  white-space: pre-wrap;
  word-break: break-all;
}

.xr-icon-database,
.xr-icon-file-text2,
.xr-no-icon {
  display: inline-block;
  vertical-align: middle;
  width: 1em;
  height: 1.5em !important;
  stroke-width: 0;
  stroke: currentColor;
  fill: currentColor;
}
</style><pre class='xr-text-repr-fallback'>&lt;xarray.Dataset&gt;
Dimensions:                             (dim_mask: 8, z_dim: 400)
Coordinates:
    region_names                        (dim_mask) &lt;U18 &#x27;whole domain&#x27; ... &#x27;k...
Dimensions without coordinates: dim_mask, z_dim
Data variables:
    profile_mean_depth                  (dim_mask, z_dim) float32 3.802 ... nan
    profile_mean_potential_temperature  (dim_mask, z_dim) float32 4.629 ... nan
    profile_mean_temperature            (dim_mask, z_dim) float32 4.629 ... nan
    profile_mean_practical_salinity     (dim_mask, z_dim) float32 29.08 ... nan
    profile_mean_qc_flags_profiles      (dim_mask) float64 4.422e+05 ... 1.93...
    profile_mean_qc_flags_levels        (dim_mask, z_dim) float64 1.693e+07 ....
    all_mean_depth                      (dim_mask) float32 219.3 48.17 ... 86.48
    all_mean_potential_temperature      (dim_mask) float32 7.458 6.68 ... 7.266
    all_mean_temperature                (dim_mask) float32 7.48 6.685 ... 7.275
    all_mean_practical_salinity         (dim_mask) float32 34.57 34.86 ... 33.76
    all_mean_qc_flags_profiles          (dim_mask) float64 4.422e+05 ... 1.93...
    all_mean_qc_flags_levels            (dim_mask) float64 3.272e+07 ... 3.68...</pre><div class='xr-wrap' style='display:none'><div class='xr-header'><div class='xr-obj-type'>xarray.Dataset</div></div><ul class='xr-sections'><li class='xr-section-item'><input id='section-3703c5ee-7301-41a1-b605-427b04cd0dd7' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-3703c5ee-7301-41a1-b605-427b04cd0dd7' class='xr-section-summary'  title='Expand/collapse section'>Dimensions:</label><div class='xr-section-inline-details'><ul class='xr-dim-list'><li><span>dim_mask</span>: 8</li><li><span>z_dim</span>: 400</li></ul></div><div class='xr-section-details'></div></li><li class='xr-section-item'><input id='section-2c876d97-f780-4716-be27-8f726e446f45' class='xr-section-summary-in' type='checkbox'  checked><label for='section-2c876d97-f780-4716-be27-8f726e446f45' class='xr-section-summary' >Coordinates: <span>(1)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-var-name'><span>region_names</span></div><div class='xr-var-dims'>(dim_mask)</div><div class='xr-var-dtype'>&lt;U18</div><div class='xr-var-preview xr-preview'>&#x27;whole domain&#x27; ... &#x27;kattegat&#x27;</div><input id='attrs-cfc4fdf7-1546-4d4c-860a-4da5dcd298c5' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-cfc4fdf7-1546-4d4c-860a-4da5dcd298c5' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-ea0ebbd6-2752-433c-9032-16d5735bbd7a' class='xr-var-data-in' type='checkbox'><label for='data-ea0ebbd6-2752-433c-9032-16d5735bbd7a' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([&#x27;whole domain&#x27;, &#x27;northern north sea&#x27;, &#x27;southern north sea&#x27;,
       &#x27;outer shelf&#x27;, &#x27;norwegian trench&#x27;, &#x27;english_channel&#x27;, &#x27;off shelf&#x27;,
       &#x27;kattegat&#x27;], dtype=&#x27;&lt;U18&#x27;)</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-532bb424-5333-41ba-a93c-ad0588532864' class='xr-section-summary-in' type='checkbox'  checked><label for='section-532bb424-5333-41ba-a93c-ad0588532864' class='xr-section-summary' >Data variables: <span>(12)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'><li class='xr-var-item'><div class='xr-var-name'><span>profile_mean_depth</span></div><div class='xr-var-dims'>(dim_mask, z_dim)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>3.802 12.43 12.75 ... nan nan nan</div><input id='attrs-e934426c-5f83-4c76-8a2a-b8de5e12c70f' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-e934426c-5f83-4c76-8a2a-b8de5e12c70f' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-d16a1c3c-5ead-4f01-b4de-d4ff8322ee2e' class='xr-var-data-in' type='checkbox'><label for='data-d16a1c3c-5ead-4f01-b4de-d4ff8322ee2e' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[3.8015647e+00, 1.2431897e+01, 1.2752748e+01, ..., 6.8166663e+02,
        4.4625000e+02, 4.8479999e+02],
       [5.3978572e+00, 2.4058212e+01, 1.9938543e+01, ...,           nan,
                  nan,           nan],
       [4.4636950e+00, 1.6393627e+01, 1.4392214e+01, ...,           nan,
                  nan,           nan],
       ...,
       [1.2563381e+00, 3.3999999e+00, 6.0253515e+00, ...,           nan,
                  nan,           nan],
       [1.0883763e+01, 1.9575655e+01, 3.1419313e+01, ..., 1.1761000e+03,
                  nan,           nan],
       [1.1508474e+00, 5.1322031e+00, 8.6844826e+00, ...,           nan,
                  nan,           nan]], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>profile_mean_potential_temperature</span></div><div class='xr-var-dims'>(dim_mask, z_dim)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>4.629 4.718 4.732 ... nan nan nan</div><input id='attrs-74c68f9d-fefd-4138-a5e8-361a601cf945' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-74c68f9d-fefd-4138-a5e8-361a601cf945' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-e2bc3a77-35b3-4f2d-8128-64522d6407d2' class='xr-var-data-in' type='checkbox'><label for='data-e2bc3a77-35b3-4f2d-8128-64522d6407d2' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[ 4.629049  ,  4.7177176 ,  4.7318735 , ...,  4.4791145 ,
         7.0863085 ,  7.4710603 ],
       [ 5.4062243 ,  5.538929  ,  5.3454785 , ...,         nan,
                nan,         nan],
       [ 4.690185  ,  4.7648296 ,  4.290611  , ...,         nan,
                nan,         nan],
       ...,
       [ 7.777337  ,  7.743324  ,  7.730106  , ...,         nan,
                nan,         nan],
       [10.741058  , 10.7420845 , 10.740048  , ..., -0.8672274 ,
                nan,         nan],
       [ 0.6519121 ,  0.89932823,  1.4384961 , ...,         nan,
                nan,         nan]], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>profile_mean_temperature</span></div><div class='xr-var-dims'>(dim_mask, z_dim)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>4.629 4.719 4.733 ... nan nan nan</div><input id='attrs-28b42199-8a6a-40fc-80c1-8eaaad43bbac' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-28b42199-8a6a-40fc-80c1-8eaaad43bbac' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-9bda1fcd-8603-4e0b-8958-fd1224de86af' class='xr-var-data-in' type='checkbox'><label for='data-9bda1fcd-8603-4e0b-8958-fd1224de86af' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[ 4.629366  ,  4.7186904 ,  4.7328353 , ...,  4.523333  ,
         7.13      ,  7.52      ],
       [ 5.4066286 ,  5.540855  ,  5.3469286 , ...,         nan,
                nan,         nan],
       [ 4.69051   ,  4.76605   ,  4.291559  , ...,         nan,
                nan,         nan],
       ...,
       [ 7.777464  ,  7.7436633 ,  7.7307053 , ...,         nan,
                nan,         nan],
       [10.742379  , 10.744476  , 10.743904  , ..., -0.82      ,
                nan,         nan],
       [ 0.6519491 ,  0.89944816,  1.4387244 , ...,         nan,
                nan,         nan]], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>profile_mean_practical_salinity</span></div><div class='xr-var-dims'>(dim_mask, z_dim)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>29.08 29.49 30.4 ... nan nan nan</div><input id='attrs-86280ccf-c18e-49e4-99e4-896e7d6d7d08' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-86280ccf-c18e-49e4-99e4-896e7d6d7d08' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-5825021a-1bd6-4109-bd61-101bbc7211b5' class='xr-var-data-in' type='checkbox'><label for='data-5825021a-1bd6-4109-bd61-101bbc7211b5' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[29.07752 , 29.488913, 30.403212, ..., 35.102665, 35.194   ,
        35.191   ],
       [34.215603, 34.549515, 34.572178, ...,       nan,       nan,
              nan],
       [34.39857 , 34.319733, 34.34744 , ...,       nan,       nan,
              nan],
       ...,
       [34.69485 , 34.745506, 34.778313, ...,       nan,       nan,
              nan],
       [35.41276 , 35.531857, 35.523746, ..., 34.912   ,       nan,
              nan],
       [22.681366, 23.651918, 24.719212, ...,       nan,       nan,
              nan]], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>profile_mean_qc_flags_profiles</span></div><div class='xr-var-dims'>(dim_mask)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>4.422e+05 1.501e+04 ... 1.93e+06</div><input id='attrs-10843ee0-37cb-49a9-aad8-8a87e06eef39' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-10843ee0-37cb-49a9-aad8-8a87e06eef39' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-b851747e-4722-401b-ac74-a2cf4a9cacba' class='xr-var-data-in' type='checkbox'><label for='data-b851747e-4722-401b-ac74-a2cf4a9cacba' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([ 442235.24343675,   15008.98928571,   80146.01273885,
        376662.06666667,  938649.58108108,  236414.92957746,
        351245.56410256, 1930156.61016949])</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>profile_mean_qc_flags_levels</span></div><div class='xr-var-dims'>(dim_mask, z_dim)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>1.693e+07 1.56e+07 ... 3.356e+07</div><input id='attrs-85a2f60c-35df-4b31-a22a-8b6ebe92e3d2' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-85a2f60c-35df-4b31-a22a-8b6ebe92e3d2' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-0538ec06-babe-45b4-9763-2e411fa9e6df' class='xr-var-data-in' type='checkbox'><label for='data-0538ec06-babe-45b4-9763-2e411fa9e6df' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([[1.69308660e+07, 1.55996508e+07, 1.91944702e+07, ...,
        3.35092258e+07, 3.35359264e+07, 3.35359264e+07],
       [2.41202110e+06, 1.67795573e+06, 1.43838659e+07, ...,
        3.35626270e+07, 3.35626270e+07, 3.35626270e+07],
       [7.82982090e+06, 9.03196737e+06, 2.22584483e+07, ...,
        3.35626270e+07, 3.35626270e+07, 3.35626270e+07],
       ...,
       [1.43590767e+07, 1.24096114e+07, 1.32338878e+07, ...,
        3.35626270e+07, 3.35626270e+07, 3.35626270e+07],
       [2.49180806e+06, 2.49194591e+06, 1.91836366e+06, ...,
        3.32757669e+07, 3.35626270e+07, 3.35626270e+07],
       [1.07067776e+08, 1.03513576e+08, 9.04351003e+07, ...,
        3.35626270e+07, 3.35626270e+07, 3.35626270e+07]])</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>all_mean_depth</span></div><div class='xr-var-dims'>(dim_mask)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>219.3 48.17 17.66 ... 492.1 86.48</div><input id='attrs-e01b332f-9e23-42ea-a6cc-e027301d76b2' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-e01b332f-9e23-42ea-a6cc-e027301d76b2' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-8f00a797-e481-4f72-8e64-44b18c19c210' class='xr-var-data-in' type='checkbox'><label for='data-8f00a797-e481-4f72-8e64-44b18c19c210' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([219.31877 ,  48.17008 ,  17.655499,  54.261852, 147.37276 ,
        21.17876 , 492.1379  ,  86.48219 ], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>all_mean_potential_temperature</span></div><div class='xr-var-dims'>(dim_mask)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>7.458 6.68 5.08 ... 8.609 7.266</div><input id='attrs-f3b468b2-6ee1-45fb-b57a-773a31ce2ede' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-f3b468b2-6ee1-45fb-b57a-773a31ce2ede' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-2d0d9a05-401f-4794-8ba3-4a8376a3d109' class='xr-var-data-in' type='checkbox'><label for='data-2d0d9a05-401f-4794-8ba3-4a8376a3d109' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([ 7.4579477,  6.6803527,  5.0804653, 10.605105 ,  7.5581946,
        7.9912376,  8.609107 ,  7.266073 ], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>all_mean_temperature</span></div><div class='xr-var-dims'>(dim_mask)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>7.48 6.685 5.082 ... 8.658 7.275</div><input id='attrs-23562e1c-c265-4697-80b2-b7e727041d75' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-23562e1c-c265-4697-80b2-b7e727041d75' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-99659869-8264-493d-bee5-b8c22dc30ea5' class='xr-var-data-in' type='checkbox'><label for='data-99659869-8264-493d-bee5-b8c22dc30ea5' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([ 7.479547 ,  6.684928 ,  5.0818586, 10.611826 ,  7.572891 ,
        7.993422 ,  8.657866 ,  7.2747602], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>all_mean_practical_salinity</span></div><div class='xr-var-dims'>(dim_mask)</div><div class='xr-var-dtype'>float32</div><div class='xr-var-preview xr-preview'>34.57 34.86 34.49 ... 35.33 33.76</div><input id='attrs-624c1485-1572-447d-bee0-030c87db3b21' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-624c1485-1572-447d-bee0-030c87db3b21' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-11a289cc-8615-4202-a93a-c07b8c74df28' class='xr-var-data-in' type='checkbox'><label for='data-11a289cc-8615-4202-a93a-c07b8c74df28' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([34.574173, 34.85523 , 34.486984, 35.177284, 34.745213, 34.871284,
       35.334602, 33.764072], dtype=float32)</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>all_mean_qc_flags_profiles</span></div><div class='xr-var-dims'>(dim_mask)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>4.422e+05 1.501e+04 ... 1.93e+06</div><input id='attrs-7c8d92ce-b9c2-4df7-aa07-bcf138538821' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-7c8d92ce-b9c2-4df7-aa07-bcf138538821' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-e5f9fddc-2ee8-4097-9d3e-a129902cbab8' class='xr-var-data-in' type='checkbox'><label for='data-e5f9fddc-2ee8-4097-9d3e-a129902cbab8' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([ 442235.24343675,   15008.98928571,   80146.01273885,
        376662.06666667,  938649.58108108,  236414.92957746,
        351245.56410256, 1930156.61016949])</pre></div></li><li class='xr-var-item'><div class='xr-var-name'><span>all_mean_qc_flags_levels</span></div><div class='xr-var-dims'>(dim_mask)</div><div class='xr-var-dtype'>float64</div><div class='xr-var-preview xr-preview'>3.272e+07 3.244e+07 ... 3.683e+07</div><input id='attrs-deb93635-0d5c-4f9f-b1f2-23e53515f29c' class='xr-var-attrs-in' type='checkbox' disabled><label for='attrs-deb93635-0d5c-4f9f-b1f2-23e53515f29c' title='Show/Hide attributes'><svg class='icon xr-icon-file-text2'><use xlink:href='#icon-file-text2'></use></svg></label><input id='data-64972e30-839e-4aae-866b-b9624780123a' class='xr-var-data-in' type='checkbox'><label for='data-64972e30-839e-4aae-866b-b9624780123a' title='Show/Hide data repr'><svg class='icon xr-icon-database'><use xlink:href='#icon-database'></use></svg></label><div class='xr-var-attrs'><dl class='xr-attrs'></dl></div><div class='xr-var-data'><pre>array([32717180.43962013, 32440148.97097322, 33282693.25738854,
       32052298.20066667, 38954525.82148649, 32985344.45144366,
       26732339.47348291, 36830323.95974576])</pre></div></li></ul></div></li><li class='xr-section-item'><input id='section-ec85bb2c-c0bf-4432-a78d-1c1b57bdd3e3' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-ec85bb2c-c0bf-4432-a78d-1c1b57bdd3e3' class='xr-section-summary'  title='Expand/collapse section'>Indexes: <span>(0)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><ul class='xr-var-list'></ul></div></li><li class='xr-section-item'><input id='section-c4fe0249-7593-4e17-8480-28938453d0e5' class='xr-section-summary-in' type='checkbox' disabled ><label for='section-c4fe0249-7593-4e17-8480-28938453d0e5' class='xr-section-summary'  title='Expand/collapse section'>Attributes: <span>(0)</span></label><div class='xr-section-inline-details'></div><div class='xr-section-details'><dl class='xr-attrs'></dl></div></li></ul></div></div>



Notice that the number of mask dimensions is not necessarily preserved between the mask and the mask averaged variables. This happens if, for example, there are no profiles in one of the mask regions


```python
check1 = mask_indices.dims["dim_mask"] == profile_mask_means.dims["dim_mask"]
print(check1)
```

    False


The mean profiles can be visualised or further processed (notice the Irish Sea region and FSC are missing because there were no profiles in the example dataset)


```python
for count_region in range(profile_mask_means.sizes['dim_mask']):    
    plt.plot( 
            profile_mask_means.profile_mean_temperature.isel(dim_mask=count_region),
            profile_mask_means.profile_mean_depth.isel(dim_mask=count_region),
            label=profile_mask_means.region_names[count_region].values,
            marker=".", linestyle='none')

plt.ylim([10,1000])
plt.yscale("log")
plt.gca().invert_yaxis()
plt.xlabel('temperature'); plt.ylabel('depth')
plt.legend()

```




    <matplotlib.legend.Legend at 0x7fe58f282050>




    
![png](/COAsT/mask_maker_tutorial_files/mask_maker_tutorial_33_1.png)
    


# Regional analysis with Gridded data

Apply the regional masks to average SST. This is done manually as there are not yet COAsT methods to broadcast the operations across all variables.


```python
# Syntax: xr.where(if <first>, then <2nd>, else <3rd>) 
mask_SST = xr.where( mask_xr.mask, nemo.dataset.temperature.isel(z_dim=0), np.NaN)

# Take the mean over space for each region
mask_mean_SST = mask_SST.mean(dim="x_dim").mean(dim="y_dim")
```


```python
# Inspect the processed data
mask_mean_SST.plot()
```




    <matplotlib.collections.QuadMesh at 0x7fe58f366710>




    
![png](/COAsT/mask_maker_tutorial_files/mask_maker_tutorial_36_1.png)
    



```python
# Plot timeseries per region

for count_region in range(mask_mean_SST.sizes['dim_mask']):
    
    plt.plot( 
        mask_mean_SST.isel(dim_mask=count_region),
        label=mask_mean_SST.region_names[count_region].values,
        marker=".", linestyle='none')

plt.xlabel('time'); plt.ylabel('SST')
plt.legend()
```




    <matplotlib.legend.Legend at 0x7fe5920da9e0>




    
![png](/COAsT/mask_maker_tutorial_files/mask_maker_tutorial_37_1.png)
    



```python

```
