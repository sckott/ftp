#' Upload files to an FTP server
#'
#' @export
#' @param url (character) URL for the file on the FTP server
#' @param path (character) path
#' @param messages (logical) verbose messages. Default: `FALSE`
#' @param ... further args passed on to \pkg{curl}
#' @return string, path to the file on disk
#' @examples \dontrun{
#' file <- tempfile(fileext = ".csv")
#' row.names(mtcars) <- NULL
#' write.csv(mtcars, file = file, row.names = FALSE)
#' read.csv(file)
#' 
#' (x <- ftp_upload(url = "demo.wftpserver.com", path = file))
#' cat(rawToChar(x$headers))
#' cat(rawToChar(x$content))
#' 
#' 
#' file <- tempfile(fileext = ".png")
#' row.names(mtcars) <- NULL
#' (x <- ftp_upload(url = "ftp://speedtest.tele2.net/upload", path = file))
#' cat(rawToChar(x$headers))
#' cat(rawToChar(x$content))
#' }
ftp_upload <- function(url, path, messages = FALSE, ...) {
  stopifnot(file.exists(path))
  stopifnot(is.character(url))
  con <- file(path, open = "rb")
  on.exit(close(con))
  h <- curl::new_handle(upload = TRUE, filetime = FALSE)
  curl::handle_setopt(h, readfunction = function(n){
    readBin(con, raw(), n = n)
  }, verbose = messages)
  gg <- curl::curl_fetch_memory(url, handle = h)

  list(
    content = gg$content,
    url = gg$url,
    modified = gg$modified,
    status_code = gg$status_code,
    headers = gg$headers,
    times = gg$times
  )
}
