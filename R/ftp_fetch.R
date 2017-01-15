#' Fetch files from an FTP server
#'
#' @export
#' @param url (character) URL for the file on the FTP server
#' @param ... further args passed on to \pkg{curl}
#' @return string, path to the file on disk
#' @examples \dontrun{
#' file <- tempfile(fileext = ".csv.gz")
#' ftp_fetch("ftp://ftp.ncdc.noaa.gov/pub/data/ghcn/daily/by_year/1882.csv.gz",
#'   path = file)
#' utils::read.delim(file, sep = ",", nrows = 10, header = FALSE)
#' }
ftp_fetch <- function(url, path, verbose = FALSE, ...) {
  hand <- curl::new_handle()
  if (verbose) curl::handle_setopt(hand, verbose = TRUE)
  gg <- curl::curl_fetch_disk(url, path = path, handle = hand)
  list(
    path = gg$content,
    url = gg$url,
    modified = gg$modified
  )
}
