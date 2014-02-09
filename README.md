Forest Park Trail Runs
======================
Map trail running routes through [Forest Park](http://www.portlandoregon.gov/parks/finder/index.cfm?&propertyid=127&action=ViewPark).

Last updated 2014-02-09 09:53:17 using R version 3.0.2 (2013-09-25).


Find the geographic mean of [Wildwood Trail](http://en.wikipedia.org/wiki/Forest_Park_(Portland,_Oregon)#Wildwood_Trail). Use [Yassine Diboun's](http://www.yassinediboun.com/) Wildwood Trail end-to-end-to-end fastest known time [GPS data](http://yassinediboun.com/yassinediboun/blog/item/wildwood-end-to-end-to-end-speed-record-605-miles?category_id=379)

```r
require(plotKML)
```

```
## Loading required package: plotKML plotKML version 0.4-2 (2013-01-15) URL:
## http://plotkml.r-forge.r-project.org/
```

```r
gpxWW <- readGPX("yassine WW double FKT.gpx")
dfWW <- gpxWW$tracks[[1]][[1]]
coordWW <- dfWW[, c("lon", "lat")]
require(geosphere)
```

```
## Loading required package: geosphere Loading required package: sp
```

```r
geomeanWW <- geomean(coordWW)
geomeanWW
```

```
##           x     y
## [1,] -122.8 45.56
```

```r
require(ggmap)
```

```
## Loading required package: ggmap Loading required package: ggplot2
```

```r
mapWW <- get_map(location = geomeanWW, maptype = "terrain", source = "stamen", 
    zoom = 12)
```

```
## Map from URL :
## http://maps.googleapis.com/maps/api/staticmap?center=45.559548,-122.76217&zoom=12&size=%20640x640&maptype=terrain&sensor=false
## Google Maps API Terms of Service : http://developers.google.com/maps/terms
```

```r
ggmap(mapWW)
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1.png) 


Use my running history as a starting point. *Will eventually want to get other runners' data.*

Get files names of GPX data files.

```r
path <- file.path("..", "RunningRoutes", "activities")
files <- dir(path = path, pattern = "\\.gpx")
```

Set the date range in days. Use only the files within range of the latest file. The dates of the files are determined from the file names.

```r
rangeDate <- 365.25 * 3
dates <- as.Date(substr(files, 1, 8), format = "%Y%m%d")
isRangeDate <- max(dates) - dates < rangeDate
files <- files[isRangeDate]
dateFrom <- min(dates[isRangeDate])
dateTo <- max(dates[isRangeDate])
message(sprintf("Using routes run from %s to %s", dateFrom, dateTo))
```

```
## Using routes run from 2011-08-24 to 2014-02-08
```

Consolidate routes in one data frame.

```r
index <- c()
date <- c()
latitude <- c()
longitude <- c()
require(plotKML)
for (i in 1:length(files)) {
    f <- file.path(path, files[i])
    route <- readGPX(f)
    location <- route$tracks[[1]][[1]]
    index <- c(index, rep(i, dim(location)[1]))
    date <- c(date, rep(as.Date(substr(files[i], 1, 8), format = "%Y%m%d"), 
        dim(location)[1]))
    latitude <- c(latitude, location$lat)
    longitude <- c(longitude, location$lon)
}
routes <- data.frame(cbind(index, date, latitude, longitude))
```

Calculate distance from the central point. I'll need to use the `distHaversine` function from the [geosphere](http://www.inside-r.org/packages/cran/geosphere) package to calculate the distance from home to route coordinates. The Haversine algorithm isn't the most accurate, but it is good enough for this purpose.

```r
require(geosphere)
dist <- distHaversine(geomeanWW, routes[, c("longitude", "latitude")])/1000
routes <- data.frame(routes, dist)
```

Set the distance range in kilometers. Subset routes to those having at least one coordinate point within range from the central point.

```r
rangeDist <- 5
aggRoutes <- aggregate(dist ~ index, routes, min)
includedRoutes <- aggRoutes$index[aggRoutes$dist < rangeDist]
routesInRange <- subset(routes, index %in% includedRoutes)
message(sprintf("Plotting %.0d routes within %.0d km of (%.3f, %.3f)", length(includedRoutes), 
    rangeDist, geomeanWW[1], geomeanWW[2]))
```

```
## Plotting 81 routes within 5 km of (-122.762, 45.560)
```

Set titles for map.

```r
fmtDate <- "%d %b %Y"
title <- sprintf("Forest Park trail runs\n%s to %s", format(dateFrom, fmtDate), 
    format(dateTo, fmtDate))
```

Plot the routes.

```r
g <- ggmap(mapWW, base_layer = ggplot(routesInRange, aes(x = longitude, y = latitude, 
    group = index)))
g <- g + geom_path(alpha = 1/4, color = "#7a0177")
g <- g + labs(title = title)
g
```

```
## Warning: Removed 187 rows containing missing values (geom_path).
```

![plot of chunk mapForestParkTrailRuns](figure/mapForestParkTrailRuns.png) 

