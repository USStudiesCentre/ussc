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
plot_ussc_logo <- function (ggplot_object){
  
  logo <- magick::image_read_svg(system.file("USSC_convert_positive.svg", package = "ussc")) %>%
    magick::image_chop("450x875+315") %>% 
    grid::rasterGrob(interpolate = TRUE)
  
  logo_plot <- ggplot(mapping = aes(x = 0:1, y = 1)) + theme_void() + 
    annotation_custom(grob = logo, xmin = 0.85, xmax = 1.055)
  
  gridExtra::grid.arrange(ggplot_object, logo_plot, heights = c(0.93, 
                                                                0.1))
}
