---
title: "Code styling and structure"
linkTitle: "Code styling and structure"
weight: 2
description: >
  Python style guidance.
---

Python as a language comes with more stringent recommendations than most when it comes to code styling. This is advantageous in our case as it gives us an obvious set of guidelines to adopt.

When it comes to simple code styling, much of what's recommended here will be copied from [Python Enhancement Proposal (PEP) 8](https://www.python.org/dev/peps/pep-0008/), an officially proposed and accepted Python style guide.

In our code, we use pylint and black applied on CI/CD codes in order to fix some code styling and to check the code styling. Your pull request will only be accepted if the new code have a styling score equal or higher than the actual code.

## Code Styling Conventions

Let's keep things simple to start with...

* Indentation should be achieved with spaces rather than tabs and each new level of indentation should be indented by four columns (i.e four spaces).

* Any single line, including its indentation characters, should not exceed 79 characters in length.

* Top-level (i.e at the module/file level rather than inside a function or class) function and class definitions should be separated by two blank lines.

* Method (functions within a class) definitions are separated by a single blank line.

* Usually, "import" statements should be on separate lines, that is to say that you should have one line per distinct module or package import. An exception to this rule is when multiple objects are imported from a single module or package, using a "from" statement, in which case individual objects can be imported on the same line, separated by commas.

* PEP 8 does not make a recommendation relating to the use of double or single quotes in general use, but for the sake of consistency, this document suggests the use of double quotes wherever practical. This recommendation is intended for the sake of consistency with triple-quoted strings, as per Docstring Conventions (PEP 257).

* Operators should be separated by single columns (i.e one space) either side, unless inside parentheses, in which case no whitespace is required.

