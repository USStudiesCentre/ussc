.onLoad <- function(libname, pkgname){
  font_add("univers", regular="fonts/Linotype - UniversLTPro-55Roman.otf", 
           bold="fonts/Linotype - UniversLTPro-65Bold.otf",
           italic="fonts/Linotype - UniversLTPro-45LightOblique.otf")
  font_add("universLight", regular="fonts/Linotype - UniversLTPro-45Light.otf")
  font_add("neosanspro", regular="fonts/Neo Sans Pro.ttf",
           bold="fonts/Neo Sans Pro Bold.ttf",
           italic="fonts/Neo Sans Pro Italic.ttf")
  font_add("neosansproLight", regular="fonts/Neo Sans Pro Light.ttf")
  packageStartupMessage('This package is primarily for USSC research purposes.\n
                        Please contact the maintainer of the package if you have any questions.', 
                        domain = NULL, appendLF = TRUE)
  ussc_cols <- c(
    `light blue` = "#009de3",
    `dark blue` = "#1c396e",
    `red` = "#ed1b35",
    `light grey` = "#cccccc",
    `dark grey`  = "#8c8c8c",
    `black` = "#000000"
  )
  ussc_colours <- function(...) {
    cols <- c(...)
    
    if (is.null(cols))
      return (ussc_cols)
    
    ussc_cols[cols]
  }
  ussc_pal <- list(
    `main`  = ussc_colours("dark blue", "light blue", "red"),
    
    `blue` = ussc_colours("light blue", "dark blue"),
    
    `light`  = ussc_colours("light blue", "red"),
    
    `dark`   = ussc_colours("dark blue", "red"),
    
    `grey`  = ussc_colours("light grey", "dark grey", "black"),
    
    `mixed` = ussc_colours("dark blue", "light blue", "red", "light grey", "dark grey", "black")
  )
  
  ussc_palettes <- function(palette = "main", reverse = FALSE, ...) {
    pal <- ussc_pal[[palette]]
    
    if (reverse) pal <- rev(pal)
    
    colorRampPalette(pal, ...)
  }
  
}