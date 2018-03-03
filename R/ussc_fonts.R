## Functions to load USSC fonts to package directory
## Zoe Meers
## The United States Studies Centre at the University of Sydney

font_install = function(font_desc, quiet = FALSE, ...)
{
  font_desc = as.list(font_desc)
  name = font_desc$showtext_name
  ext  = font_desc$font_ext
  
 
  ## Create a directory with the font family name
  font_dir = file.path(system.file("fonts", package = "ussc"), name)
  if(!dir.exists(font_dir))
    dir.create(font_dir)
  
  
  other_faces = c("bold", "italic", "light")
  for(face in other_faces)
  {
    face_url = font_desc[[sprintf("%s_url", face)]]
    if(!is.null(face_url))
    {
      face_file = file.path(font_dir, sprintf("%s.%s", face, ext))
      if(!file.exists(face_file))
      {
        if(!quiet)
          message(sprintf("downloading the '%s' font face...", face))
        curl::curl_download(face_url, face_file, quiet = quiet, ...)
      }
      
    }
  }
  
  ## Load the newly installed font
  load_user_fonts()
  
  invisible(NULL)
}


font_installed = function()
{
  ## The directory that contains the user fonts
  font_db = system.file("fonts", package = "ussc")
  
  ## Each folder under fonts_db is considered a user font with different font faces
  font_dirs = list.dirs(font_db, recursive = FALSE)
  if(!length(font_dirs))
    return(character(0))
  
}


load_showtext_fonts = function()
{
  load_default_font()
  load_user_fonts()
}



## Check if a family has been loaded
already_loaded = function(family)
{
  all(family %in% sysfonts::font_families())
}

## Load the default univers font
load_default_font = function()
{
  ## Check if univers has been loaded already
  if(already_loaded("Univers LT Pro"))
    return(invisible(NULL))
  
  ## Extract font file
  font_file = system.file("fonts", "Univers.zip", package = "ussc")
  out_dir = tempdir()
  out_file = file.path(out_dir, "Univers")
  if(!file.exists(out_file))
    utils::unzip(font_file, exdir = out_dir, overwrite = FALSE)
  
  ## Add font to sysfonts
  sysfonts::font_add("univers", out_file)
  
  ## Check if univers has been loaded already
  if(already_loaded("Neo Sans Pro"))
    return(invisible(NULL))
  
  ## Extract font file
  font_file_nsp = system.file("fonts", "Neo Sans Pro.zip", package = "ussc")
  out_dir_nsp = tempdir()
  out_file_nsp = file.path(out_dir_nsp, "Neo Sans Pro")
  if(!file.exists(out_file_nsp))
    utils::unzip(font_file, exdir = out_dir_nsp, overwrite = FALSE)
  
  ## Add font to sysfonts
  sysfonts::font_add("Neo Sans Pro", out_file)
  
  invisible(NULL)
}

## Load fonts that have been installed by the user
load_user_fonts = function()
{
  ## The directory that contains the user fonts
  font_db = system.file("fonts", package = "showtextdb")
  
  ## Each folder under fonts_db is considered a user font with different font faces
  font_dirs = list.dirs(font_db, recursive = FALSE)
  if(!length(font_dirs))
    return(invisible(NULL))
  
  ## Family names without the full path
  family_names = basename(font_dirs)
  ## Scan all possible font faces
  faces = c("regular", "bold", "italic", "light", "roman")
  ## Add fonts one by one
  for(i in seq_along(family_names))
  {
    if(!already_loaded(family_names[i]))
    {
      font_files = list.files(font_dirs[i])
      args = lapply(faces, function(face) {
        r = grep(sprintf("^%s\\.[[:alnum:]]+$", face), font_files, value = TRUE)
        if(!length(r)) NULL else file.path(font_dirs[i], r)
      })
      names(args) = faces
      args = c(family = family_names[i], args)
      do.call(sysfonts::font_add, args)
    }
  }
  
  invisible(NULL)
}
