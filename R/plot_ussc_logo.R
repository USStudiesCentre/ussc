## Plot USSC logo on ggplot2 graph
## Zoe Meers
## The United States Studies Centre at the University of Sydney

#' Append new USSC logo at the bottom of graph
#' @usage
#' plot_ussc_logo()
#' @param ggplot_object A ggplot2 graph - either last_plot() or written out to a specific name. 
#' @param position A character vector of the logo position - "bottom-right", "bottom-centre","bottom-center","bottom-left","top-right", "top-centre","top-center","top-left".
#' @examples
#' \dontrun{
#' graph <- ggplot2::ggplot2::ggplot(mtcars, ggplot2::aes(x = wt, y = mpg)) + 
#' ggplot2::geom_point() + 
#' ussc::theme_ussc()
#' plot_ussc_logo(ggplot_object = graph, position = "bottom-right")
#' }
#' @author
#' Zoe Meers
#' @export
plot_ussc_logo <- function(ggplot_object, position = "bottom-right"){
  logo <- magick::image_read_svg(system.file("img/USSC_convert_positive.svg", 
                                             package = "ussc")) %>% 
    magick::image_chop("450x875+315") %>% 
    grid::rasterGrob(interpolate = TRUE)
  if(position == "bottom-right"){
    logo_plot <- ggplot2::ggplot(mapping = aes(x = 0:1, y = 1)) + 
      ggplot2::theme_void() + 
      ggplot2::annotation_custom(grob = logo, xmin = 0.85, xmax = 1.055)
    
    gridExtra::grid.arrange(ggplot_object, logo_plot, heights = c(0.93, 
                                                                  0.1))
  } else if(position == "bottom-left") {
    logo_plot <- ggplot2::ggplot(mapping = aes(x = 0:1, y = 1)) + 
      ggplot2::theme_void() + 
      ggplot2::annotation_custom(grob = logo, xmin = 0, xmax = 0.205)
    
    gridExtra::grid.arrange(ggplot_object, logo_plot, heights = c(0.93, 
                                                                  0.1))
  } else if(position == "top-left") {
    logo_plot <- ggplot2::ggplot(mapping = aes(x = 0:1, y = 1)) + 
      ggplot2::theme_void() + 
      ggplot2::annotation_custom(grob = logo, xmin = 0, xmax = 0.205)
    
    gridExtra::grid.arrange(logo_plot, ggplot_object, heights = c(0.1, 0.93))
  } else if(position == "top-right") {
    logo_plot <- ggplot2::ggplot(mapping = aes(x = 0:1, y = 1)) + 
      ggplot2::theme_void() + 
      ggplot2::annotation_custom(grob = logo, xmin = 0.85, xmax = 1.055)
    
    gridExtra::grid.arrange(logo_plot, ggplot_object, heights = c(0.1, 0.93))
  } else if(position == "top-centre") {
    logo_plot <- ggplot2::ggplot(mapping = aes(x = 0:1, y = 1)) + 
      ggplot2::theme_void() + 
      ggplot2::annotation_custom(grob = logo, xmin = 0.45, xmax = 0.655)
    
    gridExtra::grid.arrange(logo_plot, ggplot_object, heights = c(0.1, 0.93))
  } else if(position == "top-center") {
    logo_plot <- ggplot2::ggplot(mapping = aes(x = 0:1, y = 1)) + 
      ggplot2::theme_void() + 
      ggplot2::annotation_custom(grob = logo, xmin = 0.45, xmax = 0.655)
    
    gridExtra::grid.arrange(logo_plot, ggplot_object, heights = c(0.1, 0.93))
  } else if(position == "bottom-center") {
    logo_plot <- ggplot2::ggplot(mapping = aes(x = 0:1, y = 1)) + 
      ggplot2::theme_void() + 
      ggplot2::annotation_custom(grob = logo, xmin = 0.45, xmax = 0.655)
    
    gridExtra::grid.arrange(ggplot_object, logo_plot, heights = c(0.93, 0.1))
  } else if(position == "bottom-centre") {
    logo_plot <- ggplot2::ggplot(mapping = aes(x = 0:1, y = 1)) + 
      ggplot2::theme_void() + 
      ggplot2::annotation_custom(grob = logo, xmin = 0.45, xmax = 0.655)
    
    gridExtra::grid.arrange(ggplot_object, logo_plot, heights = c(0.93, 0.1))
  } 
  
}