# ussc - The R Package for the United States Studies Centre
A collection of scripts and functions to help with research at the
United States Studies Centre at the University of Sydney.

To install (directly from GitHub):
```
devtools::install_github("USStudiesCentre/ussc")
library(ussc)
```

To load USSC fonts, run the following function:
```
ussc_fonts()
```
Before doing so, make sure you have downloaded the fonts found in the 'fonts' folder of ussc and have added them to your local Font Book. 

For report writing, download ussc_fonts.css in the css folder. Add to the yaml at the top of a R markdown file. Note, for the css stylings to compile, the fonts in the css file must be the same as those in your Font Book. 
```
title: Test
author: Zoe Meers
date: "5/12/2017"
css: ussc_fonts.css
```


If there are any issues, contact the maintainer of the package.
