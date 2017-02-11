---
output: html_document
---
# IDS_R

## NEWS

* *2017-02-11*: Further development of an **R package** for *IDS* takes place the repository [idsr](https://github.com/goranbrostrom/idsr). This repository will soon be removed: At least, 
new material will not be published here. 

## Introduction

Some examples of how to create data files ready for analysis, given the IDS
raw data structure, are found here. I don't think that the idea of a
general extraction program, valid for all occasions of certain type (e.g.,
mortality, fertility, etc.), is practical; the possible variations are too
numerous. On the other hand, if the IDS structure is useful and worthwhile,
the involved programming skills necessary to create a particular file for
analysis should be minimal. It is sometimes argued that this would be an
obstacle for scholars in (historical) demography, but in my mind, some
programming skills are absolutely necessary for anyone who want to be a
successful researcher in fields using statistical modeling. 
An even more important argument is that the analysis of dynamic data
(processes moving in time) requires advanced statistical modeling skills. 

So, I give two groups of examples of how to create a data file ready for
analysis in **R**, based on Luciana Quaranta's Stata programs. 

## The articles in *Historical Life Course Studies*

**IDS1.Rmd** is an *R markdown* file; the corresponding *html* document is 
**IDS1.html**. It shows how to create an episodes file from the excel file
**DemoDatabase.xlsx** 

**get_indata2.Rmd** is an attempts to create the
*chronicle file* **data/chronicle.rda** from a data retrieval from the
**DDB**. (a sort of *reverse engineering* for its own sake).

**IDS2.Rmd** is the serious attempt to write an **R** function that
  extracts an episodes file from the chronicle file plus a start-up file. 

**toIDS.Rmd** is an *R markdown* file; the corresponding *html* file is 
**toIDS.html**. Creates IDS files from DDB files (sort of "reverse
engineering": The DDB files were in 'analysis' format).

**fromIDS.Rmd** is an *R markdown* file; the corresponding *html* file is 
**fromIDS.html**. Creates files for statistical analysis from IDS files
(INDIVIDUAL and INDIV_INDIV, particularly simple versions). And
documentation *on the fly*. 

## General

Install **R** and *RStudio* and run the Rmarkdown files. You need data (IDS),
which is *not* included here. *RStudio* will guide you in installing the
necessary add-on packages.

You can choose as output media from *html*, *pdf* and *word*.

## Download

For opening an html document, choose "Download ZIP",
unpack the zip file and open the html document in a web browser. 

Better still, install [git](https://git-scm.com) and *clone* the repository
and *contribute*. Contact me if you are serious about it.