* Comments (beginning with the # character) should be indented as if they were code. In the case of inline comments, separate the comment with two spaces following the code it shares the line with.

* All functions should contain a docstring, which provides basic information on its usage. For this project, the [reStructuredText docstring format](https://www.python.org/dev/peps/pep-0287/) is suggested.

* When it comes to naming variables and functions, snake case (lower\_case\_words\_separated\_by\_underscores) is preferred. There are however a few exceptions to this rule:
Class names should be styled as camel case (EveryNewWordIsCapitalised).
Constants (Variables that should not be changed) can be indicated by the use of screaming snake case (UPPER\_CASE\_WORDS\_SEPARATED\_BY\_UNDERSCORES). Note that this library currently targets Python 3.7, so the use of [typing.Final](https://www.python.org/dev/peps/pep-0591/) official support for constant variables, new as of Python 3.8:  is not currently supported.

* In general, it is suggested to avoid the use of single-character variable names, but this is acceptable in certain cases, such as when defining coordinates (such as x, y and z), as these will be commonly recognized and enforcing different rules could cause confusion.
PEP 8 advises the following regarding names to avoid:
"Never use the characters 'l' (lowercase letter el), 'O' (uppercase letter oh), or 'I' (uppercase letter eye) as single character variable names."
These specific characters should be avoided because they present an accessibility issue, as under many fonts these characters may be difficult to distinguish or completely indistinguishable from numerals one (1) and zero (0).

* In the interest of readability, where named iterator variables are required, this document suggests the use of double characters (e.g. "ii" rather than "i").














COAsT is an object-orientated package, meaning that data is stored within Python object
structures. In addition to data storage, these objects contain methods (subroutines)
which allow for manipulation of this data.

The general principles of OOP are fairly straightforward and well documented, so we won't waste your precious time by regurgitating that particular wall of text here. Instead, we'll focus on some general pointers specific to this language and use case.

* In Python, all class attributes are technically public, but semantically, attributes can be designated as non-public by including leading underscores in the name. For instance, "my\_variable" becomes "\_my\_variable". These attributes are generally referred to as "protected".

* When you define a Python class, it is a best practice to inherit from the base object type. This convention stems from Python 2.X, as classes and types were not originally synonymous. This behaviour is implicit in Python 3.X but the convention has persisted nonetheless. Classes defined this way are referred to as "new-style" classes.

* When defining a class that inherits from another, it is important to remember that overridden methods (in particular, this behaviour is important when dealing with \_\_init\_\_ methods) do not implicitly call the parent method. What this means is that unless you want to deliberately prevent the behaviour of the parent class (this is a very niche use-case), it is important to include a reference to the parent method. An example of this is: super().\_\_init\_\_()
This functionality is advantageous as it prevents unnecessary duplication of code, which is a key tenet of object-oriented software.


An example of such an object in COAsT is the Gridded object, which allows for the
storage and manipulation of e.g. NEMO output and domain data. It is important to
understand how to load data using COAsT and the structure of the resulting
objects.

A Gridded object is created and initialised by passing it the paths of the domain and data
files. Ideally, the grid type should also be specified (T, U, V or F in the case of NEMO).
For example, to load in data from a file containing data on a NEMO T-grid:

```python
import coast

fn_data = "<path to T-grid data file(s)>"
fn_domain = "<path to domain file>"
fn_config = "<path to json config file>"
data = coast.Gridded(fn_data, fn_domain, fn_config)
```

Ideally, Gridded model output data should be in grid-specific files, i.e. containing output
variables situated on a NEMO T, U, V or F grid, whereas the grid variables are in a single domain file. On loading into COAsT,
 only the grid specific variables appropriate for the paired data are placed into the Gridded object. A Gridded object
therefore contains grid-specific data and all corresponding grid variables. One of the
file names can be omitted (to get a data-only or grid only object), however functionality
in this case will be limited.

Once loaded, data is stored inside the object using an xarray.dataset object. Following
on from the previous code example, this can be viewed by calling:

```python
data.dataset
```
This reveals all netcdf-type aspects of the data and domain variables that were loaded,
including dimensions, coordinates, variables and attributes. For example:

```
<xarray.Dataset>
Dimensions:              (axis_nbounds: 2, t_dim: 7, x_dim: 297, y_dim: 375, z_dim: 51)

Coordinates:
    time                 (t_dim) datetime64[ns] 2007-01-01T11:58:56 ... 2007-01-31T11:58:56
    longitude            (y_dim, x_dim) float32 ...
    latitude             (y_dim, x_dim) float32 ...
Dimensions without coordinates: axis_nbounds, t_dim, x_dim, y_dim, z_dim

Data variables:
    deptht_bounds        (z_dim, axis_nbounds) float32 ...
    sossheig             (t_dim, y_dim, x_dim) float32 ...
    time_counter_bounds  (t_dim, axis_nbounds) datetime64[ns] ...
    time_instant         (t_dim) datetime64[ns] ...
    temperature          (t_dim, z_dim, y_dim, x_dim) float32 ...
    e1                   (y_dim, x_dim) float32 ...
    e2                   (y_dim, x_dim) float32 ...
    e3_0                 (z_dim, y_dim, x_dim) float32 1.0 1.0 1.0 ... 1.0 1.0
```

Variables may be obtained in a number of ways. For example, to get temperature data, the
following are all equivalent:

```python
temp = data.dataset.temperature
temp = data.dataset['temperature']
temp = data['temperature']
```
These commands will all return an xarray.dataarray object. Manipulation of this object
can be done using xarray commands, for example indexing using [] or `xarray.isel``. Be aware
that indexing will preserve lazy loading, however and direct access or modifying of the
data will not. For this reason, if you require a subset of the data, it is best to
index first.

The names of common grid variables are standardised within the COAsT package using JSON configuration files. For example, the following lists COAsT internal variable followed by the typical NEMO variable names:

1. longitude [glamt / glamu / glamv / glamf]
2. latitude  [gphit / gphiu / gphiv / gphif]
3. time      [time_counter]
4. e1        [e1t / e1u / e1v / e1f] (dx variable)
5. e2        [e1t / e1u / e1v / e1f] (dy variable)
6. e3_0      [e3t_0 / e3u_0 / e3v_0 / e3f_0] (dz variable at time 0)

Longitude, latitude and time are also set as coordinates. You might notice that dimensions
are also standardised:

1. x_dim   The dimension for the x-axis (longitude)
2. y_dim   The dimension for the y-axis (latitude)
3. t_dim   The dimension for the time axis
4. z_dim   The dimension for the depth axis.

Wherever possible, the aim is to ensure that all of the above is consistent across the
whole COAsT toolbox. Therefore, you will also find the same names and dimensions in, for
example observation objects. Future objects, where applicable, will also follow these
conventions. If you (as a contributor) add new objects to the toolbox, following
the above template is strongly encouraged. This includes using xarray dataset/dataarray
objects where possible, adopting an object oriented approach and adhering to naming
conventions.
