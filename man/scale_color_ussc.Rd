% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ussc_colours.R
\name{scale_color_ussc}
\alias{scale_color_ussc}
\title{Colour scale constructor for USSC colours}
\usage{
scale_color_ussc(palette = "main", discrete = TRUE, reverse = FALSE, ...)
}
\arguments{
\item{palette}{Character name of palette in ussc_pal (i.e. main, blue, light, dark, grey, mixed)}

\item{discrete}{Boolean indicating whether colour aesthetic is discrete or not}

\item{reverse}{Boolean indicating whether the palette should be reversed}

\item{...}{Additional arguments passed to discrete_scale() or
scale_colour_gradientn(), used respectively when discrete is TRUE or FALSE}
}
\description{
Colour scale constructor for USSC colours
}
\examples{
# Colour by discrete variable using default palette
ggplot2::ggplot(iris, ggplot2::aes(Sepal.Width, Sepal.Length, colour = Species)) + ggplot2::geom_point(size = 4) + ussc::scale_colour_ussc()
# Reverse colour using blue palette
ggplot2::ggplot(iris, ggplot2::aes(Sepal.Width, Sepal.Length, colour = Species)) + ggplot2::geom_point(size = 4) + ussc::scale_colour_ussc('blue', reverse=T)
# Remember, you can change the transparency of the colour by adding alpha to the geom_...() call
ggplot2::ggplot(iris, ggplot2::aes(Sepal.Width, Sepal.Length, colour = Species)) + ggplot2::geom_point(size = 4, alpha=0.4) + ussc::scale_colour_ussc('blue', reverse=T)
}
\author{
Zoe Meers
}
