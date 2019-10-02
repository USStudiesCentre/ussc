## Functions to create USSC colour palettes for ggplot2
## Zoe Meers
## The United States Studies Centre at the University of Sydney

#' USSC colours
ussc_cols <- c(
  `light blue` = "#4aace9",
  `dark blue` = "#2f2665",
  `orange` = "#ee4627",
  `pink` = "#e1a6a0",
  `grey` = "#c0c0c0",
  `green` = "#94c497"
)

#' Function to extract USSC colours as hex codes
#'
#' @param ... Character names of ussc_colours
#' @author
#' Zoe Meers
#' @export
ussc_colours <- function(...) {
  cols <- c(...)

  if (is.null(cols)) {
    return(ussc_cols)
  }

  ussc_cols[cols]
}

#' USSC palettes
#' @description
#' This list creates palette types.
#' @examples ...
#' ggplot(mtcars, aes(hp, mpg)) + geom_point(colour = ussc_colours("red"), size = 4)
#' ggplot(mtcars, aes(hp, mpg)) + geom_point(colour = ussc_colours("red"), size = 4, alpha=0.7)
#' However we will make it easier for you by creating fill and colour scales
#' @author
#' Zoe Meers
#' @export
ussc_pal <- list(
  `main` = ussc_colours("dark blue", "orange","light blue"),

  `blue` = ussc_colours("light blue", "dark blue"),

  `light` = ussc_colours("light blue", "orange", "pink", "grey"),

  `mixed` = ussc_colours("dark blue", "light blue", "orange", "pink", "grey", "green")
)

#' Return function to interpolate a ussc colour palette
#'
#' @param palette Character name of palette in ussc_pal (i.e. main, blue, light, dark, grey, mixed)
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments to pass to colorRampPalette()
#' @author
#' Zoe Meers
#' @export

ussc_palettes <- function(palette = "main", reverse = FALSE, ...) {
  pal <- ussc_pal[[palette]]

  if (reverse) pal <- rev(pal)

  colorRampPalette(pal, ...)
}

#' colour scale constructor for USSC colours
#'
#' @param palette Character name of palette in ussc_pal (i.e. main, blue, light, dark, grey, mixed)
#' @param discrete Boolean indicating whether colour aesthetic is discrete or not
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments passed to discrete_scale() or
#'            scale_colour_gradientn(), used respectively when discrete is TRUE or FALSE
#' @examples
#' Colour by discrete variable using default palette
#' ggplot(iris, aes(Sepal.Width, Sepal.Length, colour = Species)) + geom_point(size = 4) + scale_colour_ussc()
#' Reverse colour using blue palette
#' ggplot(iris, aes(Sepal.Width, Sepal.Length, colour = Species)) + geom_point(size = 4) + scale_colour_ussc('blue', reverse=T)
#' Remember, you can change the transparency of the colour by adding alpha to the geom_...() call
#' ggplot(iris, aes(Sepal.Width, Sepal.Length, colour = Species)) + geom_point(size = 4, alpha=0.4) + scale_colour_ussc('blue', reverse=T)
#' @author
#' Zoe Meers
#' @export

scale_colour_ussc <- function(palette = "main", discrete = TRUE, reverse = FALSE, ...) {
  pal <- ussc_palettes(palette = palette, reverse = reverse)

  if (discrete) {
    discrete_scale("colour", paste0("ussc_", palette), palette = pal, ...)
  } else {
    scale_colour_gradientn(colours = pal(256), ...)
  }
}

#' Fill scale constructor for USSC colours
#'
#' @param palette Character name of palette in ussc_pal (i.e. main, blue, light, dark, grey, mixed)
#' @param discrete Boolean indicating whether colour aesthetic is discrete or not
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments passed to discrete_scale() or
#'            scale_fill_gradient(), used respectively when discrete is TRUE or FALSE
#' @examples
#' Fill by discrete variable with different palette + remove legend (guide)
#' ggplot(mpg, aes(manufacturer, fill = manufacturer)) + geom_bar() + theme(axis.text.x = element_text(angle = 45, hjust = 1)) + scale_fill_ussc(palette = "main", guide = "none")
#' Set colour transparency by calling alpha in the geom_...() command
#' ggplot(mpg, aes(manufacturer, fill = manufacturer)) + geom_bar(alpha=0.7) + theme(axis.text.x = element_text(angle = 45, hjust = 1)) + scale_fill_ussc(palette = "main", guide = "none")
#' @author
#' Zoe Meers
#' @export
#' 

scale_fill_ussc <- function(palette = "main", discrete = TRUE, reverse = FALSE, ...) {
  pal <- ussc_palettes(palette = palette, reverse = reverse)

  if (discrete) {
    discrete_scale("fill", paste0("ussc_", palette), palette = pal, ...)
  } else {
    scale_colour_gradientn(colours = pal(256), ...)
  }
}
