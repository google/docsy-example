---
title: "Unit testing"
linkTitle: "Unit testing"
date: 2021-10-05
weight: 18
description: >
  Further information to describe COAsT's functionality.
---

Unit testing is a key component of the COAsT contribution workflow. A "unit test" is a small, singular piece of code that tests an element of COAsT to ensure that it works as expected. This might include a small check that a method actually runs without error and returns an expected value or dataset. There is then a sequence of unit tests which should, in theory, test all parts of the COAsT codebase. When pushing a change to COAsT, we can use this system to ensure that any changes that have been made do not break the existing package. If a modification results in a unit test failing then we must not merge changes into the `develop` or `merge` branches.

The COAsT unit testing system uses Python's own `unittest` library. On this page, the system is outlined, alongside guidance on how to use it.

## The unittest library

Unittest is a library that comes with Python. You can find more information [here](https://docs.python.org/3/library/unittest.html).

We have used the TestSuite functionality of the library alongside the TestCase class. This works by creating a class that inherits from TestCase. Then, any method within this class acts as a unit test, so long as it begins with `test_`. We can create a Test Suite (just a collection of the TestCase classes) and then run it. When we do this, the package will search for all methods beginning with `test_` and run them.

## System Overview

There are several files that make up the unit testing system in COAsT:

1. `unit_testing/unit_test.py`. This is the main unit testing file that controls the import of test classes as well as the creation and execution of the Test Suite. 
2. `unit_testing/unit_test_files.py`. This file simply contains paths which point towards example files, scripts and configs. These are small files that can be obtained here. Ideally, the example files should be in `COAsT/example_files`, the scripts in `COAsT/example_scripts` and the configs in `COAsT/configs`. It is easy to obtain these files from within a test file. Simply `import unit_test_files as files` at the top of a test file. A file can then be obtained anywhere by using `files.file_name_variable`.
3. `unit_testing/test_*.py`. These are the files that contain the actual unit tests, inside the TestCase classes mentioned above. There is a well commented example/template file that comes with COAsT called `test_TEMPLATE.py`. Please see this file for a better idea of what these files look like.

## Running the unit test

You can run the unit testing system simply by running the `unit_test.py` file. For example, within Spyder you could use `run unit_testing/unit_test.py`. The script should be run from the main `COAsT` directory to work correctly. Be careful if using Spyder's play button that your working directory is also the highest level `COAsT` directory. For the easiest time, your example files should be in `COAsT/example_files`, however you can put them anywhere you wish. If the unit test cannot find the files, it will prompt you to enter the path in the terminal.

If you are testing new additions to the system, you may not wish to run all tests. You can easily change which tests you are running by modifying the `tests_to_run` list variable in `unit_testing/unit_test.py`. Comment out the names of the test classes you do not wish to run (that's all you have to do).

As the test runs, it will return the names of the test methods it is currently running and a message telling you whether it was ok, ERROR or FAILURE. When all tests are complete, it will tell you how many ERRORs and FAILUREs occurred and how long the test took. A successful unit testing run will have 0 ERRORS and 0 FAILURES. If there are errors, it will return information on which unit tests failed as well as traceback on the error raised. 

## Adding your own unit test

When changing COAsT, you should add your own unit tests for the features you have added. You can do this either by adding a method to an existing test class in one of the `test_*.py` files or by creating your own test class and adding unit tests to this. You should carefully consider whether your new features fit within the context of any of the existing test classes.

If creating a new test class, your workflow may look something like this:

1. **Create new test_your_name.py file**: You might want to start by copying test_TEMPLATE.py to a new filename of your choice. Delete the methods inside of it and rename to class from test_TEMPLATE to test_<>. The name of the class does not have to match the name of the file, but make sure you know the difference. Ensure this new file is saved in the `COAsT/unit_testing` directory.
  
2. **Add unit tests to your file:** You do this simply by creating new methods inside the class you created above. Each method that you want to act as a unit test must being with "test_". You should name your test to appropriately reflect its function. If there are any problems with your unit test when running the system then the name of the failed method will be returned. Using a long descriptive name in this case is useful.

3. **Add new test file to unit_test.py:** You need to let the main `unit_test.py` script know about your new file and class. At the top of this file is a selection of import statement. Follow the other lines here by importing the names of your test class(es) from your file. For example, to import the `test_TEMPLATE` class from `test_TEMPLATE.py`, you can add the line `from test_TEMPLATE.py import test_TEMPLATE`. Next, you must add this imported classes to the `tests_to_do` list below. And that's it!

## Unit testing coverage
Code coverage is a useful statistic that tells us how much of the package (and individual classes) are 'covered' by the unit testing system. Coverage means what percentage of the code is 'touched' by the unit testing system. This is not built in to the system used by COAsT, however it is easy to set up and use.

The Coverage python tool can be used to do this. For more information see [here](https://coverage.readthedocs.io/en/6.3.2/install.html). The tool can be easily installed using pip:

`pip install coverage`

Then we use the tool from the command line/terminal. From the main COAsT directory, enter:

```
coverage run unit_testing/unit_test.py
```
This will run the unit test as usual, but with the coverage tool in the background (takes a little longer than usual). The result is a new output file in the COAsT directory called .coverage. We can't read this but can transform it into a readable report using:

```
coverage report
```
Which outputs statistics to the screen for each file and the whole package. For example:

```Name                                           Stmts   Miss  Cover
------------------------------------------------------------------
coast/__init__.py                                 28      0   100%
coast/altimetry.py                               169    139    18%
coast/argos.py                                    24     14    42%
coast/climatology.py                              85     67    21%
coast/coast.py                                   205    147    28%
coast/config_parser.py                            51      9    82%
coast/config_structure.py                         53      0   100%
coast/contour.py                                 485    443     9%
coast/crps_util.py                               117     56    52%
coast/eof.py                                      83     76     8%
coast/general_utils.py                           153     88    42%
coast/glider.py                                   16      8    50%
coast/gridded.py                                 377    267    29%
coast/index.py                                    49     25    49%
coast/internal_tide.py                            81     72    11%
coast/lagrangian.py                                3      0   100%
coast/logging_util.py                             50      3    94%
coast/mask_maker.py                               66     46    30%
coast/oceanparcels.py                             16      8    50%
coast/plot_util.py                               129     94    27%
coast/profile.py                                 345    314     9%
coast/stats_util.py                               67     43    36%
coast/tidegauge.py                               453    113    75%
coast/tidegauge_analysis.py                      189     15    92%
coast/timeseries.py                               35     29    17%
coast/track.py                                     3      0   100%
coast/transect.py                                420    385     8%
coast/xesmf_convert.py                            32     21    34%
------------------------------------------------------------------
TOTAL                                           4851   3071    37%
```

This table shows statistics for each file in the COAsT package. There are three key statistics returns: `stmts`, `Miss` and `Cover`. `stmts` tells us how many executable statements are reached, `Miss` tells us how many were missed and `Cover` tells us the percentage coverage.

There are plenty of extra features, such as outputting to various file types and flags which control the coverage calculations. See the website for more information.

