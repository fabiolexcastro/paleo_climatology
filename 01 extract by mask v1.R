

# Load libraries ----------------------------------------------------------
require(pacman)
pacman::p_load(terra, sf, tidyverse, rgeos, gtools, fs, glue)

g <- gc(reset = TRUE)
rm(list = ls())
options(scipen = 999, warn = -1)

# Function to use ---------------------------------------------------------
extract_mask <- function(pth){
  
  # Filtering and listing the files
  cat(pth, '\n')
  pth <- as.character(pth)
  fls <- dir_ls(pth)
  fls <- as.character(fls)
  fls <- grep('.tiff$', fls, value = TRUE)
  out <- unique(dirname(fls))
  out <- glue('{out}/suisse')
  dir_create(out)
  
  # To read as a terra/raster files
  trr <- purrr::map(.x = 1:length(fls), .f = function(i){
    
    cat(fls[i], '\n')
    rst <- terra::rast(fls[i])
    rst <- terra::crop(rst, zone)
    rst <- terra::mask(rst, zone)
    nme <- basename(fls[i])
    nme <- gsub('.tiff$', '.tif', nme)
    nme <- glue('suisse_{nme}')
    terra::writeRaster(x = rst, filename = glue('{out}/{nme}'), overwrite = TRUE)
    return(rst)
    
  })
  
  rm(fls, trr, out)
  cat('Done!\n')
  
}

# Load data ---------------------------------------------------------------
setwd('E:/climate_article')

zone <- terra::vect('suisse_shp/suisse.shp')
dirs <- dir_ls('SilvanaData', type = 'directory')

# Plotting the study zone 
plot(zone)

# To extract by mask  -----------------------------------------------------
purrr::map(.x = dirs, .f = extract_mask)







