#' Load USSC fonts.
#' @description
#' Loads USSC fonts into R from the local font book. Download necessary fonts from the fonts folder in this package and add to font book (if you have not done so before).
#' @usage
#' ussc_fonts()
#' @author
#' Zoe Meers

ussc_fonts <- function() {
 sysfonts::font_add("Halis GR", 
                     regular = "Ahmet Altun - HalisGR-Regular.otf",
                     bold = "Ahmet Altun - HalisGR-Bold.otf",
                     italic = "Ahmet Altun - HalisGR-Light.otf",
                     bolditalic = "Ahmet Altun - HalisGR-BoldItalic.otf")
}