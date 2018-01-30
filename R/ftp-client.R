#' ftp client
#'
#' @export
#' @param path (character) a path to cache files in. required
#' @param type (character) type of cache. One of user_cache_dir (default),
#' user_log_dir, user_data_dir, user_config_dir, site_data_dir,
#' site_config_dir. required
#' @details
#' \strong{Methods}
#'   \describe{
#'     \item{\code{pwd()}}{
#'       Print working directory
#'     }
#'     \item{\code{cd()}}{
#'       Change directory
#'     }
#'     \item{\code{ftp_port()}}{
#'       Change ftp port
#'     }
#'     \item{\code{set_pasv()}}{
#'       Change directory
#'     }
#'     \item{\code{get()}}{
#'       Get a file from remote server
#'     }
#'     \item{\code{list()}}{
#'       List files on remote server
#'     }
#'   }
#' @format NULL
#' @usage NULL
#' @examples
#' (x <- ftp_client("ftp://ftp.ncdc.noaa.gov/pub/data/ghcn/"))
#' x$pwd()
#' x$list()
#'
#' x$cd("daily")
#' x$pwd()
#' x$list()
#'
#' # turn on active
#' x$set_pasv(TRUE)
#' x
#'
#' # change port
#' # x$ftp_port(4567)
#' 
#' # get a file
#' x$get('ghcnd-states.txt', disk = (f <- tempfile()))
#' readLines(f, n = 10)
#' close(file(f))
#' 
#' # put a file
#' x <- ftp_client("ftp://speedtest.tele2.net/")
#' x$cd('upload')
#' x$list()
#' f <- tempfile(fileext = ".txt")
#' writeLines("foo\nbar\n", con = f)
#' readLines(f)
#' res <- x$put(f, TRUE)
ftp_client <- function(url) FTPClient$new(url = url)

# the client
FTPClient <- R6::R6Class(
  'FTPClient',
  public = list(
    url = NULL,
    port = 21,
    dir = NULL,
    active = FALSE,

    print = function(x, ...) {
      cat("<ftp client> ", sep = "\n")
      cat(paste0("  base url: ", self$url), sep = "\n")
      cat(paste0("  port: ", self$port), sep = "\n")
      cat(paste0("  active/passive: ", if (self$active) "active" else "passive"), sep = "\n")
      invisible(self)
    },

    initialize = function(url) {
      if (!missing(url)) self$url <- url
    },

    pwd = function() {
      if (!is.null(self$dir)) file.path(sub("/$", "", self$url), self$dir) else self$url
    },

    cd = function(path) {
      self$dir <- path
      self$pwd()
    },

    list = function(just_list = FALSE, messages = FALSE, ...) {
      ftp_list(xl(self$pwd()), just_list = just_list, 
        messages = messages, ...)
    },

    get = function(x, disk = NULL, stream = FALSE, ...) {
      ftp_fetch(file.path(self$pwd(), x), disk = disk, stream = stream, 
        messages = messages, ...)
    },

    put = function(path, messages = FALSE, ...)  {
      ftp_upload(self$pwd(), path, messages = messages, ...)
    },

    set_pasv = function(x = FALSE) self$active <- x,

    ftp_port = function(port) {
      self$port <- port
    }
  )
)
