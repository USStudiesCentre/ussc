## Functions to create USSC-themed D3.js templates in R
## Zoe Meers
## The United States Studies Centre at the University of Sydney


#' D3.js Ideal Point Estimation for legislative roll call data
#' @description
#' This function creates a D3.js ideal point estimation graph for legislative roll call data.
#' @section Building upon R ideal points graphs:
#' The function wraps around D3.js and requires installation of the RStudio daily build (see https://rstudio.github.io/r2d3/ for clarification). You can set the width and height of the graph. You must call the data by calling a data frame or matrix.
#' @usage 
#' d3_rollcall_idealpoint()
#' @param 
#' data = data 
#' @param 
#' width = NULL
#' @param 
#' height = NULL
#' @examples 
#' d3_rollcall_idealpoints(data=estimates, height=10, width=6)
#' @author 
#' Zoe Meers, Simon Jackman

d3_rollcall_idealpoints <- function(data, width=NULL, height=NULL){
    r2d3::r2d3(
        data=data,
        d3_version = "3", 
        script=system.file("d3/ideal/scripts/long_r2d3.js", package="usscdraft"),
        css = system.file("d3/ideal/css/style.css", package="usscdraft"), 
        dependencies = system.file("d3/ideal/dependencies/timeStamp.js", package="usscdraft")
    )
}


