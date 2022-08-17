

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
dirs <- glue('{dirs}/suisse')
map(dirs, dir_ls)