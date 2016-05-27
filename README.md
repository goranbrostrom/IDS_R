# IDS_R

## Introduction

Some examples of how to create deta files ready for analysis, given the IDS
raw data structure, are found below. I don't think that the idea of a
general extraction program, valid for all occasions of certain type (e.g.,
mortality, fertility, etc.), is practical; the possible variations are too
numerous. On the other hand, if the IDS structure is useful and worthwhile,
the involved programming skills necessary to create a particular file for
analysis should be minimal. It is sometimes argued that this would be an
obstacle for scholars in (historical) demography, but in my mind, some
programming skills are absolutely necessary for anyone who want to be a
successful researcher in this field. 

An even more important argument is that the analysis of dynamic data
(processes moving in time) requires advanced statistical modeling skills;
only reading some pages in the stata manual is not enough. On the contrary,
it is almost surely damaging. A few examples of mistakes I have seen
lately: (i) breaking the absolute rule that present risks cannot depend on
the future (example: 'mother is pregnant' derived from a birth coming
soon), (ii) using mother's age in a fertility study as the basic time scale
and assuming proportional hazards without removing a mother from
observation up to nine months after a birth, (iii) using dynamic covariates
(eg. *parity* in a fertility study) in a wrong way, creating *dishonest*
models. 

So, I give two examples, based on Luciana's stata programs.


## The articles in *Historical Life Course Studies

**IDS1.Rmd** is an *R markdown* file; the corresponding *html* document is 
**IDS1.html**. It shows how to create an episodes file from the excel file
***DemoDatabase.xlsx* 

**get_indata2.Rmd** is an attempts to create the
**chronicle file **data/chronicle.rda** from a data retrieval from the
**DDB. (a sort of *reverse engineering* for its own sake).

**IDS2.Rmd** is the serious attempt to write an **R** function that
  extracts an episodes file from the chronicle file plus a start-up file. 

## The program for the ESHD 2016 Conference

*toIDS.Rmd* is an *R markdown* file; the corresponding *html* file is 
*toIDS.html*. Creates IDS files from DDB files (sort of "reverse engineering").

*fromIDS.Rmd* is an *R markdown* file; the corresponding *html* file is 
*fromIDS.html*. Creates files for statistical analysis from IDS files
*(INDIVIDUAL and INDIV_INDIV, particularly simple versions). 


For opening an html document, choose "Download ZIP" at the bottom right,
unpack the zip file and open the html document in a web browser. 

Better still, install [git](https://git-scm.com) and *clone* the repository
and *contribute*.
