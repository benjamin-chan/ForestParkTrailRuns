require(plotKML)
gpxWW <- readGPX("yassine WW double FKT.gpx")
dfWW <- gpxWW$tracks[[1]][[1]]
coordWW <- dfWW[, c("lon", "lat")]
require(geosphere)
geomeanWW <- geomean(coordWW)
geomeanWW
require(ggmap)
mapTerrain <- get_map(location=geomeanWW, maptype="terrain", source="stamen", zoom=12)
ggmap(mapTerrain)
