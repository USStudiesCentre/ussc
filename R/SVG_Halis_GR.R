## Function to write Halis GR fonts to SVG files for remote hosting
## Zoe Meers
## The United States Studies Centre at the University of Sydney

#' SVG files with Halis GR fonts
#' @description
#' Ensures USSC fonts will always load in SVG format, regardless of whether user has the Halis GR fonts installed on their local machine.
#' To do this, the person creating the viz must save the SVG object and then reload it, saving it again using this function.
#' @param load_file Load old file that needs to be edited to host the USSC fonts.
#' @param save_file Save new file to directory.
#' @usage
#' save_svg_fonts()
#' @examples
#' \dontrun{
#' save_svg_fonts(load_file = "file.svg", save_file = "new_file.svg")
#' }
#' @author
#' Zoe Meers
#' @export

save_svg_fonts <- function(load_file, save_file = load_file){
  style_string <- paste0('<style  type="text/css">\n
          @charset "UTF-8";\n
          @font-face {
            font-family: "HalisGR-Regular";
            src: url("https://usstudiescentre.github.io/covid-19/covid_dashboard/ussc_fonts/Ahmet Altun - HalisGR-Regular.otf") format("opentype");
            src: url("https://usstudiescentre.github.io/covid-19/covid_dashboard/ussc_fonts/Ahmet Altun - HalisGR-Regular.otf#iefix") format("opentype");
            font-weight: normal;
            font-style: normal;
          }\n
          @font-face {
            font-family: "HalisGR-Light";
            src: url("https://usstudiescentre.github.io/fonts/Ahmet Altun - HalisGR-Light.otf") format("opentype");
            src: url("https://usstudiescentre.github.io/fonts/Ahmet Altun - HalisGR-Light.otf#iefix") format("opentype");
            font-weight: normal;
            font-style: normal;
          }\n
          @font-face {
            font-family: "HalisGR-Book";
            src: url("https://usstudiescentre.github.io/fonts/Ahmet Altun - HalisGR-Book.otf") format("opentype");
            src: url("https://usstudiescentre.github.io/fonts/Ahmet Altun - HalisGR-Book.otf#iefix") format("opentype");
            font-weight: normal;
            font-style: normal;
          } \n
          </style>')
  txt <- readChar(load_file, file.info(load_file)$size)
  txt <- gsub("</style>", paste0("</style>\n", style_string), txt)
  txt <- gsub("Halis GR ", "HalisGR-", txt)
  writeChar(txt, save_file, eos = NULL)
}
    
    
  
  




