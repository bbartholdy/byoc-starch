# versioning function

# copy all files to a directory

#' Versioning
#'
#' Function to copy documents to a separate directory
#' @param version name of version
#' @importFrom here here
versionr <- function(version, ...){
  if(!isTRUE(dir.exists(here("analysis/paper/_archive/", version)))){
    dir.create(here("analysis/paper/_archive", version))
  }
  vers_dir <- here("analysis/paper/_archive", version)
  files_cp <- list.files(here("analysis/paper"), pattern = "[.][a-z,A-Z]")
  # copy all files to _archive/"$version"
  file.copy(here("analysis/paper/", files_cp), vers_dir)
  if(all(file.exists(here(vers_dir, files_cp)) == TRUE)){
    return(TRUE)
  } else {
    warning("One or more of the files did not copy")
  }
}
