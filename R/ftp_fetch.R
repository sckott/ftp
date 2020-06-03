#' Fetch files from an FTP server
#'
#' @export
#' @param url (character) URL for the file on the FTP server
#' @param disk (character) a path to write to. if `NULL` (default), 
#' memory used. See [curl::curl_fetch_disk()] for help.
#' @param stream (character) an R function to determine how to stream 
#' data. if `NULL` (default), memory used. See [curl::curl_fetch_stream()]
#' for help.
#' @param messages (logical) verbose messages. Default: `FALSE`
#' @param ... further args passed on to \pkg{curl}
#' @return string, path to the file on disk
#' @details Only one of `disk` or `stream` parameters can be passed
#' @examples \dontrun{
#' url <- "ftp://ftp.ncdc.noaa.gov/pub/data/ghcn/daily/by_year/1882.csv.gz"
#' 
#' # disk
#' file <- tempfile(fileext = ".csv.gz")
#' ftp_fetch(url, disk = file)
#' utils::read.delim(file, sep = ",", nrows = 10, header = FALSE)
#' unlink(file) # cleanup
#' 
#' # stream - NOT WORKING QUITE YET
#' lst <- c()
#' fun <- function(x) lst <<- c(lst, x)
#' ftp_fetch(url, stream = fun)
#' lst
#' }
ftp_fetch <- function(url, disk = NULL, stream = NULL, messages = FALSE, ...) {
  stopifnot(xor(is.null(disk), is.null(stream)))
  hand <- curl::new_handle()
  if (messages) curl::handle_setopt(hand, verbose = TRUE)
  if (!is.null(disk)) {
    gg <- curl::curl_fetch_disk(url, path = disk, handle = hand)
  }
  if (!is.null(stream)) {
    gg <- curl::curl_fetch_stream(url, fun = stream, handle = hand)
  }
  list(
    path = gg$content,
    url = gg$url,
    modified = gg$modified
  )
}
