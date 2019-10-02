## Plot USSC logo on ggplot2 graph
## Zoe Meers
## The United States Studies Centre at the University of Sydney

#' Append new USSC logo at the bottom of graph
#' @usage
#' plot_ussc_logo()
#' @examples
#' plot_ussc_logo(ggplot_object)
#' @author
#' Zoe Meers
#' @export


plot_ussc_logo <- function(ggplot_object){
  
  get_png <- function(filename) {
    grid::rasterGrob(png::readPNG(), interpolate = TRUE)
  }
  
  logo <- get_png(system.file("img/logo.png", package = 'ussc'))
  
  logo_plot <- ggplot(mapping = aes(x = 0:1, y = 1)) +
    theme_void() +
    annotation_custom(grob = logo, xmin = 0.8, xmax = 1.1)
  
  gridExtra::grid.arrange(ggplot_object, logo_plot,  heights = c(.93,.1))
  
}
