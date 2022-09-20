---
title: "Experiments_file_handling"
linkTitle: "Experiments_file_handling"
date: 2022-09-20
description: >
  Docstrings for the Experiments_file_handling class
---
### Objects

[experiments()](#experiments)<br />
[nemo_filename_maker()](#nemo_filename_maker)<br />

Set of functions to control basic experiment file handling
#### experiments()
```python

def experiments(experiments=experiments.json):
```
> <br />
> Reads a json formatted files, default name is experiments.json<br />
> <b>for lists of:</b><br />
>   experiment names (exp_names)<br />
>   directory names (dir names)<br />
>   domain file names (domains)<br />
>   file names (file_names)<br />
> <br />
> <br />
> Parameters<br />
> ----------<br />
> experiments : TYPE, optional<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  DESCRIPTION. The default is 'experiments.json'.<br />
> <br />
> Returns<br />
> -------<br />
> exp_names,dirs,domains,file_names<br />
> <br />
#### nemo_filename_maker()
```python

def nemo_filename_maker(directory, year_start, year_stop, grid=T):
```
> <br />
> Creates a list of NEMO file names from a set of standard templates.<br />
> <br />
> <b>Args:</b><br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  directory: path to the files'<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  year_start: start year<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  year_stop: stop year<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  grid: NEMO grid type defaults to T<br />
> <br />
> Returns: a list of possible nemo file names<br />
> <br />