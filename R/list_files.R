#' List files on an FTP server
#'
#' @importFrom RCurl getURL
#' @export
#' @param url URL for the FTP server
#' @param ... further args passed on to \code{\link[RCurl]{getURL}}
#' @examples \dontrun{
#' url <- "ftp://ftp.ncdc.noaa.gov/pub/data/ghcn/daily/"
#' url <- "ftp://ftp.ncdc.noaa.gov/pub/data/ghcn/daily/by_year/"
#' url <- "ftp://ftp.ncdc.noaa.gov/pub/data/noaa/2014/"
#' list_files(url)
#' }
list_files <- function(url, ...){
  ff <- getURL(url, ftp.use.epsv = FALSE, dirlistonly = TRUE, ...)
  parse_files(strsplit(ff, "\n")[[1]])
}

list_files <- function(url, ...) {
  # ftp$eval("ftp")
  # ftp$eval("var Client = require('ftp');")
  ftp$eval("var c = new ftp();")
  ftp$eval('var options = { host: "ftp.ncdc.noaa.gov" };')
  ftp$eval("
        c.on('ready', function() {c
          c.get('/pub/data/noaa/isd-history.csv', function(err, stream) {
            if (err) throw err;
            stream.once('close', function() { c.end(); });
            stream.pipe(fs.createWriteStream('isd-history_local-copy.csv'));
          });
        });")
  ftp$eval('c.connect({host: "ftp.ncdc.noaa.gov"});')
  ftp$get("c")
}

# var Client = require('ftp');
# var fs = require('fs');
#
# var c = new Client();
#
# c.on('ready', function() {
#   c.get('ish-history.csv', function(err, stream) {
#     if (err) throw err;
#     stream.once('close', function() { c.end(); });
#     stream.pipe(fs.createWriteStream('ish-history_local-copy.txy'));
#   });
# });
# # c.connect('ftp://ftp.ncdc.noaa.gov/pub/data/noaa');
#
# # parse_files <- function(x){
# #   sapply(x, function(y){
# #     strsplit(y, "\\s")
# #   })
# # }

bfs$eval("var lsfs = new BrowserFS.FileSystem.LocalStorage();")
