rnoaa
=====



An ftp client for R

## Installation


```r
devtools::install_github("ropensci/ftp")
```


```r
library('ftp')
```

## list files


```r
url <- "ftp://ftp.ncdc.noaa.gov/pub/data/noaa/2014/"
list_files(url)[1:10]
#>  [1] "949690-99999-2014.gz" "955810-99999-2014.gz" "956280-99999-2014.gz"
#>  [4] "956310-99999-2014.gz" "956390-99999-2014.gz" "956570-99999-2014.gz"
#>  [7] "956740-99999-2014.gz" "957080-99999-2014.gz" "957160-99999-2014.gz"
#> [10] "958310-99999-2014.gz"
```
