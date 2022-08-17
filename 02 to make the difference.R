
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
fles <- map(dirs, dir_ls)
fles <- flatten(fles)
fles <- grep('.tif$', fles, value = TRUE)
print(fles)

fles <- as.character(fles)
fles <- grep(paste0(c('suisse_paleo_tmean', 'suisse_current_tmean'), collapse = '|'), fles, value = T)

# Get the year of each file  ----------------------------------------------
year <- basename(fles) %>% str_split(pattern = '_') %>% map(., 4) %>% unlist() %>% unique()

# To calculate the difference ---------------------------------------------
bsln <- grep('+02000', fles, value = TRUE) %>% grep('current', ., value = TRUE)
bsln <- terra::rast(bsln)
plot(bsln[[1]])