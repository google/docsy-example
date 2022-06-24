---
title: "Docsy_tools"
linkTitle: "Docsy_tools"
date: 2022-06-24
description: >
  Docstrings for the Docsy_tools class
---
### Objects

[DocsyTools()](#docsytools)<br />
[DocsyTools.write_class_to_markdown()](#docsytoolswrite_class_to_markdown)<br />
[DocsyTools._method_to_str()](#docsytools_method_to_str)<br />
[DocsyTools._get_list_of_methods()](#docsytools_get_list_of_methods)<br />

A class to help with writting markdown.
#### DocsyTools()
```python
class DocsyTools():
```

```

```

##### DocsyTools.write_class_to_markdown()
```python
@classmethod
def DocsyTools.write_class_to_markdown(cls, class_to_write, fn_out, method_to_omit=unknown, omit_private_methods=True, omit_parent_methods=True):
```
> <br />
> None<br />
> <br />
##### DocsyTools._method_to_str()
```python
@classmethod
def DocsyTools._method_to_str(cls, method_name):
```
> <br />
> None<br />
> <br />
##### DocsyTools._get_list_of_methods()
```python
@classmethod
def DocsyTools._get_list_of_methods(cls, class_to_search, methods_to_omit=unknown, omit_private_methods=True, omit_parent_methods=True):
```
> <br />
> Returns a list of methods inside a provided COAsT class, with some<br />
> other options<br />
> <br />
> Parameters<br />
> ----------<br />
> class_to_search : imported class<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Class imported from COAsT (e.g. from coast import Profile)<br />
> methods_to_omit : list<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  List of method strings to omit from the output. The default is [].<br />
> omit_private_methods : bool, optional<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  If true, omit methods beginning with "_". The default is True.<br />
> omit_parent_methods : bool, optional<br />
>    If true, omit methods in any parent/ancestor class. The default is True.<br />
> <br />
> Returns<br />
> -------<br />
> methods_to_write : list<br />
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  List of strings denoting method names<br />
> <br />