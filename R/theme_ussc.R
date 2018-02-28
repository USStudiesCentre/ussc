## Functions to create USSC ggplot2 theme
## Zoe Meers
## The United States Studies Centre at the University of Sydney

# add the desired font to the font database (you can add multiple)
ussc_fonts <- function(){
  install.packages('showtext')
  library('showtext')
  font_add("univers", regular="fonts/Linotype - UniversLTPro-55Roman.otf", 
         bold="fonts/Linotype - UniversLTPro-65Bold.otf",
         italic="fonts/Linotype - UniversLTPro-45LightOblique.otf")
  font_add("universLight", regular="fonts/Linotype - UniversLTPro-45Light.otf")
  font_add("neosanspro", regular="fonts/Neo Sans Pro.ttf",
         bold="fonts/Neo Sans Pro Bold.ttf",
         italic="Neo Sans Pro Italic.ttf")
  font_add("neosansproLight", regular="fonts/Neo Sans Pro Light.ttf")
}

#' Main USSC theme
#' @examples 
#' Create ggplot theme using main USSC theme
#' ggplot(iris, aes(Sepal.Width, Sepal.Length, colour = Species)) + geom_point(size = 4, alpha=0.4) +  theme_ussc() + labs(title="Neo Sans Pro Header", x="Univers Font: Sepal Width", y="Univers Font: Sepal Length") + scale_colour_ussc("blue")

theme_ussc <- function(){
  theme_minimal(base_family="univers") + 
  theme(plot.margin = unit(c(2,2,2,2),"pt"),
        axis.title.x = element_text(size=9, family="univers"),
        axis.title.y = element_text(size=9, family="univers"),
        axis.text.x = element_text(size = 9, family="univers"),
        axis.text.y = element_text(size = 7, family="univers"),
        legend.text = element_text(size=9, family="universLight"),
        legend.title = element_text(size=9, family="univers"),
        legend.key.size = unit(x = 9,units = "pt"),
        title= element_text(size=14, family = "neosanspro")
  )
}
#' USSC theme with Univers font
#' @examples 
#' Create ggplot theme using Univers USSC theme
#' ggplot(iris, aes(Sepal.Width, Sepal.Length, colour = Species)) + geom_point(size = 4, alpha=0.4) +  theme_ussc_univers() + labs(title="Univers Header", x="Sepal Width", y="Sepal Length") + scale_colour_ussc()

theme_ussc_univers <- function(){
  theme_minimal(base_family="univers") + 
  theme(plot.margin = unit(c(2,2,2,2),"pt"),
        axis.title.x = element_text(size=9),
        axis.title.y = element_text(size=9),
        axis.text.x = element_text(size = 9),
        axis.text.y = element_text(size = 7),
        legend.text = element_text(size=9),
        legend.title = element_text(size=9),
        legend.key.size = unit(x = 9,units = "pt"),
        title= element_text(size=14, family = "univers")
  )
}

#' USSC theme with light Univers font
#' @examples 
#' Create ggplot theme using light Univers USSC theme
#' ggplot(iris, aes(Sepal.Width, Sepal.Length, colour = Species)) + geom_point(size = 4, alpha=0.4) +  theme_ussc_univers_light() + labs(title="Light Univers Header", x="Sepal Width", y="Sepal Length") + scale_colour_ussc()

theme_ussc_univers_light <- function(){
  theme_minimal(base_family="universLight") + 
  theme(plot.margin = unit(c(2,2,2,2),"pt"),
        axis.title.x = element_text(size=9),
        axis.title.y = element_text(size=9),
        axis.text.x = element_text(size = 9),
        axis.text.y = element_text(size = 7),
        legend.text = element_text(size=9),
        legend.title = element_text(size=9),
        legend.key.size = unit(x = 9,units = "pt"),
        title= element_text(size=14)
  )
}

#' USSC theme with Neo Sans Pro font
#' @examples 
#' Create ggplot theme using Neo Sans Pro USSC theme
#' ggplot(iris, aes(Sepal.Width, Sepal.Length, colour = Species)) + geom_point(size = 4, alpha=0.4) +  theme_ussc_neosanspro() + labs(title="Neo Sans Pro Header", x="Sepal Width", y="Sepal Length") + scale_colour_ussc()

theme_ussc_neosanspro <- function(){
  theme_minimal(base_family="neosanspro") + 
  theme(plot.margin = unit(c(2,2,2,2),"pt"),
        axis.title.x = element_text(size=9),
        axis.title.y = element_text(size=9),
        axis.text.x = element_text(size = 9),
        axis.text.y = element_text(size = 7),
        legend.text = element_text(size=9),
        legend.title = element_text(size=9),
        legend.key.size = unit(x = 9,units = "pt"),
        title= element_text(size=14)
  )
}


#' USSC theme with light Neo Sans Pro font
#' @examples 
#' Create ggplot theme using light Neo Sans Pro USSC theme
#' ggplot(iris, aes(Sepal.Width, Sepal.Length, colour = Species)) + geom_point(size = 4, alpha=0.4) +  theme_ussc_neosanspro_light() + labs(title="Light Neo Sans Pro Header", x="Sepal Width", y="Sepal Length") + scale_colour_ussc()

theme_ussc_neosanspro_light <- function(){
  theme_minimal(base_family="neosansproLight") + 
  theme(plot.margin = unit(c(2,2,2,2),"pt"),
        axis.title.x = element_text(size=9),
        axis.title.y = element_text(size=9),
        axis.text.x = element_text(size = 9),
        axis.text.y = element_text(size = 7),
        legend.text = element_text(size=9),
        legend.title = element_text(size=9),
        legend.key.size = unit(x = 9,units = "pt"),
        title= element_text(size=14)
  )
}

