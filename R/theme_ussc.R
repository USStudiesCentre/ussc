## Functions to create USSC ggplot2 theme
## Zoe Meers
## The United States Studies Centre at the University of Sydney

library(ggplot2)
# Load the univers font used in USSC reports
# To do this, download the fonts from the fonts file in this repo and add to your font book (assuming you use OSX)
# If this function does not work after you have added the fonts to your font book, check that the font names in this R code are the same as those in your font book
#'Loads USSC fonts into R from the local font book. Download necessary fonts from the fonts folder in this package and add to font book (if you have not done so before).
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
#' @examples 
#' Create ggplot theme using main USSC theme
#' ggplot(iris, aes(Sepal.Width, Sepal.Length, colour = Species)) + geom_point(size = 4, alpha=0.4) +  theme_ussc + labs(title="Neo Sans Pro Header", x="Univsers Font: Sepal Width", y="Univers Font: Sepal Length") + scale_colour_ussc("blue")

theme_ussc <- theme_minimal(base_family="univers") + 
  theme(plot.margin = unit(c(2,2,2,2),"pt"),
        text=element_text(family="univers"),
        strip.text = element_text(size=9),
        axis.title.x = element_text(size=9,family = "univers"),
        axis.title.y = element_text(size=9,family="univers"),
        axis.text.x = element_text(size = 9, family="univers"),
        axis.text.y = element_text(size = 7),
        legend.text = element_text(size=9,family="univers"),
        legend.title = element_text(size=9,family="univers"),
        legend.key.size = unit(x = 9,units = "pt"),
        title= element_text(size=14, family = "neosanspro")
  )

#' USSC theme with Univers font
#' @examples 
#' Create ggplot theme using Univers USSC theme
#' ggplot(iris, aes(Sepal.Width, Sepal.Length, colour = Species)) + geom_point(size = 4, alpha=0.4) +  theme_ussc_univers + labs(title="Univers Header", x="Sepal Width", y="Sepal Length") + scale_colour_ussc()

theme_ussc_univers <- theme_minimal(base_family="univers") + 
  theme(plot.margin = unit(c(2,2,2,2),"pt"),
        text=element_text(family="univers"),
        strip.text = element_text(size=9),
        axis.title.x = element_text(size=9,family = "univers"),
        axis.title.y = element_text(size=9,family="univers"),
        axis.text.x = element_text(size = 9, family="univers"),
        axis.text.y = element_text(size = 7),
        legend.text = element_text(size=9,family="univers"),
        legend.title = element_text(size=9,family="univers"),
        legend.key.size = unit(x = 9,units = "pt"),
        title= element_text(size=14, family = "univers")
  )

#' USSC theme with light Univers font
#' @examples 
#' Create ggplot theme using light Univers USSC theme
#' ggplot(iris, aes(Sepal.Width, Sepal.Length, colour = Species)) + geom_point(size = 4, alpha=0.4) +  theme_ussc_univers_light + labs(title="Light Univers Header", x="Sepal Width", y="Sepal Length") + scale_colour_ussc()

theme_ussc_univers_light <- theme_minimal(base_family="universLight") + 
  theme(plot.margin = unit(c(2,2,2,2),"pt"),
        text=element_text(family="universLight"),
        strip.text = element_text(size=9),
        axis.title.x = element_text(size=9,family = "universLight"),
        axis.title.y = element_text(size=9,family= "universLight"),
        axis.text.x = element_text(size = 9, family= "universLight"),
        axis.text.y = element_text(size = 7),
        legend.text = element_text(size=9,family= "universLight"),
        legend.title = element_text(size=9,family= "universLight"),
        legend.key.size = unit(x = 9,units = "pt"),
        title= element_text(size=14, family =  "universLight")
  )

#' USSC theme with Neo Sans Pro font
#' @examples 
#' Create ggplot theme using Neo Sans Pro USSC theme
#' ggplot(iris, aes(Sepal.Width, Sepal.Length, colour = Species)) + geom_point(size = 4, alpha=0.4) +  theme_ussc_neosanspro + labs(title="Neo Sans Pro Header", x="Sepal Width", y="Sepal Length") + scale_colour_ussc()

theme_ussc_neosanspro <- theme_minimal(base_family="neosanspro") + 
  theme(plot.margin = unit(c(2,2,2,2),"pt"),
        text=element_text(family="neosanspro"),
        strip.text = element_text(size=9),
        axis.title.x = element_text(size=9,family = "neosanspro"),
        axis.title.y = element_text(size=9,family="neosanspro"),
        axis.text.x = element_text(size = 9, family="neosanspro"),
        axis.text.y = element_text(size = 7),
        legend.text = element_text(size=9,family="neosanspro"),
        legend.title = element_text(size=9,family="neosanspro"),
        legend.key.size = unit(x = 9,units = "pt"),
        title= element_text(size=14, family = "neosanspro")
  )


#' USSC theme with light Neo Sans Pro font
#' @examples 
#' Create ggplot theme using light Neo Sans Pro USSC theme
#' ggplot(iris, aes(Sepal.Width, Sepal.Length, colour = Species)) + geom_point(size = 4, alpha=0.4) +  theme_ussc_neosanspro_light + labs(title="Light Neo Sans Pro Header", x="Sepal Width", y="Sepal Length") + scale_colour_ussc()

theme_ussc_neosanspro_light <- theme_minimal(base_family="neosansproLight") + 
  theme(plot.margin = unit(c(2,2,2,2),"pt"),
        text=element_text(family="neosansproLight"),
        strip.text = element_text(size=9),
        axis.title.x = element_text(size=9,family = "neosansproLight"),
        axis.title.y = element_text(size=9,family="neosansproLight"),
        axis.text.x = element_text(size = 9, family="neosansproLight"),
        axis.text.y = element_text(size = 7),
        legend.text = element_text(size=9,family="neosansproLight"),
        legend.title = element_text(size=9,family="neosansproLight"),
        legend.key.size = unit(x = 9,units = "pt"),
        title= element_text(size=14, family = "neosansproLight")
  )
