#' List files on an FTP server
#'
#' @export
#' @param url (character) URL for the FTP server
#' @param just_list (logical) list files only? default: \code{FALSE}
#' @param verbose (logical) verbose messages
#' @param ... further args passed on to \pkg{curl}
#' @return a tibble (data.frame)
#' @examples \dontrun{
#' ftp_list("ftp://ftp.ncdc.noaa.gov/pub/data/ghcn/daily/")
#'
#' # just list files
#' ftp_list("ftp://ftp.ncdc.noaa.gov/pub/data/ghcn/daily/", TRUE)
#'
#' # more examples
#' ftp_list("ftp://ftp.ncdc.noaa.gov/pub/data/ghcn/daily/by_year/")
#' ftp_list("ftp://ftp.ncdc.noaa.gov/pub/data/noaa/2014/")
#' }
ftp_list <- function(url, just_list = FALSE, verbose = FALSE, ...) {
  hand <- curl::new_handle()
  if (verbose) curl::handle_setopt(hand, verbose = TRUE)
  if (just_list) curl::handle_setopt(hand, dirlistonly = TRUE)
  gg <- curl::curl_fetch_memory(url, handle = hand)
  gg <- rawToChar(gg$content)
  if (just_list) {
    to_tbl(utils::read.delim(text = x, header = FALSE, stringsAsFactors = FALSE))
  } else {
    to_df(parse_files(gg))
  }
}

parse_files <- function(x) {
  x <- strsplit(x, "\n")[[1]]
  lapply(x, function(z) {
    perm <- strex(z, "^[a-z-]+")
    dir <- strex(z, "[0-9]\\s[a-z]+")
    group <- strex(z, "csdb-ops|1005")
    size <- strex(z, "[0-9]{2,}\\s[A-Za-z]")
    date <- strex(z, "[A-Za-z]{3}\\s+[0-9]{1,2}\\s+[0-9]{2}:[0-9]{2}|[A-Za-z]{3}\\s+[0-9]{1,2}\\s+[0-9]{4}")
    file <- strex(z, "[A-Za-z0-9._-]+$")
    tmp <- list(perm = perm, dir = dir, group = group, size = size,
         date = date, file = file)
    tmp[vapply(tmp, length, 1) == 0] <- ""
    tmp
  })
}

strex <- function(string, pattern) {
  regmatches(string, regexpr(pattern, string))
}

strexg <- function(string, pattern) {
  regmatches(string, gregexpr(pattern, string))
}

to_df <- function(x) {
  tibble::as_tibble((data.table::setDF(
    data.table::rbindlist(x, use.names = TRUE, fill = TRUE))))
}

to_tbl <- function(x) tibble::as_tibble(x)
