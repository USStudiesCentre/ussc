## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, warnings=FALSE, message=FALSE)
library(r2d3)
library(here)
library(ussc)
#set wd or open the file directly. 

## ------------------------------------------------------------------------
#load data
house_estimates <- read.csv(here("h_estimates.csv"))
head(house_estimates)

## ---- fig.height=20------------------------------------------------------
#Run d3_rollcall_idealpoints for House of Rep data
#You *must* define the data frame -- we did that above, reading the csv file to house_estimates and defined the data below in the function itself. This is the beauty of r2d3 -- any data frame or R object will work if the variables match the javascript.
# Note: you can  set the height and width of the visualization inside the function or add it to the R chunk.
d3_rollcall_idealpoints(data=house_estimates, height=20)

## ------------------------------------------------------------------------
#load data
senate_estimates <- read.csv(here("s_estimates.csv"))

## ---- fig.height=5-------------------------------------------------------
#run d3_rollcall_idealpoints for Senate data
d3_rollcall_idealpoints(data=senate_estimates)

