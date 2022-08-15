

# Load libraries ----------------------------------------------------------
require(pacman)
pacman::p_load(terra, sf, tidyverse, rgeos, gtools, fs, glue)

g <- gc(reset = TRUE)
rm(list = ls())
options(scipen = 999, warn = -1)

# Load data ---------------------------------------------------------------
setwd('E:/climate_article')

zone <- terra::vect('suisse_shp/suisse.shp')
dirs <- dir_ls('SilvanaData', type = 'directory')

# Plotting the study zone 
plot(zone)

# Function to use ---------------------------------------------------------

# Proof
dir <- dirs[1]

extract_mask <- function(pth){
  
  cat(pth, '\n')
  pth <- as.character(pth)
  fls <- dir_ls(pth)
  fls <- as.character(fls)
  
  
}


