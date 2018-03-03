# ussc - The R Package for the United States Studies Centre
A collection of scripts and functions to help with research at the
United States Studies Centre at the University of Sydney.

To install (directly from GitHub):
```{r}
devtools::install_github("usstudiescentre/ussc")
library('ussc')
```
Note: the function ussc_fonts() loads automatically. Before installing this package, download the fonts from Confluence and add the files to your font book. If you skip this step, the ussc ggplot2 themes will throw an error and your plots will not print.

Knitting files to a PDF can be a pain if you use non-standard fonts in graphs. Unfortunately, USSC fonts will not print to PDF (meaning the document will not knit) unless you set the device to cairo_pdf in the output section in the YAML for the R Markdown file. If you want to forget about it and not have to remember to do it each time you knit a PDF, it may be worth adding this option to your .Rprofile so it runs every time you use R. 
```
---
output:
  pdf_document:
    dev: cairo_pdf
  word_document: 
  html_document: 
---
```

To write a report using USSC fonts, download ussc_fonts.css. It can be found in the CSS folder. Add the file to the yaml in your R markdown file. Note: the fonts in the CSS file must be the same as those in font book. 
```
---
title: Test
author: Zoe Meers
date: "5/12/2017"
css: ussc_fonts.css
---
```

If there are any problems, please note the issue on Github and contact the maintainer of the package.
