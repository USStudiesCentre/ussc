# ussc - The R Package for the United States Studies Centre
A collection of scripts and functions to help with research at the
United States Studies Centre at the University of Sydney.

## Setup
To install:

```{r}
devtools::install_github("usstudiescentre/ussc")
library('ussc')
```
Please note that the function `ussc_fonts()` loads automatically. Before installing the package from Github, download the Univers LT Pro and Neo Sans Pro folders from the Styles and Branding page on Confluence and add the files to your font book. This first step is crucial as many functions in this package will not work otherwise. 

Unfortunately, USSC fonts will not print to PDF (meaning the document will not knit) unless you set the device to `cairo_pdf` either in the YAML front matter for the Rmarkdown file or in each ggplot2 code chunk. I would strongly advise you to add this option to your Rprofile file so it runs every time you use R. (Set it once and forget about it.) In the meantime, I'm working on the best way to proceed with this issue.

```
---
output:
  pdf_document:
    dev: cairo_pdf
  word_document: 
  html_document: 
---
```

If there are any problems, please note the issue at https://github.com/usstudiescentre/ussc/issues and contact the maintainer of the package.
