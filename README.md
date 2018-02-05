ftp
===



[![Build Status](https://travis-ci.org/ropensci/ftp.svg?branch=master)](https://travis-ci.org/ropensci/ftp)

An FTP client for R

**not quite ready to use yet**

The File Transfer Protocol (FTP) is a standard network protocol used for the transfer of computer files from a server to a client using the Client–server model on a computer network.

See the ftp info vignette (`ftp-information`) for detailed FTP information.

## Installation


```r
devtools::install_github("ropensci/ftp")
```


```r
library('ftp')
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


## pwd


```r
x$pwd()
#> [1] "ftp://ftp.ncdc.noaa.gov/pub/data/ghcn/"
```

## list files


```r
x$list()
#> # A tibble: 13 x 6
#>    perm       dir       group size     date         file                  
#>    <chr>      <chr>     <chr> <chr>    <chr>        <chr>                 
#>  1 -rw-r--r-- 1 ftp     1005  10445    Mar 25  2008 alaska-temperature-an…
#>  2 -rw-r--r-- 1 ftp     1005  3410     Mar 12  2008 alaska-temperature-me…
#>  3 drwxr-xr-x 2 ftp     1005  512      Nov 10  2011 anom                  
#>  4 drwxrwsr-x 6 blended ""    512      Jan 18 10:16 blended               
#>  5 drwxrwxr-x 4 ftp     1005  1005     Feb  4 21:52 daily                 
#>  6 drwxrwxr-x 3 ftp     1005  512      Dec 15  2009 forts                 
#>  7 -rw-r--r-- 1 ftp     1005  14953824 Sep 11  2003 grid_gpcp_1979-2002.d…
#>  8 -rw-r--r-- 1 ftp     1005  3886592  Nov 30  2011 Lawrimore-ISTI-30Nov1…
#>  9 drwxr-xr-x 2 ftp     1005  512      Feb 27  2013 snow                  
#> 10 drwxrwxr-x 2 ftp     1005  32768    Aug 22  2001 v1                    
#> 11 drwxrwxr-x 5 ftp     1005  32768    Jun 27  2017 v2                    
#> 12 drwxr-xr-x 8 ftp     1005  32768    Feb  5 08:21 v3                    
#> 13 drwxrwxr-x 4 ftp     ""    16       Nov 16  2016 v4
```

> note that parsing isn't working totally yet :)


## Meta

* Please [report any issues or bugs](https://github.com/ropensci/ftp/issues).
* License: MIT
* Get citation information for `ftp` in R doing `citation(package = 'ftp')`
* Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
