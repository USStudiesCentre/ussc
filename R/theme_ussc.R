## Functions to create USSC ggplot2 theme
## Zoe Meers
## The United States Studies Centre at the University of Sydney


#' Main USSC theme
#' @description
#' Calls the main USSC theme. 
#' @usage
#' theme_ussc()
#' @examples
#' # Create ggplot graph using main USSC theme
#' ggplot2::ggplot(iris, ggplot2::aes(Sepal.Width, Sepal.Length, colour = Species)) + 
#' ggplot2::geom_point(size = 4, alpha=0.4) + 
#' ussc::theme_ussc() + 
#' ggplot2::labs(title="Halis GR Header", x="Sepal Width", y="Sepal Length") + 
#' ussc::scale_colour_ussc("blue")
#' @author
#' Zoe Meers
#' @export

theme_ussc <- function () {
    ggplot2::theme_minimal() + 
    ggplot2::theme(plot.margin = ggplot2::unit(c(2, 2, 2, 10), "mm"), 
                   panel.border = ggplot2::element_blank(), 
                   text = ggplot2::element_text(colour = "#444444", 
                                                family = "Halis GR Book"), 
                   axis.title.x = ggplot2::element_text(size = 11, 
                                                        face = "bold"), 
                   axis.title.y = ggplot2::element_text(size = 11, 
                                                        face = "bold"), 
                   axis.text.x = ggplot2::element_text(size = 10, 
                                                       family = "Halis GR Light"), 
                   axis.text.y = ggplot2::element_text(size = 10, 
                                                       family = "Halis GR Light"), 
                   axis.ticks = ggplot2::element_blank(), 
                   legend.text = ggplot2::element_text(size = 10, 
                                                       family = "Halis GR Light"), 
                   legend.title = ggplot2::element_text(size = 10), 
                   legend.key.size = ggplot2::unit(x = 10, units = "pt"), 
                   legend.background = ggplot2::element_rect(color = NA, 
                                                             fill = "transparent"), 
                   legend.key = ggplot2::element_rect(color = "transparent", 
                                                      fill = "transparent"), 
                   legend.box.background = ggplot2::element_rect(color = NA, 
                                                                 fill = "transparent"), 
                   plot.title = ggplot2::element_text(size = 16, 
                                                       family = "Halis GR S Bold"), 
                   plot.caption = ggplot2::element_text(size = 10, 
                                                        family = "Halis GR Light"), 
                   plot.subtitle = ggplot2::element_text(size = 11, 
                                                         family = "Halis GR Medium"), 
                   plot.background = ggplot2::element_rect(fill = "transparent", 
                                                           colour = NA), 
                   panel.background = ggplot2::element_rect(fill = "transparent", 
                                                            colour = NA), 
                   strip.background = ggplot2::element_blank(), 
                   strip.text = ggplot2::element_text(face = "bold"))
}


#' Dark USSC theme
#' @description
#' Calls the dark USSC theme. 
#' @usage
#' theme_ussc_dark()
#' @examples
#' # Create ggplot graph using dark USSC theme
#' # set dev.args in the code chunk - i.e. ```r dev.args=list(bg='#2a2a2b')```
#' ggplot2::ggplot(iris, ggplot2::aes(Sepal.Width, Sepal.Length, colour = Species)) + 
#' ggplot2::geom_point(size = 4, alpha=0.4) +  
#' ussc::theme_ussc_dark() + 
#' ggplot2::labs(title="Halis GR Header", x="Sepal Width", y="Sepal Length") + 
#' ussc::scale_colour_ussc("blue") 
#' @author
#' Zoe Meers
#' @export

theme_ussc_dark <- function() {
  ggplot2::theme_minimal() +
    ggplot2:: theme(
      text = ggplot2::element_text(family = "Halis GR Book"),
      # Specify axis options
      axis.line = ggplot2::element_blank(),  
      axis.text.x = ggplot2::element_text(size = 12*0.8, 
                                          color = "white", 
                                          lineheight = 0.9,
                                          family = "Halis GR Light"),  
      axis.text.y = ggplot2::element_text(size = 12*0.8, 
                                                   color = "white", 
                                                   lineheight = 0.9,
                                                   family = "Halis GR Light"),  
      axis.ticks = ggplot2::element_line(color = "white", 
                                                  size  =  0.2),  
      axis.title.x = ggplot2::element_text(size = 12, 
                                                    color = "white", 
                                                    margin = ggplot2::margin(0, 10, 0, 0),
                                                    face = "bold"),  
      axis.title.y = ggplot2::element_text(size = 12, 
                                                    color = "white", 
                                                    angle = 90, 
                                                    margin = ggplot2::margin(0, 10, 0, 0),
                                                    face = "bold"),  
      axis.ticks.length = ggplot2::unit(0.3, "lines"),   
      # Specify legend options
      legend.background = ggplot2::element_rect(color = NA, 
                                                fill = "transparent"),  
      legend.key = ggplot2::element_rect(color = "transparent",  
                                fill = "transparent"),  
      legend.box.background = ggplot2::element_rect(color = NA, 
                                                             fill = "transparent"),
      legend.key.size = ggplot2::unit(1.2, "lines"),  
      legend.key.height = NULL,  
      legend.key.width = NULL,      
      legend.text = ggplot2::element_text(size = 12*0.8, 
                                                   color = "white",
                                                   family = "Halis GR Light"),  
      legend.title = ggplot2::element_text(size = 12*0.8, 
                                                    face = "bold", 
                                                    hjust = 0,
                                                    color = "white"),  
      legend.position = "top",  
      legend.text.align = NULL,  
      legend.title.align = NULL,  
      legend.direction = "horizontal",  
      legend.box = NULL, 
      # Specify panel options
      panel.background = ggplot2::element_rect(fill = "transparent", 
                                               color  =  NA),  
      panel.border = ggplot2::element_blank(), ##element_rect(fill = NA, color = "white"),  
      panel.grid.major = ggplot2::element_line(color = "grey35"),  
      panel.grid.minor = ggplot2::element_line(color = "grey20"),  
      panel.spacing = ggplot2::unit(0.5, "lines"),   
      # Specify faceting options
      strip.background = ggplot2::element_rect(fill = "grey30", 
                                                        color = "grey10"),  
      strip.text.x = ggplot2::element_text(size = 12*0.8, 
                                                    color = "white", 
                                                    face = "bold", 
                                                    family = "Halis GR Bold"),  
      strip.text.y = ggplot2::element_text(size = 12*0.8, 
                                                    color = "white",
                                                    family = "Halis GR Bold",
                                  face = "bold",
                                  angle = -90),  
      # Specify plot options
      plot.background = ggplot2::element_rect(fill = "transparent", 
                                                       color = NA),  
      plot.title = ggplot2::element_text(size = 12*1.2, 
                                                  color = "white", 
                                         family = "Halis GR S Bold"),  
      plot.margin = ggplot2::unit(c(2, 2, 2, 10), "mm"),
      plot.subtitle = ggplot2::element_text(size = 11, 
                                                     color = "white",
                                                     family = "Halis GR Medium"),
      plot.caption = ggplot2::element_text(size = 10, 
                                                    color = "white"))
}

