

# Load libraries ----------------------------------------------------------
require(pacman)
pacman::p_load(terra, sf, tidyverse, rgeos, gtools, fs, glue)

g <- gc(reset = TRUE)
rm(list = ls())
options(scipen = 999, warn = -1)

# Load data ---------------------------------------------------------------
setwd('E:/climate_article')

dirs <- dir_ls('SilvanaData')
print(dirs)
dirs <- glue('{dirs}/suisse')
map(dirs, dir_ls)
dirs <- glue('{dirs}/difference')
dirs <- dirs[-grep('\\+02000', dirs, value = FALSE)]
dirs <- map(dirs, dir_ls)
dirs <- flatten(dirs)
dirs <- as.character(dirs)
print(dirs)

# Read as terra raster files
# Proof 
i <- 1

rstr <- purrr::map(.x = 1:length(dirs), .f = function(i){
  
  cat(i, '\n')
  rst <- terra::rast(dirs[i])
  rst
  
  avg <- maan(rst)
  plot(avg)
  
})