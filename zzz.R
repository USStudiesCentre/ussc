.onLoad{
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