## Functions to create USSC ggplot2 theme
## Zoe Meers
## The United States Studies Centre at the University of Sydney


#' Main USSC theme
#' @description
#' Calls the main USSC theme. A reconstructed theme_bw() ggplot2 theme.
#' @usage
#' theme_ussc()
#' @examples
#' Create ggplot theme using main USSC theme
#' ggplot(iris, aes(Sepal.Width, Sepal.Length, colour = Species)) + geom_point(size = 4, alpha=0.4) +  theme_ussc() + labs(title="Univers Header", x="Univers Font: Sepal Width", y="Univers Font: Sepal Length") + scale_colour_ussc("blue")
#' @author
#' Zoe Meers
#' @export

theme_ussc <- function () {
    theme_bw() + theme(plot.margin = unit(c(2, 2, 2, 10), "mm"), 
        panel.border = element_blank(), text = element_text(colour = "#444444", 
            family = "Halis GR Book"), 
            axis.title.x = element_text(size = 11, 
            face = "bold"), 
            axis.title.y = element_text(size = 11, 
            face = "bold"), 
            axis.text.x = element_text(size = 10, family = "Halis GR Light"), 
            axis.text.y = element_text(size = 10, family = "Halis GR Light"), 
            axis.ticks = element_blank(), 
            legend.text = element_text(size = 10, family = "Halis GR Light"), 
            legend.title = element_text(size = 10), 
            legend.key.size = unit(x = 10, units = "pt"), 
            legend.background = element_rect(color = NA, 
            fill = "transparent"), legend.key = element_rect(color = "transparent", 
            fill = "transparent"), legend.box.background = element_rect(color = NA, 
            fill = "transparent"), 
            plot.title = element_text(size = 16, family = "Halis GR S Bold"), 
            plot.caption = element_text(size = 10, family = "Halis GR Light"), 
            plot.subtitle = element_text(size = 11, family = "Halis GR Medium"), 
            plot.background = element_rect(fill = "transparent", 
            colour = NA), panel.background = element_rect(fill = "transparent", 
            colour = NA), strip.background = element_blank(), 
        strip.text = element_text(face = "bold"))
}


#' Dark USSC theme
#' @description
#' Calls the dark USSC theme. A reconstructed theme_bw() ggplot2 theme.
#' @usage
#' theme_ussc_dark()
#' @examples
#' Create ggplot theme using dark USSC theme
#' ggplot(iris, aes(Sepal.Width, Sepal.Length, colour = Species)) + geom_point(size = 4, alpha=0.4) +  theme_ussc_dark() + labs(title="Neo Sans Pro Header", x="Univers Font: Sepal Width", y="Univers Font: Sepal Length") + scale_colour_ussc("blue")
#' @author
#' Zoe Meers
#' @export

theme_ussc_dark <- function() {
  theme_minimal() +
    theme(
      text = element_text(family = "Halis GR Book"),
      # Specify axis options
      axis.line = element_blank(),  
      axis.text.x = element_text(size = 12*0.8, color = "white", 
                                 lineheight = 0.9),  
      axis.text.y = element_text(size = 12*0.8, color = "white", 
                                 lineheight = 0.9),  
      axis.ticks = element_line(color = "white", size  =  0.2),  
      axis.title.x = element_text(size = 12, color = "white", 
                                  margin = margin(0, 10, 0, 0),
                                  face = "bold"),  
      axis.title.y = element_text(size = 12, color = "white", 
                                  angle = 90, margin = margin(0, 10, 0, 0),
                                  face = "bold"),  
      axis.ticks.length = unit(0.3, "lines"),   
      # Specify legend options
      legend.background = element_rect(color = NA, fill = "transparent"),  
      legend.key = element_rect(color = "transparent",  fill = "transparent"),  
      legend.box.background = element_rect(color = NA, fill = "transparent"),
      legend.key.size = unit(1.2, "lines"),  
      legend.key.height = NULL,  
      legend.key.width = NULL,      
      legend.text = element_text(size = 12*0.8, color = "white"),  
      legend.title = element_text(size = 12*0.8, face = "bold", hjust = 0, 
                                  color = "white"),  
      legend.position = "top",  
      legend.text.align = NULL,  
      legend.title.align = NULL,  
      legend.direction = "horizontal",  
      legend.box = NULL, 
      # Specify panel options
      panel.background = element_rect(fill = "transparent", 
                                      color  =  NA),  
      panel.border = element_blank(), ##element_rect(fill = NA, color = "white"),  
      panel.grid.major = element_line(color = "grey35"),  
      panel.grid.minor = element_line(color = "grey20"),  
      panel.spacing = unit(0.5, "lines"),   
      # Specify faceting options
      strip.background = element_rect(fill = "grey30", color = "grey10"),  
      strip.text.x = element_text(size = 12*0.8, color = "white", 
                                  face = "bold"),  
      strip.text.y = element_text(size = 12*0.8, color = "white",
                                  face = "bold",angle = -90),  
      # Specify plot options
      plot.background = element_rect(fill = "transparent", color = NA),  
      plot.title = element_text(size = 12*1.2, color = "white", 
                                face = "bold"),  
      plot.margin = unit(c(2, 2, 2, 10), "mm"),
      plot.subtitle = element_text(size = 11, color = "white"),
      plot.caption = element_text(size = 10, color = "white"))
}

