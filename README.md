# ussc - The R Package for the United States Studies Centre
A collection of scripts and functions to help with research at the
United States Studies Centre at the University of Sydney.

To install (directly from GitHub):
```{r}
devtools::install_github("usstudiescentre/ussc")
library('ussc')
```
Note: the function ussc_fonts() loads automatically. Before installing this package, download the fonts from Confluence and add the files to your font book. If you skip this step, the ussc ggplot2 themes will throw an error and your plots will fail to print.

Knitting files to a PDF can be painful if you use non-standard fonts in graphs. I have tried to make this as easy as possible. Unfortunately, USSC fonts will not print to PDF (meaning the document will not knit) unless you set the device to cairo_pdf in the front matter for the R Markdown file. If you want to forget about this and not have to remember to do it each time you knit a PDF, it may be worth adding this option to your .Rprofile so it runs every time you use R. 
```
---
output:
  pdf_document:
    dev: cairo_pdf
  word_document: 
  html_document: 
---
```

To write a report using USSC fonts, download ussc_fonts.css. It can be found in the CSS folder. Add the file to the front matter in your R markdown file. Note: the fonts in the CSS file must be the same as those in font book. 
```
---
title: Test
author: Zoe Meers
date: "5/12/2017"
css: ussc_fonts.css
---
```

[Examples of USSC ggplot2 themes can be viewed here.](https://zmeers.github.io/example/example.html)

If there are any problems, please note the issue on Github and contact the maintainer of the package.
