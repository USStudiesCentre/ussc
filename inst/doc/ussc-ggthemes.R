## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  warning = FALSE,
  message = FALSE,
  comment = FALSE
)

## ------------------------------------------------------------------------
library('ussc')
library('tidyverse')

## ----ussc theme and main colour scale, fig.align='center'----------------
ggplot(iris, aes(Sepal.Width, Sepal.Length, colour = Species)) + 
  geom_point(size = 4, alpha=0.4) +  
  theme_ussc() + 
  labs(title="Univers Header", x="Univers Font: Sepal Width", y="Univers Font: Sepal Length", caption = "The data is from the Iris R package and is an example.") + 
  scale_colour_ussc("main", reverse=TRUE) 

## ----univers ussc theme and blue colour scale, fig.align='center', dev.args=list(bg='#2a2a2b')----
ggplot(iris, aes(Sepal.Width, Sepal.Length, colour = Species)) + 
  geom_point(size = 4, alpha=0.4) +  
  theme_ussc_dark() + 
  labs(title="Univers Header", 
       x="Univers Font: Sepal Width", 
       y="Univers Font: Sepal Length", 
       caption = "The data is from the Iris R package and is an example.") + 
  scale_colour_ussc("blue", reverse=TRUE)

## ----solid colour, fig.align='center'------------------------------------
ggplot(data=iris, aes(x=Species, fill=Species)) + 
  geom_bar(fill=ussc_colours("light blue")) + 
  labs(x = "Species", 
      y = "Count",
      title = "Bar plot of Sepal Length") + 
  theme_ussc()  

## ----univers light theme and main colour scale w/o alpha, fig.align='center'----
ggplot(iris, aes(Sepal.Width, Sepal.Length, colour = Species)) + 
  geom_point(size = 4) +  
  theme_ussc_univers_light() + 
  labs(title="Univers Header", 
       x="Univers Font: Sepal Width", 
       y="Univers Font: Sepal Length", 
       caption = "The data is from the Iris R package and is an example.") + 
  scale_colour_ussc("main") 

## ----neo sans pro light theme and grey colour scale, fig.align='center'----
ggplot(iris, aes(Sepal.Width, Sepal.Length, colour = Species)) + 
  geom_point(size = 4, alpha=0.7) +
  theme_ussc_neosanspro_light() + 
  labs(title = "Neo Sans Pro Header", 
       x = "NSP Font: Sepal Width", 
       y = "NSP Font: Sepal Length", 
       caption = "The data is from the Iris R package and is an example.") + 
  scale_colour_ussc("grey")

## ----facet ussc theme and main colour scale, fig.align='center'----------
ggplot(mtcars, aes(mpg, hp, colour=mpg)) + 
  geom_point() + 
  facet_grid(cyl~gear) + 
  theme_ussc() + 
  scale_fill_ussc("main", discrete=TRUE) + labs(title='A facet_grid example')

## ----GAM, fig.align='center'---------------------------------------------
ggplot(data=iris, aes(x=Sepal.Length, y=Sepal.Width, color=Species)) + 
  geom_point(aes(shape=Species), size=1.5) + 
  xlab("Sepal Length") + 
  ylab("Sepal Width") + 
  ggtitle("Scatterplot with smoothers") + 
  scale_colour_ussc("main") + 
  theme_ussc() + 
  geom_smooth(method="gam", formula= y~s(x, bs="cs"))

## ----glc-----------------------------------------------------------------
ggplot(data=ChickWeight, 
       aes(x=Time, y=weight, color=Diet, group=Chick)) +
  geom_line() + 
  ggtitle("Growth curve for individual chicks") + 
  scale_colour_ussc("light") + 
  theme_ussc()

## ----bp------------------------------------------------------------------
box <- ggplot(data=iris, aes(x=Species, y=Sepal.Length))
box + geom_boxplot(aes(fill=Species)) + 
  ylab("Sepal Length") + ggtitle("Iris Boxplot") +
  stat_summary(fun.y=mean, geom="point", shape=5, size=4) +
  scale_fill_ussc(reverse=TRUE) + theme_ussc()

