#' @importFrom V8 new_context
ftp <- NULL
.onLoad <- function(libname, pkgname){
  ftp <<- V8::new_context()
  ftp$source(system.file("js/ftp.js", package = pkgname))

  bfs <<- V8::new_context()
  bfs$source(system.file("js/browserfs.min.js", package = pkgname))
}
