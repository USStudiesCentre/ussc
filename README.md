# ussc - The R Package for the United States Studies Centre
A collection of scripts and functions to help with research at the
United States Studies Centre at the University of Sydney.

To install (directly from GitHub):
```{r}
devtools::install_github("usstudiescentre/ussc")
library('ussc')
```
Note: the function ussc_fonts() loads automatically. Before installing this package, download the fonts from Confluence and add the files to your font book. If you skip this step, the ussc ggplot2 themes will throw an error and not run.

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
