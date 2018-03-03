.onLoad <- function(libname, pkgname) {
  library.dynam("ussc", pkgname, libname)
  ussc_fonts()
  }

.onUnload <- function(libpath) {
  library.dynam.unload("ussc", libpath)
}
