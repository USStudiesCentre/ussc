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
ussc_fonts <- function(){
  univers <- quartzFont(paste("Univers LT Pro",
                              c("65 Bold","45 Light Oblique","45 Light", "55 Roman")))
  universLight <- quartzFont(paste("Univers LT Pro",
                                   c("45 Light", "55 Roman","65 Bold","45 Light Oblique")))
  neosanspro <- quartzFont(paste("Neo Sans Pro",
                                 c("Bold", "Italic", "Regular", "Medium")))
  neosansproLight <- quartzFont(paste("Neo Sans Pro",
                                      c("Light", "Light Italic", "Regular", "Medium")))
  quartzFonts(univers=univers)
  quartzFonts(universLight=universLight)
  quartzFonts(neosanspro=neosanspro)
  quartzFonts(neosansproLight=neosansproLight)
}

#' Main USSC theme
#' @description
#' Calls the main USSC theme. A reconstructed theme_minimal() ggplot2 theme. 
#' @usage 
#' theme_ussc()
#' @examples 
#' Create ggplot theme using main USSC theme
#' ggplot(iris, aes(Sepal.Width, Sepal.Length, colour = Species)) + geom_point(size = 4, alpha=0.4) +  theme_ussc() + labs(title="Neo Sans Pro Header", x="Univers Font: Sepal Width", y="Univers Font: Sepal Length") + scale_colour_ussc("blue")
#' @author 
#' Zoe Meers
theme_ussc <- function(){
  theme_bw(base_family="univers") + 
    theme(plot.margin = unit(c(2,2,2,2),"pt"),
          text = element_text(colour="#444444"),
          axis.title.x = element_text(size=9, "univers"),
          axis.title.y = element_text(size=9, "univers"),
          axis.text.x = element_text(size = 9, "univers"),
          axis.text.y = element_text(size = 7, "univers"),
          legend.text = element_text(size=7, "universLight"),
          legend.title = element_text(size=9, "univers"),
          legend.key.size = unit(x = 9,units = "pt"),
          plot.title= element_text(size=14, family = "neosanspro")
    )
}
#' USSC theme with Univers font
#' @description
#' A theme_minimal() with Univers font
#' @usage 
#' theme_ussc_univers()
#' @examples 
#' Create ggplot theme using Univers USSC theme
#' ggplot(iris, aes(Sepal.Width, Sepal.Length, colour = Species)) + geom_point(size = 4, alpha=0.4) +  theme_ussc_univers() + labs(title="Univers Header", x="Sepal Width", y="Sepal Length") + scale_colour_ussc()
#' @author 
#' Zoe Meers
theme_ussc_univers <- function(){
  theme_bw(base_family="univers") + 
    theme(plot.margin = unit(c(2,2,2,2),"pt"),
          text = element_text(colour="#444444"),
          axis.title.x = element_text(size=9),
          axis.title.y = element_text(size=9),
          axis.text.x = element_text(size = 9),
          axis.text.y = element_text(size = 7),
          legend.text = element_text(size=9),
          legend.title = element_text(size=9),
          legend.key.size = unit(x = 9,units = "pt"),
          plot.title= element_text(size=14)
    )
}

#' USSC theme with light Univers font
#' @description
#' A theme_minimal() with light Univers font
#' @usage 
#' theme_uscc_univers_light()
#' @examples 
#' Create ggplot theme using light Univers USSC theme
#' ggplot(iris, aes(Sepal.Width, Sepal.Length, colour = Species)) + geom_point(size = 4, alpha=0.4) +  theme_ussc_univers_light() + labs(title="Light Univers Header", x="Sepal Width", y="Sepal Length") + scale_colour_ussc()
#' @author 
#' Zoe Meers
theme_ussc_univers_light <- function(){
  theme_bw(base_family="universLight") + 
    theme(plot.margin = unit(c(2,2,2,2),"pt"),
          text = element_text(colour="#444444"),
          axis.title.x = element_text(size=9),
          axis.title.y = element_text(size=9),
          axis.text.x = element_text(size = 9),
          axis.text.y = element_text(size = 7),
          legend.text = element_text(size=9),
          legend.title = element_text(size=9),
          legend.key.size = unit(x = 9,units = "pt"),
          plot.title= element_text(size=14)
    )
}

#' USSC theme with Neo Sans Pro font
#' @description
#' Theme_minimal() with Neo Sans Pro font
#' @usage 
#' theme_ussc_neosanspro()
#' @examples 
#' Create ggplot theme using Neo Sans Pro USSC theme
#' ggplot(iris, aes(Sepal.Width, Sepal.Length, colour = Species)) + geom_point(size = 4, alpha=0.4) +  theme_ussc_neosanspro() + labs(title="Neo Sans Pro Header", x="Sepal Width", y="Sepal Length") + scale_colour_ussc()
#' @author 
#' Zoe Meers
theme_ussc_neosanspro <- function(){
  theme_bw(base_family="neosanspro") + 
    theme(plot.margin = unit(c(2,2,2,2),"pt"),
          text = element_text(colour="#444444"),
          axis.title.x = element_text(size=9),
          axis.title.y = element_text(size=9),
          axis.text.x = element_text(size = 9),
          axis.text.y = element_text(size = 7),
          legend.text = element_text(size=9),
          legend.title = element_text(size=9),
          legend.key.size = unit(x = 9,units = "pt"),
          plot.title= element_text(size=14)
    )
}


#' USSC theme with light Neo Sans Pro font
#' @description
#' Theme_minimal() with light Neo Sans Pro font
#' @usage 
#' theme_ussc_neosanspro_light()
#' @examples 
#' Create ggplot theme using light Neo Sans Pro USSC theme
#' ggplot(iris, aes(Sepal.Width, Sepal.Length, colour = Species)) + geom_point(size = 4, alpha=0.4) +  theme_ussc_neosanspro_light + labs(title="Light Neo Sans Pro Header", x="Sepal Width", y="Sepal Length") + scale_colour_ussc()
#' @author 
#' Zoe Meers
theme_ussc_neosanspro_light <- function(){
  theme_bw(base_family="neosansproLight") + 
    theme(plot.margin = unit(c(2,2,2,2),"pt"),
          text = element_text(colour="#444444"),
          axis.title.x = element_text(size=9),
          axis.title.y = element_text(size=9),
          axis.text.x = element_text(size = 9),
          axis.text.y = element_text(size = 7),
          legend.text = element_text(size=9),
          legend.title = element_text(size=9),
          legend.key.size = unit(x = 9,units = "pt"),
          plot.title= element_text(size=14)
    )
}

