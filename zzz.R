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
  
}