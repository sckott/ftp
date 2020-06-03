ftp
===



[![Build Status](https://travis-ci.org/ropensci/ftp.svg?branch=master)](https://travis-ci.org/ropensci/ftp)

An FTP client for R

**not quite ready to use yet**

The File Transfer Protocol (FTP) is a standard network protocol used for the transfer of computer files from a server to a client using the Client–server model on a computer network.

See the ftp info vignette [ftp-information](https://docs.ropensci.org/ftp/articles/ftp-information.html) for detailed FTP information.

## Installation


```r
devtools::install_github("ropensci/ftp")
```


```r
library('ftp')
```

## list files


```r
ftp_list("ftp://ftp.ncdc.noaa.gov/pub/data/ghcn/daily/")
ftp_list("ftp://ftp.ncdc.noaa.gov/pub/data/ghcn/daily/by_year/")
ftp_list("ftp://ftp.ncdc.noaa.gov/pub/data/noaa/2014/")
# just list files
ftp_list("ftp://ftp.ncdc.noaa.gov/pub/data/ghcn/daily/", just_list = TRUE)
```

## fetch files


```r
url <- "ftp://ftp.ncdc.noaa.gov/pub/data/ghcn/daily/by_year/1882.csv.gz"
file <- tempfile(fileext = ".csv.gz")
ftp_fetch(url, disk = file)
utils::read.delim(file, sep = ",", nrows = 10, header = FALSE)
unlink(file) # cleanup
```

## ftp client

Wraps an R6 method `FTPClient`


```r
(x <- ftp_client("ftp://ftp.ncdc.noaa.gov/pub/data/ghcn/"))
#> <ftp client> 
#>   base url: ftp://ftp.ncdc.noaa.gov/pub/data/ghcn/
#>   port: 21
#>   active/passive: passive
```

adjust settings


```r
x$ftp_port()
x$set_pasv()
```


pwd, working directory


```r
x$pwd()
#> [1] "ftp://ftp.ncdc.noaa.gov/pub/data/ghcn/"
```

list files


```r
x$list()
#> # A tibble: 13 x 6
#>    perm       dir   group size  date         file                            
#>    <chr>      <chr> <chr> <chr> <chr>        <chr>                           
#>  1 -rwxrwxr-x 1 ftp ""    25    Mar 25  2008 alaska-temperature-anomalies.txt
#>  2 -rwxrwxr-x 1 ftp ""    12    Mar 12  2008 alaska-temperature-means.txt    
#>  3 drwxrwxr-x 2 ftp ""    10    Nov 10  2011 anom                            
#>  4 drwxrwxr-x 3 ftp ""    18    Aug 18  2015 blended                         
#>  5 drwxrwsr-x 5 ftp ""    4096  Jun  1 19:06 daily                           
#>  6 drwxrwxr-x 3 ftp ""    15    Dec 15  2009 forts                           
#>  7 -rwxrwxr-x 1 ftp ""    11    Sep 11  2003 grid_gpcp_1979-2002.dat         
#>  8 -rwxrwxr-x 1 ftp ""    30    Nov 30  2011 Lawrimore-ISTI-30Nov11.ppt      
#>  9 drwxrwxr-x 2 ftp ""    14    Feb 14 13:05 snow                            
#> 10 drwxrwxr-x 2 ftp ""    22    Aug 22  2001 v1                              
#> 11 drwxrwxr-x 5 ftp ""    15    Oct 15  2019 v2                              
#> 12 drwxrwxr-x 8 ftp ""    19    Sep 19  2019 v3                              
#> 13 drwxrwxr-x 5 ftp ""    07    Jun  3 07:33 v4
```

> note that parsing isn't working totally yet :)


## Meta

* Please [report any issues or bugs](https://github.com/ropensci/ftp/issues).
* License: MIT
* Get citation information for `ftp` in R doing `citation(package = 'ftp')`
* Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.
