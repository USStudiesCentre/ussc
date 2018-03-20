# ussc - The R Package for the United States Studies Centre
A collection of scripts and functions to help with research at the
United States Studies Centre at the University of Sydney.

## Setup
To install:

```{r}
devtools::install_github("usstudiescentre/ussc")
library('ussc')
```
*Note:* in this package the function `ussc_fonts()` loads automatically. Before installing the package from Github, download the Univers LT Pro and Neo Sans Pro folders from the Styles and Branding page on Confluence and add the files to your font book. This first step is crucial as many functions in this package will not work otherwise. 

I find that knitting PDF files can be challenging, especially when using different font styles. I have tried to make this hack as easy as possible. Unfortunately, USSC fonts will not print to PDF (meaning the document will not knit) unless you set the device to `cairo_pdf` either in the YAML front matter for the Rmarkdown file or in each ggplot2 code chunk. I would strongly advise you to add this option to your Rprofile file so it runs every time you use R. (Set it once and forget about it.)

```
---
output:
  pdf_document:
    dev: cairo_pdf
  word_document: 
  html_document: 
---
```

If you want to write a HTML report using official USSC fonts, download ussc_fonts.css. It can be found in the CSS folder. Add the file to the front matter in your R markdown file. Note: the fonts in the CSS file must be the same as those in font book. The css file must be in the same folder as the report file. 

```
---
title: Test
author: Zoe Meers
date: "5/12/2017"
css: ussc_fonts.css
---
```

If there are any problems, please note the issue at https://github.com/usstudiescentre/ussc/issues and contact the maintainer of the package.
