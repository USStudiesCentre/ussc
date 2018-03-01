.onAttach <- function(libname, pkgname) {
  # to show a startup message
  packageStartupMessage("This package is primarily used for research purposes at the USSC.\n Please contact the package maintainer if there are any issues.")
}

.onLoad <- function(libname, pkgname) {
  # something to run
  ussc_fonts()
}