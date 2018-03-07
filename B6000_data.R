# BIOME 6000 data setup 
# M. Walsh, March 2018

# Required packages
suppressPackageStartupMessages({
  require(downloader)
  require(dismo)
})

# set working directory
dir.create("biome6k", showWarnings = F)
setwd("./biome6k")

# Data setup --------------------------------------------------------------
# data download
download("https://www.dropbox.com/s/w2hywymboh8uwiy/B6000.csv.zip?raw=1", "B6000.csv.zip", mode = "wb")
unzip("B6000.csv.zip", overwrite = T)
biome <- read.table("B6000.csv", header = T, sep = ",")

# circles around lon/lat point coordinates <dismo>
locs <- biome[!duplicated(biome[1:2]), ]
buff <- dismo:::.generateCircles(locs[, c('lon','lat')], d=10000, lonlat=TRUE, crs=NA) 
# buff <- circles(locs[, c('lon','lat')], d=10000, lonlat=TRUE, dissolve=FALSE) ## alternatively
poly <- polygons(buff)
