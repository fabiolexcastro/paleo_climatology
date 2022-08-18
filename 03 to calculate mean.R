

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
dirs <- glue('{dirs}/suisse/difference')
map(dirs, dir_ls)