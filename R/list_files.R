#' List files on an FTP server
#'
#' @importFrom RCurl getURL
#' @export
#' @param url URL for the FTP server
#' @param ... further args passed on to \code{\link[RCurl]{getURL}}
#' @examples \dontrun{
#' url <- "ftp://localhost"
#' url <- "http://dd.meteo.gc.ca/"
#' url <- "ftp://ftp.ncdc.noaa.gov/pub/data/noaa/2014/"
#' list_files(url)
#' }
list_files <- function(url, ...){
  ff <- getURL(url, ftp.use.epsv = FALSE, dirlistonly = TRUE, ...)
  strsplit(ff, "\n")[[1]]
}
