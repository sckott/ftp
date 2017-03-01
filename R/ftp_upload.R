#' Upload files to an FTP server
#'
#' @export
#' @param url (character) URL for the file on the FTP server
#' @param path (character) path
#' @param verbose (logical) verbose messages
#' @param ... further args passed on to \pkg{curl}
#' @return string, path to the file on disk
#' @examples \dontrun{
#' file <- tempfile(fileext = ".csv.gz")
#' ftp_upload(url = "demo.wftpserver.com", path = file)
#' }
ftp_upload <- function(url, path, verbose = FALSE, ...) {
  cli <- crul::HttpClient$new(url = url)
  cli$post()

  # hand <- curl::new_handle()
  # if (verbose) curl::handle_setopt(hand, verbose = TRUE)
  # gg <- curl::curl_fetch_memory(url, handle = hand)
  # list(
  #   path = gg$content,
  #   url = gg$url,
  #   modified = gg$modified
  # )
}
