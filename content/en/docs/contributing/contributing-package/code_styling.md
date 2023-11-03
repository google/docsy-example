---
title: "Code styling"
linkTitle: "Code styling"
weight: 1
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
