Forest Park Trail Runs
======================
Map trail running routes through [Forest Park](http://www.portlandoregon.gov/parks/finder/index.cfm?&propertyid=127&action=ViewPark).

Last updated 2014-02-10 15:12:11 using R version 3.0.2 (2013-09-25).


Load packages.

```r
packages <- c("RCurl", "plotKML", "geosphere", "ggmap", "ggplot2", "RColorBrewer", 
    "xtable", "data.table")
sapply(packages, require, character.only = TRUE)
```

```
## Loading required package: RCurl
## Loading required package: bitops
## Loading required package: plotKML
## plotKML version 0.4-2 (2013-01-15)
## URL: http://plotkml.r-forge.r-project.org/
## Loading required package: geosphere
## Loading required package: sp
## Loading required package: ggmap
## Loading required package: ggplot2
## Loading required package: RColorBrewer
## Loading required package: xtable
## Loading required package: data.table
```

```
##        RCurl      plotKML    geosphere        ggmap      ggplot2 
##         TRUE         TRUE         TRUE         TRUE         TRUE 
## RColorBrewer       xtable   data.table 
##         TRUE         TRUE         TRUE
```



Read coordinates for Forest Park waypoints.

```r
url <- getURL("https://docs.google.com/spreadsheet/pub?key=0ApyhYsT8Gi-EdFBUYk4wb0UyYlUweHg1SHlfX3VHV1E&single=true&gid=1&output=csv", 
    cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))
dfWaypoints <- read.csv(textConnection(url), header = TRUE)
print(xtable(dfWaypoints, digits = 7), type = "html")
```

<!-- html table generated in R 3.0.2 by xtable 1.7-1 package -->
<!-- Mon Feb 10 15:12:20 2014 -->
<TABLE border=1>
<TR> <TH>  </TH> <TH> trail </TH> <TH> waypoint </TH> <TH> lat </TH> <TH> lon </TH>  </TR>
  <TR> <TD align="right"> 1 </TD> <TD> Wildwood Trail </TD> <TD> Vietnam Memorial </TD> <TD align="right"> 45.5122156 </TD> <TD align="right"> -122.7182866 </TD> </TR>
  <TR> <TD align="right"> 2 </TD> <TD> Wildwood Trail </TD> <TD> Burnside Rd </TD> <TD align="right"> 45.5215696 </TD> <TD align="right"> -122.7195009 </TD> </TR>
  <TR> <TD align="right"> 3 </TD> <TD> Wildwood Trail </TD> <TD> Fairview Blvd </TD> <TD align="right"> 45.5183069 </TD> <TD align="right"> -122.7157768 </TD> </TR>
  <TR> <TD align="right"> 4 </TD> <TD> Wildwood Trail </TD> <TD> Pittock Mansion </TD> <TD align="right"> 45.5248043 </TD> <TD align="right"> -122.7177391 </TD> </TR>
  <TR> <TD align="right"> 5 </TD> <TD> Wildwood Trail </TD> <TD> Cornell Rd </TD> <TD align="right"> 45.5268969 </TD> <TD align="right"> -122.7264093 </TD> </TR>
  <TR> <TD align="right"> 6 </TD> <TD> Wildwood Trail </TD> <TD> Danford Balch Homesite </TD> <TD align="right"> 45.5284844 </TD> <TD align="right"> -122.7246820 </TD> </TR>
  <TR> <TD align="right"> 7 </TD> <TD> Wildwood Trail </TD> <TD> Holman Ln </TD> <TD align="right"> 45.5331160 </TD> <TD align="right"> -122.7202034 </TD> </TR>
  <TR> <TD align="right"> 8 </TD> <TD> Wildwood Trail </TD> <TD> Aspen Trail </TD> <TD align="right"> 45.5374433 </TD> <TD align="right"> -122.7221380 </TD> </TR>
  <TR> <TD align="right"> 9 </TD> <TD> Wildwood Trail </TD> <TD> Birch Trail </TD> <TD align="right"> 45.5345197 </TD> <TD align="right"> -122.7313572 </TD> </TR>
  <TR> <TD align="right"> 10 </TD> <TD> Wildwood Trail </TD> <TD> Wild Cherry Trail </TD> <TD align="right"> 45.5380799 </TD> <TD align="right"> -122.7303532 </TD> </TR>
  <TR> <TD align="right"> 11 </TD> <TD> Wildwood Trail </TD> <TD> Dogwood Trail </TD> <TD align="right"> 45.5446073 </TD> <TD align="right"> -122.7303290 </TD> </TR>
  <TR> <TD align="right"> 12 </TD> <TD> Wildwood Trail </TD> <TD> NW 53rd Dr </TD> <TD align="right"> 45.5403604 </TD> <TD align="right"> -122.7368664 </TD> </TR>
  <TR> <TD align="right"> 13 </TD> <TD> Wildwood Trail </TD> <TD> Alder Trail </TD> <TD align="right"> 45.5422124 </TD> <TD align="right"> -122.7380596 </TD> </TR>
  <TR> <TD align="right"> 14 </TD> <TD> Wildwood Trail </TD> <TD> Firelane 1 </TD> <TD align="right"> 45.5523253 </TD> <TD align="right"> -122.7468226 </TD> </TR>
  <TR> <TD align="right"> 15 </TD> <TD> Wildwood Trail </TD> <TD> Chestnut Trail </TD> <TD align="right"> 45.5499917 </TD> <TD align="right"> -122.7538812 </TD> </TR>
  <TR> <TD align="right"> 16 </TD> <TD> Wildwood Trail </TD> <TD> Firelane 2 </TD> <TD align="right"> 45.5517769 </TD> <TD align="right"> -122.7585713 </TD> </TR>
  <TR> <TD align="right"> 17 </TD> <TD> Wildwood Trail </TD> <TD> Maple Trail </TD> <TD align="right"> 45.5522957 </TD> <TD align="right"> -122.7585482 </TD> </TR>
  <TR> <TD align="right"> 18 </TD> <TD> Wildwood Trail </TD> <TD> Firelane 3 </TD> <TD align="right"> 45.5550180 </TD> <TD align="right"> -122.7607111 </TD> </TR>
  <TR> <TD align="right"> 19 </TD> <TD> Wildwood Trail </TD> <TD> Saltzman Rd </TD> <TD align="right"> 45.5650940 </TD> <TD align="right"> -122.7703655 </TD> </TR>
  <TR> <TD align="right"> 20 </TD> <TD> Wildwood Trail </TD> <TD> Fire Lane 5 </TD> <TD align="right"> 45.5675190 </TD> <TD align="right"> -122.7718735 </TD> </TR>
  <TR> <TD align="right"> 21 </TD> <TD> Wildwood Trail </TD> <TD> Oil Line Rd </TD> <TD align="right"> 45.5727754 </TD> <TD align="right"> -122.7700971 </TD> </TR>
  <TR> <TD align="right"> 22 </TD> <TD> Wildwood Trail </TD> <TD> Hardesty Trail </TD> <TD align="right"> 45.5775508 </TD> <TD align="right"> -122.7832252 </TD> </TR>
  <TR> <TD align="right"> 23 </TD> <TD> Wildwood Trail </TD> <TD> NW Springville Rd </TD> <TD align="right"> 45.5786938 </TD> <TD align="right"> -122.7854266 </TD> </TR>
  <TR> <TD align="right"> 24 </TD> <TD> Wildwood Trail </TD> <TD> Waterline Rd </TD> <TD align="right"> 45.5832952 </TD> <TD align="right"> -122.7906907 </TD> </TR>
  <TR> <TD align="right"> 25 </TD> <TD> Wildwood Trail </TD> <TD> NW Germantown Rd </TD> <TD align="right"> 45.5876390 </TD> <TD align="right"> -122.7939852 </TD> </TR>
  <TR> <TD align="right"> 26 </TD> <TD> Wildwood Trail </TD> <TD> Firelane 10 </TD> <TD align="right"> 45.5903555 </TD> <TD align="right"> -122.8005423 </TD> </TR>
  <TR> <TD align="right"> 27 </TD> <TD> Wildwood Trail </TD> <TD> Newton Rd </TD> <TD align="right"> 45.5996421 </TD> <TD align="right"> -122.8004773 </TD> </TR>
  <TR> <TD align="right"> 28 </TD> <TD> Wildwood Trail </TD> <TD> BPA Rd </TD> <TD align="right"> 45.5968054 </TD> <TD align="right"> -122.8096836 </TD> </TR>
  <TR> <TD align="right"> 29 </TD> <TD> Wildwood Trail </TD> <TD> Firelane 15 </TD> <TD align="right"> 45.6013011 </TD> <TD align="right"> -122.8131435 </TD> </TR>
  <TR> <TD align="right"> 30 </TD> <TD> Wildwood Trail </TD> <TD> NW Newberry Rd </TD> <TD align="right"> 45.6056356 </TD> <TD align="right"> -122.8234792 </TD> </TR>
  <TR> <TD align="right"> 31 </TD> <TD> Leif Erikson Dr </TD> <TD> NW Thurman St </TD> <TD align="right"> 45.5391104 </TD> <TD align="right"> -122.7253419 </TD> </TR>
  <TR> <TD align="right"> 32 </TD> <TD> Leif Erikson Dr </TD> <TD> Wild Cherry Trail </TD> <TD align="right"> 45.5408771 </TD> <TD align="right"> -122.7261703 </TD> </TR>
  <TR> <TD align="right"> 33 </TD> <TD> Leif Erikson Dr </TD> <TD> Dogwood Trail </TD> <TD align="right"> 45.5462488 </TD> <TD align="right"> -122.7310576 </TD> </TR>
  <TR> <TD align="right"> 34 </TD> <TD> Leif Erikson Dr </TD> <TD> Alder Trail </TD> <TD align="right"> 45.5473438 </TD> <TD align="right"> -122.7355170 </TD> </TR>
  <TR> <TD align="right"> 35 </TD> <TD> Leif Erikson Dr </TD> <TD> Firelane 1 </TD> <TD align="right"> 45.5574189 </TD> <TD align="right"> -122.7489440 </TD> </TR>
  <TR> <TD align="right"> 36 </TD> <TD> Leif Erikson Dr </TD> <TD> Firelane 2 </TD> <TD align="right"> 45.5566862 </TD> <TD align="right"> -122.7529979 </TD> </TR>
  <TR> <TD align="right"> 37 </TD> <TD> Leif Erikson Dr </TD> <TD> Firelane 3 </TD> <TD align="right"> 45.5575085 </TD> <TD align="right"> -122.7558205 </TD> </TR>
  <TR> <TD align="right"> 38 </TD> <TD> Leif Erikson Dr </TD> <TD> Saltzman Rd </TD> <TD align="right"> 45.5692881 </TD> <TD align="right"> -122.7634729 </TD> </TR>
  <TR> <TD align="right"> 39 </TD> <TD> Leif Erikson Dr </TD> <TD> Maple Trail </TD> <TD align="right"> 45.5684449 </TD> <TD align="right"> -122.7676105 </TD> </TR>
  <TR> <TD align="right"> 40 </TD> <TD> Leif Erikson Dr </TD> <TD> Hardesty Trail </TD> <TD align="right"> 45.5791673 </TD> <TD align="right"> -122.7793974 </TD> </TR>
  <TR> <TD align="right"> 41 </TD> <TD> Leif Erikson Dr </TD> <TD> NW Springville Rd </TD> <TD align="right"> 45.5829419 </TD> <TD align="right"> -122.7828190 </TD> </TR>
  <TR> <TD align="right"> 42 </TD> <TD> Leif Erikson Dr </TD> <TD> Waterline Rd </TD> <TD align="right"> 45.5846775 </TD> <TD align="right"> -122.7846342 </TD> </TR>
  <TR> <TD align="right"> 43 </TD> <TD> Leif Erikson Dr </TD> <TD> NW Germantown Rd </TD> <TD align="right"> 45.5892270 </TD> <TD align="right"> -122.7903216 </TD> </TR>
  <TR> <TD align="right"> 44 </TD> <TD> Lower Macleay Trail </TD> <TD> NW Upshur St </TD> <TD align="right"> 45.5339720 </TD> <TD align="right"> -122.7115448 </TD> </TR>
  <TR> <TD align="right"> 45 </TD> <TD> Holman Ln </TD> <TD> NW 53rd Dr </TD> <TD align="right"> 45.5326348 </TD> <TD align="right"> -122.7317947 </TD> </TR>
  <TR> <TD align="right"> 46 </TD> <TD> Holman Ln </TD> <TD> NW Raleigh St </TD> <TD align="right"> 45.5336640 </TD> <TD align="right"> -122.7184113 </TD> </TR>
  <TR> <TD align="right"> 47 </TD> <TD> Aspen Trail  </TD> <TD> NW Aspen Ave </TD> <TD align="right"> 45.5362815 </TD> <TD align="right"> -122.7188578 </TD> </TR>
  <TR> <TD align="right"> 48 </TD> <TD> Birch Trail  </TD> <TD> NW 53rd Dr </TD> <TD align="right"> 45.5335168 </TD> <TD align="right"> -122.7329985 </TD> </TR>
  <TR> <TD align="right"> 49 </TD> <TD> Dogwood Trail </TD> <TD> NW 53rd Dr </TD> <TD align="right"> 45.5384279 </TD> <TD align="right"> -122.7341462 </TD> </TR>
  <TR> <TD align="right"> 50 </TD> <TD> Saltzman Rd </TD> <TD> NW Skyline Blvd </TD> <TD align="right"> 45.5619224 </TD> <TD align="right"> -122.7838819 </TD> </TR>
  <TR> <TD align="right"> 51 </TD> <TD> Saltzman Rd </TD> <TD> 6099 NW Saltzman Rd </TD> <TD align="right"> 45.5663350 </TD> <TD align="right"> -122.7533180 </TD> </TR>
  <TR> <TD align="right"> 52 </TD> <TD> Ridge Trail  </TD> <TD> 8545 NW Bridge Ave </TD> <TD align="right"> 45.5824650 </TD> <TD align="right"> -122.7680390 </TD> </TR>
  <TR> <TD align="right"> 53 </TD> <TD> Saltzman Rd </TD> <TD> Firelane 7 </TD> <TD align="right"> 45.5724040 </TD> <TD align="right"> -122.7907570 </TD> </TR>
  <TR> <TD align="right"> 54 </TD> <TD> Saltzman Rd </TD> <TD> NW Springville Rd </TD> <TD align="right"> 45.5844565 </TD> <TD align="right"> -122.7773362 </TD> </TR>
  <TR> <TD align="right"> 55 </TD> <TD> Waterline Rd </TD> <TD> NW Willalatin Rd </TD> <TD align="right"> 45.5802613 </TD> <TD align="right"> -122.7955563 </TD> </TR>
  <TR> <TD align="right"> 56 </TD> <TD> Tolinda Trail  </TD> <TD> NW Germantown Rd </TD> <TD align="right"> 45.5883661 </TD> <TD align="right"> -122.7786445 </TD> </TR>
  <TR> <TD align="right"> 57 </TD> <TD> Linnton Trail </TD> <TD> NW St Helens Rd </TD> <TD align="right"> 45.5963256 </TD> <TD align="right"> -122.7840361 </TD> </TR>
  <TR> <TD align="right"> 58 </TD> <TD> Newton Rd </TD> <TD> NW Skyline Blvd </TD> <TD align="right"> 45.5881356 </TD> <TD align="right"> -122.8058435 </TD> </TR>
  <TR> <TD align="right"> 59 </TD> <TD> BPA Road  </TD> <TD> NW Skyline Blvd </TD> <TD align="right"> 45.5917458 </TD> <TD align="right"> -122.8131039 </TD> </TR>
  <TR> <TD align="right"> 60 </TD> <TD> Firelane 1 </TD> <TD> NW Forest Ln </TD> <TD align="right"> 45.5476722 </TD> <TD align="right"> -122.7450699 </TD> </TR>
  <TR> <TD align="right"> 61 </TD> <TD> Firelane 2 </TD> <TD> NW Skyline Blvd </TD> <TD align="right"> 45.5471426 </TD> <TD align="right"> -122.7647506 </TD> </TR>
  <TR> <TD align="right"> 62 </TD> <TD> Firelane 3 </TD> <TD> NW Thunder Crest Dr </TD> <TD align="right"> 45.5528730 </TD> <TD align="right"> -122.7715260 </TD> </TR>
  <TR> <TD align="right"> 63 </TD> <TD> Firelane 8 </TD> <TD> NW Germantown Rd </TD> <TD align="right"> 45.5871410 </TD> <TD align="right"> -122.7961911 </TD> </TR>
  <TR> <TD align="right"> 64 </TD> <TD> Firelane 9 </TD> <TD> NW MacKay Ave </TD> <TD align="right"> 45.5939867 </TD> <TD align="right"> -122.7849507 </TD> </TR>
  <TR> <TD align="right"> 65 </TD> <TD> Firelane 10 </TD> <TD> Newton Rd </TD> <TD align="right"> 45.5915020 </TD> <TD align="right"> -122.8023951 </TD> </TR>
  <TR> <TD align="right"> 66 </TD> <TD> Firelane 10 </TD> <TD> NW Germantown Rd </TD> <TD align="right"> 45.5898750 </TD> <TD align="right"> -122.7909750 </TD> </TR>
  <TR> <TD align="right"> 67 </TD> <TD> Firelane 12 </TD> <TD> NW Creston Rd </TD> <TD align="right"> 45.6162383 </TD> <TD align="right"> -122.8074015 </TD> </TR>
  <TR> <TD align="right"> 68 </TD> <TD> Firelane 15 </TD> <TD> NW Skyline Blvd </TD> <TD align="right"> 45.5961899 </TD> <TD align="right"> -122.8235789 </TD> </TR>
   </TABLE>


Find the geographic mean of the waypoints. Use the geographic mean as a center point for grabbing the map.

```r
geomeanFP <- geomean(dfWaypoints[!is.na(dfWaypoints$lon) & !is.na(dfWaypoints$lat), 
    c("lon", "lat")])
geomeanFP
```

```
##           x     y
## [1,] -122.8 45.56
```

```r
mapFP <- get_map(location = geomeanFP, maptype = "terrain", source = "stamen", 
    zoom = 12)
```

```
## Map from URL : http://maps.googleapis.com/maps/api/staticmap?center=45.562541,-122.762536&zoom=12&size=%20640x640&maptype=terrain&sensor=false
## Google Maps API Terms of Service : http://developers.google.com/maps/terms
```

```r
ggmap(mapFP)
```

![plot of chunk mapForestParkBare](figure/mapForestParkBare.png) 


Plot the waypoints to use to identify if a run occurred inside Forest Park.

```r
color <- brewer.pal(9, "PiYG")[1]
g <- ggmap(mapFP, base_layer = ggplot(dfWaypoints, aes(x = lon, y = lat)))
g <- g + geom_point(color = color, size = 2)
g
```

![plot of chunk mapForestParkWaypoints](figure/mapForestParkWaypoints.png) 


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
message(sprintf("Reading %.0d routes run from %s to %s", length(files), dateFrom, 
    dateTo))
```

```
## Reading 495 routes run from 2011-08-24 to 2014-02-08
```

Consolidate routes in one data frame.

```r
index <- c()
date <- c()
lat <- c()
lon <- c()
for (i in 1:length(files)) {
    f <- file.path(path, files[i])
    route <- readGPX(f)
    location <- route$tracks[[1]][[1]]
    index <- c(index, rep(i, dim(location)[1]))
    date <- c(date, rep(as.Date(substr(files[i], 1, 8), format = "%Y%m%d"), 
        dim(location)[1]))
    lat <- c(lat, location$lat)
    lon <- c(lon, location$lon)
}
routes <- data.frame(cbind(index, date, lat, lon))
```


Cross join the routes with the waypoints. Use the `CJ` function from the data.table package. It has a performance edge over `merge`. Building the data frame from the cross join is the bottleneck, so print out a diagnostic.

```r
system.time(lookup <- CJ(rownumRoute = seq(1, nrow(routes)), rownumWaypoint = seq(1, 
    nrow(dfWaypoints))))
```

```
##    user  system elapsed 
##    0.45    0.02    0.47
```

```r
system.time(dfCJ <- data.frame(routes[lookup$rownumRoute, ], dfWaypoints[lookup$rownumWaypoint, 
    ]))
```

```
##    user  system elapsed 
##  415.43    3.62  421.31
```


Calculate distances from waypoints. I'll need to use the `distHaversine` function from the [geosphere](http://www.inside-r.org/packages/cran/geosphere) package. The Haversine algorithm isn't the most accurate, but it is good enough for this purpose.

```r
dist <- distHaversine(dfCJ[, c("lon", "lat")], dfCJ[, c("lon.1", "lat.1")])
dfCJ <- data.frame(dfCJ, dist)
```

Set the distance range in meters. Subset routes to those having at least one coordinate point within range from the central point.

```r
rangeDist <- 25
aggRoutes <- aggregate(dist ~ index, dfCJ, min)
includedRoutes <- aggRoutes$index[aggRoutes$dist < rangeDist]
routesInRange <- subset(routes, index %in% includedRoutes)
message(sprintf("Plotting %.0d routes within %.0d m of any waypoint", length(includedRoutes), 
    rangeDist))
```

```
## Plotting 88 routes within 25 m of any waypoint
```

Set titles for map.

```r
fmtDate <- "%d-%b-%Y"
title <- sprintf("Forest Park trail runs\n%.0d routes from %s to %s", length(includedRoutes), 
    format(dateFrom, fmtDate), format(dateTo, fmtDate))
```

Set map attributes. Pick an alpha that will distinguish frequently used trails. Pick a color that will contrast nicely with the green of the terrain map.

```r
alpha <- 1/9
color <- brewer.pal(9, "PiYG")[1]
size <- 1/4
theme <- theme(axis.text = element_blank(), axis.title = element_blank(), axis.ticks = element_blank())
```

Plot low resolution and high resolution versions of the routes. Only show the low resolution version. The high resolution version is saved for later.

```r
g <- ggmap(mapFP, base_layer = ggplot(routesInRange, aes(x = lon, y = lat, group = index)))
g <- g + geom_path(alpha = alpha, color = color, size = size)
g <- g + labs(title = title) + theme
g
```

![plot of chunk mapForestParkTrailRunsLowRes](figure/mapForestParkTrailRunsLowRes.png) 


```r
g <- ggmap(mapFP, base_layer = ggplot(routesInRange, aes(x = lon, y = lat, group = index)))
g <- g + geom_path(alpha = alpha, color = color, size = size)
g <- g + labs(title = title) + theme
g
```

