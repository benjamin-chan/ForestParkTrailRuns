Forest Park Trail Runs
======================
Map trail running routes through [Forest Park](http://www.portlandoregon.gov/parks/finder/index.cfm?&propertyid=127&action=ViewPark).

Last updated 2014-02-13 06:07:40 using R version 3.0.2 (2013-09-25).


Load packages.

```r
packages <- c("RCurl", "plotKML", "geosphere", "ggmap", "ggplot2", "RColorBrewer", 
    "data.table")
sapply(packages, require, character.only = TRUE, quietly = TRUE)
```

```
## plotKML version 0.4-2 (2013-01-15) URL:
## http://plotkml.r-forge.r-project.org/
```

```
##        RCurl      plotKML    geosphere        ggmap      ggplot2 
##         TRUE         TRUE         TRUE         TRUE         TRUE 
## RColorBrewer   data.table 
##         TRUE         TRUE
```



Read coordinates for Forest Park waypoints.

```r
url <- getURL("https://docs.google.com/spreadsheet/pub?key=0ApyhYsT8Gi-EdFBUYk4wb0UyYlUweHg1SHlfX3VHV1E&single=true&gid=1&output=csv", 
    cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))
dfWaypoints <- read.csv(textConnection(url), header = TRUE)
dfWaypoints
```

```
##                  trail               waypoint   lat    lon
## 1       Wildwood Trail            Burnside Rd 45.52 -122.7
## 2       Wildwood Trail        Pittock Mansion 45.52 -122.7
## 3       Wildwood Trail             Cornell Rd 45.53 -122.7
## 4       Wildwood Trail Danford Balch Homesite 45.53 -122.7
## 5       Wildwood Trail              Holman Ln 45.53 -122.7
## 6       Wildwood Trail            Aspen Trail 45.54 -122.7
## 7       Wildwood Trail            Birch Trail 45.53 -122.7
## 8       Wildwood Trail      Wild Cherry Trail 45.54 -122.7
## 9       Wildwood Trail          Dogwood Trail 45.54 -122.7
## 10      Wildwood Trail             NW 53rd Dr 45.54 -122.7
## 11      Wildwood Trail            Alder Trail 45.54 -122.7
## 12      Wildwood Trail             Firelane 1 45.55 -122.7
## 13      Wildwood Trail         Chestnut Trail 45.55 -122.8
## 14      Wildwood Trail             Firelane 2 45.55 -122.8
## 15      Wildwood Trail            Maple Trail 45.55 -122.8
## 16      Wildwood Trail             Firelane 3 45.56 -122.8
## 17      Wildwood Trail            Saltzman Rd 45.57 -122.8
## 18      Wildwood Trail            Fire Lane 5 45.57 -122.8
## 19      Wildwood Trail            Oil Line Rd 45.57 -122.8
## 20      Wildwood Trail         Hardesty Trail 45.58 -122.8
## 21      Wildwood Trail      NW Springville Rd 45.58 -122.8
## 22      Wildwood Trail           Waterline Rd 45.58 -122.8
## 23      Wildwood Trail       NW Germantown Rd 45.59 -122.8
## 24      Wildwood Trail            Firelane 10 45.59 -122.8
## 25      Wildwood Trail              Newton Rd 45.60 -122.8
## 26      Wildwood Trail                 BPA Rd 45.60 -122.8
## 27      Wildwood Trail            Firelane 15 45.60 -122.8
## 28      Wildwood Trail         NW Newberry Rd 45.61 -122.8
## 29     Leif Erikson Dr          NW Thurman St 45.54 -122.7
## 30     Leif Erikson Dr      Wild Cherry Trail 45.54 -122.7
## 31     Leif Erikson Dr          Dogwood Trail 45.55 -122.7
## 32     Leif Erikson Dr            Alder Trail 45.55 -122.7
## 33     Leif Erikson Dr             Firelane 1 45.56 -122.7
## 34     Leif Erikson Dr             Firelane 2 45.56 -122.8
## 35     Leif Erikson Dr             Firelane 3 45.56 -122.8
## 36     Leif Erikson Dr            Saltzman Rd 45.57 -122.8
## 37     Leif Erikson Dr            Maple Trail 45.57 -122.8
## 38     Leif Erikson Dr         Hardesty Trail 45.58 -122.8
## 39     Leif Erikson Dr      NW Springville Rd 45.58 -122.8
## 40     Leif Erikson Dr           Waterline Rd 45.58 -122.8
## 41     Leif Erikson Dr       NW Germantown Rd 45.59 -122.8
## 42 Lower Macleay Trail           NW Upshur St 45.53 -122.7
## 43           Holman Ln             NW 53rd Dr 45.53 -122.7
## 44           Holman Ln          NW Raleigh St 45.53 -122.7
## 45        Aspen Trail            NW Aspen Ave 45.54 -122.7
## 46        Birch Trail              NW 53rd Dr 45.53 -122.7
## 47       Dogwood Trail             NW 53rd Dr 45.54 -122.7
## 48         Saltzman Rd        NW Skyline Blvd 45.56 -122.8
## 49         Saltzman Rd    6099 NW Saltzman Rd 45.57 -122.8
## 50        Ridge Trail      8545 NW Bridge Ave 45.58 -122.8
## 51         Saltzman Rd             Firelane 7 45.57 -122.8
## 52         Saltzman Rd      NW Springville Rd 45.58 -122.8
## 53        Waterline Rd       NW Willalatin Rd 45.58 -122.8
## 54      Tolinda Trail        NW Germantown Rd 45.59 -122.8
## 55       Linnton Trail        NW St Helens Rd 45.60 -122.8
## 56           Newton Rd        NW Skyline Blvd 45.59 -122.8
## 57           BPA Road         NW Skyline Blvd 45.59 -122.8
## 58          Firelane 1           NW Forest Ln 45.55 -122.7
## 59          Firelane 2        NW Skyline Blvd 45.55 -122.8
## 60          Firelane 3    NW Thunder Crest Dr 45.55 -122.8
## 61          Firelane 8       NW Germantown Rd 45.59 -122.8
## 62          Firelane 9          NW MacKay Ave 45.59 -122.8
## 63         Firelane 10              Newton Rd 45.59 -122.8
## 64         Firelane 10       NW Germantown Rd 45.59 -122.8
## 65         Firelane 12          NW Creston Rd 45.62 -122.8
## 66         Firelane 15        NW Skyline Blvd 45.60 -122.8
```


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
## Map from URL :
## http://maps.googleapis.com/maps/api/staticmap?center=45.563974,-122.763915&zoom=12&size=%20640x640&maptype=terrain&sensor=false
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

Set the date range. Use only the files within range. The dates of the files are determined from the file names.

```r
dateFrom <- as.Date("2013-01-01")
dateTo <- as.Date("2013-12-31")
dates <- as.Date(substr(files, 1, 8), format = "%Y%m%d")
isRangeDate <- dateFrom < dates & dates < dateTo
files <- files[isRangeDate]
message(sprintf("Reading %.0d routes run from %s to %s", length(files), dateFrom, 
    dateTo))
```

```
## Reading 212 routes run from 2013-01-01 to 2013-12-31
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
##    0.36    0.01    0.38
```

```r
system.time(dfCJ <- data.frame(routes[lookup$rownumRoute, ], dfWaypoints[lookup$rownumWaypoint, 
    ]))
```

```
## Warning: Reached total allocation of 3967Mb: see help(memory.size)
## Warning: Reached total allocation of 3967Mb: see help(memory.size)
## Warning: Reached total allocation of 3967Mb: see help(memory.size)
## Warning: Reached total allocation of 3967Mb: see help(memory.size)
## Warning: Reached total allocation of 3967Mb: see help(memory.size)
## Warning: Reached total allocation of 3967Mb: see help(memory.size)
```

```
## Error: cannot allocate vector of size 54.4 Mb
```

```
## Timing stopped at: 134.1 11.38 674.9
```


Calculate distances from waypoints. I'll need to use the `distHaversine` function from the [geosphere](http://www.inside-r.org/packages/cran/geosphere) package. The Haversine algorithm isn't the most accurate, but it is good enough for this purpose.

```r
dist <- distHaversine(dfCJ[, c("lon", "lat")], dfCJ[, c("lon.1", "lat.1")])
```

```
## Error: object 'dfCJ' not found
```

```r
dfCJ <- data.frame(dfCJ, dist)
```

```
## Error: object 'dfCJ' not found
```

Set the distance range in meters. Subset routes to those having at least one coordinate point within range from the central point.

```r
rangeDist <- 25
aggRoutes <- aggregate(dist ~ index, dfCJ, min)
```

```
## Error: object 'dfCJ' not found
```

```r
includedRoutes <- aggRoutes$index[aggRoutes$dist < rangeDist]
```

```
## Error: object 'aggRoutes' not found
```

```r
routesInRange <- subset(routes, index %in% includedRoutes)
```

```
## Error: object 'includedRoutes' not found
```

```r
message(sprintf("Plotting %.0d routes within %.0d m of any waypoint", length(includedRoutes), 
    rangeDist))
```

```
## Error: object 'includedRoutes' not found
```

Set titles for map.

```r
fmtDate <- "%d-%b-%Y"
title <- sprintf("Forest Park trail runs\n%.0d routes from %s to %s", length(includedRoutes), 
    format(dateFrom, fmtDate), format(dateTo, fmtDate))
```

```
## Error: object 'includedRoutes' not found
```

Set map attributes. Pick an alpha that will distinguish frequently used trails. Pick a color that will contrast nicely with the green of the terrain map.

```r
alpha <- 1/9
color <- brewer.pal(9, "PiYG")[1]
size <- 1/8
theme <- theme(axis.text = element_blank(), axis.title = element_blank(), axis.ticks = element_blank())
```

Plot low resolution and high resolution versions of the routes. Only show the low resolution version. The high resolution version is saved for later.

```r
g <- ggmap(mapFP, base_layer = ggplot(routesInRange, aes(x = lon, y = lat, group = index)))
```

```
## Error: object 'routesInRange' not found
```

```r
g <- g + geom_path(alpha = alpha, color = color, size = size)
g <- g + labs(title = title) + theme
g
```

```
## Error: cannot coerce type 'closure' to vector of type 'character'
```


```r
g <- ggmap(mapFP, base_layer = ggplot(routesInRange, aes(x = lon, y = lat, group = index)))
```

```
## Error: object 'routesInRange' not found
```

```r
g <- g + geom_path(alpha = alpha, color = color, size = size)
g <- g + labs(title = title) + theme
g
```

```
## Error: cannot coerce type 'closure' to vector of type 'character'
```

