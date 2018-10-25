## Functions to create USSC ggplot2 theme
## Zoe Meers
## The United States Studies Centre at the University of Sydney

#' Load USSC fonts.
#' @description
#' Loads USSC fonts into R from the local font book. Download necessary fonts from the fonts folder in this package and add to font book (if you have not done so before).
#' @usage
#' ussc_fonts()
#' @details
#' One the function runs, you have access to four font types:
#' * neosanspro
#' * neosansproLight
#' * univers
#' * universLight
#' @author
#' Zoe Meers
ussc_fonts <- function() {
  univers <- quartzFont(paste(
    "Univers LT Pro",
    c("65 Bold", "45 Light Oblique", "45 Light", "55 Roman")
  ))
  universLight <- quartzFont(paste(
    "Univers LT Pro",
    c("45 Light", "55 Roman", "65 Bold", "45 Light Oblique")
  ))
  neosanspro <- quartzFont(paste(
    "Neo Sans Pro",
    c("Bold", "Italic", "Regular", "Medium")
  ))
  neosansproLight <- quartzFont(paste(
    "Neo Sans Pro",
    c("Light", "Light Italic", "Regular", "Medium")
  ))
  quartzFonts(univers = univers)
  quartzFonts(universLight = universLight)
  quartzFonts(neosanspro = neosanspro)
  quartzFonts(neosansproLight = neosansproLight)
}

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
theme_ussc <- function() {
  theme_bw(base_family = "univers") +
    theme(
      plot.margin = unit(c(2, 2, 2, 2), "pt"),
      panel.border = element_blank(),
      axis.ticks = element_line(colour = "#D3D3D3"),
      text = element_text(colour = "#444444"),
      axis.title.x = element_text(size = 11, "univers"),
      axis.title.y = element_text(size = 11, "univers"),
      axis.text.x = element_text(size = 11, "univers"),
      axis.text.y = element_text(size = 11, "univers"),
      legend.text = element_text(size = 11, "universLight"),
      legend.title = element_text(size = 10, "univers"),
      legend.key.size = unit(x = 10, units = "pt"),
      plot.title = element_text(size = 14, family = "univers"),
      plot.caption = element_text(size = 10, family = "universLight"),
      plot.subtitle = element_text(size = 11, family = "universLight"),
      plot.background = element_rect(fill = "transparent", colour = NA),
      panel.background = element_rect(fill = "transparent", colour = NA),
      strip.background = element_blank()
    )
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
theme_ussc_dark <- function() {
  theme_bw(base_family = "univers") +
    theme(
      # Specify axis options
      axis.line = element_blank(),  
      axis.text.x = element_text(size = 12*0.8, color = "white", lineheight = 0.9),  
      axis.text.y = element_text(size = 12*0.8, color = "white", lineheight = 0.9),  
      axis.ticks = element_line(color = "white", size  =  0.2),  
      axis.title.x = element_text(size = 12, color = "white", margin = margin(0, 10, 0, 0)),  
      axis.title.y = element_text(size = 12, color = "white", angle = 90, margin = margin(0, 10, 0, 0)),  
      axis.ticks.length = unit(0.3, "lines"),   
      # Specify legend options
      legend.background = element_rect(color = NA, fill = "transparent"),  
      legend.key = element_rect(color = "transparent",  fill = "transparent"),  
      legend.box.background = element_rect(color = NA, fill = "transparent"),
      legend.key.size = unit(1.2, "lines"),  
      legend.key.height = NULL,  
      legend.key.width = NULL,      
      legend.text = element_text(size = 12*0.8, color = "white"),  
      legend.title = element_text(size = 12*0.8, face = "bold", hjust = 0, color = "white"),  
      legend.position = "top",  
      legend.text.align = NULL,  
      legend.title.align = NULL,  
      legend.direction = "horizontal",  
      legend.box = NULL, 
      # Specify panel options
      panel.background = element_rect(fill = "transparent", color  =  NA),  
      panel.border = element_blank(), ##element_rect(fill = NA, color = "white"),  
      panel.grid.major = element_line(color = "grey35"),  
      panel.grid.minor = element_line(color = "grey20"),  
      panel.spacing = unit(0.5, "lines"),   
      # Specify facetting options
      strip.background = element_rect(fill = "grey30", color = "grey10"),  
      strip.text.x = element_text(size = 12*0.8, color = "white"),  
      strip.text.y = element_text(size = 12*0.8, color = "white",angle = -90),  
      # Specify plot options
      plot.background = element_rect(fill = "transparent", color = NA),  
      plot.title = element_text(size = 12*1.2, color = "white"),  
      plot.margin = unit(rep(1, 4), "lines"),
      plot.subtitle = element_text(size = 11, color = "white"),
      plot.caption = element_text(size = 10, color = "white"))
}

#' USSC theme with Univers font
#' @description
#' A theme_bw() with Univers font
#' @usage
#' theme_ussc_univers()
#' @examples
#' Create ggplot theme using Univers USSC theme
#' ggplot(iris, aes(Sepal.Width, Sepal.Length, colour = Species)) + geom_point(size = 4, alpha=0.4) +  theme_ussc_univers() + labs(title="Univers Header", x="Sepal Width", y="Sepal Length") + scale_colour_ussc()
#' @author
#' Zoe Meers
theme_ussc_univers <- function() {
  theme_bw(base_family = "univers") +
    theme(
      plot.margin = unit(c(2, 2, 2, 2), "pt"),
      panel.border = element_blank(),
      axis.ticks = element_line(colour = "#D3D3D3"),
      text = element_text(colour = "#444444"),
      axis.title.x = element_text(size = 11),
      axis.title.y = element_text(size = 11),
      axis.text.x = element_text(size = 11),
      axis.text.y = element_text(size = 11),
      legend.text = element_text(size = 11),
      legend.title = element_text(size = 10),
      legend.key.size = unit(x = 10, units = "pt"),
      plot.title = element_text(size = 14),
      plot.caption = element_text(size = 10),
      plot.subtitle = element_text(size = 11),
      plot.background = element_rect(fill = "transparent", colour = NA),
      panel.background = element_rect(fill = "transparent", colour = NA),
      strip.background = element_blank()
    )
}

#' USSC theme with light Univers font
#' @description
#' A theme_bw() with light Univers font
#' @usage
#' theme_uscc_univers_light()
#' @examples
#' Create ggplot theme using light Univers USSC theme
#' ggplot(iris, aes(Sepal.Width, Sepal.Length, colour = Species)) + geom_point(size = 4, alpha=0.4) +  theme_ussc_univers_light() + labs(title="Light Univers Header", x="Sepal Width", y="Sepal Length") + scale_colour_ussc()
#' @author
#' Zoe Meers
theme_ussc_univers_light <- function() {
  theme_bw(base_family = "universLight") +
    theme(
      plot.margin = unit(c(2, 2, 2, 2), "pt"),
      text = element_text(colour = "#444444"),
      panel.border = element_blank(),
      axis.ticks = element_line(colour = "#D3D3D3"),
      axis.title.x = element_text(size = 11),
      axis.title.y = element_text(size = 11),
      axis.text.x = element_text(size = 11),
      axis.text.y = element_text(size = 11),
      legend.text = element_text(size = 10),
      legend.title = element_text(size = 10),
      legend.key.size = unit(x = 10, units = "pt"),
      plot.subtitle = element_text(size = 11),
      plot.title = element_text(size = 14),
      plot.caption = element_text(size = 10),
      plot.background = element_rect(fill = "transparent", colour = NA),
      panel.background = element_rect(fill = "transparent", colour = NA),
      strip.background = element_blank()
    )
}

#' USSC theme with Neo Sans Pro font
#' @description
#' theme_bw() with Neo Sans Pro font
#' @usage
#' theme_ussc_neosanspro()
#' @examples
#' Create ggplot theme using Neo Sans Pro USSC theme
#' ggplot(iris, aes(Sepal.Width, Sepal.Length, colour = Species)) + geom_point(size = 4, alpha=0.4) +  theme_ussc_neosanspro() + labs(title="Neo Sans Pro Header", x="Sepal Width", y="Sepal Length") + scale_colour_ussc()
#' @author
#' Zoe Meers
theme_ussc_neosanspro <- function() {
  theme_bw(base_family = "neosanspro") +
    theme(
      plot.margin = unit(c(2, 2, 2, 2), "pt"),
      text = element_text(colour = "#444444"),
      axis.title.x = element_text(size = 9),
      panel.border = element_blank(),
      axis.ticks = element_line(colour = "#D3D3D3"),
      axis.title.y = element_text(size = 11),
      axis.text.x = element_text(size = 11),
      axis.text.y = element_text(size = 11),
      legend.text = element_text(size = 10),
      legend.title = element_text(size = 10),
      plot.caption = element_text(size = 10, family = "neosansproLight"),
      legend.key.size = unit(x = 9, units = "pt"),
      plot.title = element_text(size = 14),
      plot.subtitle = element_text(size = 10, family = "neosansproLight"),
      plot.background = element_rect(fill = "transparent", colour = NA),
      panel.background = element_rect(fill = "transparent", colour = NA),
      strip.background = element_blank()
    )
}


#' USSC theme with light Neo Sans Pro font
#' @description
#' theme_bw() with light Neo Sans Pro font
#' @usage
#' theme_ussc_neosanspro_light()
#' @examples
#' Create ggplot theme using light Neo Sans Pro USSC theme
#' ggplot(iris, aes(Sepal.Width, Sepal.Length, colour = Species)) + geom_point(size = 4, alpha=0.4) +  theme_ussc_neosanspro_light + labs(title="Light Neo Sans Pro Header", x="Sepal Width", y="Sepal Length") + scale_colour_ussc()
#' @author
#' Zoe Meers
theme_ussc_neosanspro_light <- function() {
  theme_bw(base_family = "neosansproLight") +
    theme(
      plot.margin = unit(c(2, 2, 2, 2), "pt"),
      text = element_text(colour = "#444444"),
      axis.title.x = element_text(size = 11),
      panel.border = element_blank(),
      axis.ticks = element_line(colour = "#D3D3D3"),
      axis.title.y = element_text(size = 11),
      axis.text.x = element_text(size = 11),
      axis.text.y = element_text(size = 11),
      legend.text = element_text(size = 10),
      legend.title = element_text(size = 10),
      legend.key.size = unit(x = 9, units = "pt"),
      plot.title = element_text(size = 14),
      plot.subtitle = element_text(size = 10),
      plot.caption = element_text(size = 10),
      plot.background = element_rect(fill = "transparent", colour = NA),
      panel.background = element_rect(fill = "transparent", colour = NA),
      strip.background = element_blank()
    )
}
