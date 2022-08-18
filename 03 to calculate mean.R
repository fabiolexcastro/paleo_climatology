

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
vles <- purrr::map(.x = 1:length(dirs), .f = function(i){
  
  cat(i, '\n')
  rst <- terra::rast(dirs[i])
  rst
  
  avg <- mean(rst)
  plot(avg)
  
  tbl <- terra::as.data.frame(avg, xy = TRUE)
  colnames(tbl) <- c('lon', 'lat', 'value')
  head(tbl)
  
  vle <- mean(pull(tbl, value))
  vle
  
  rsl <- tibble(name = basename(dirs[i]), value_change = vle)
  head(rsl)
  
  return(rsl)
  
})

vles <- bind_rows(vles)
vles <- as_tibble(vles)
vles <- mutate(vles, year = parse_number(name))
vles <- dplyr::select(vles, name, year, value_change)

dir_create('tbl/results')
write.csv(vles, 'tbl/results/time_line_difference.csv', row.names = FALSE)

# To make the graph
glne <- ggplot(data = vles, aes(x = year, y = value_change / 10)) + 
  geom_line(group = 1) + 
  labs(x = 'Year', y = 'Change value (\u00B0C)') + 
  theme_minimal() + 
  theme(panel.grid.minor = element_blank(), 
        axis.title.x = element_text(face = 'bold'), 
        axis.title.y = element_text(face = 'bold'))

glne

dir_create('png/graphs')
ggsave(plot = glne, filename = glue('png/graphs/g_line_v1.png'), units = 'in', width = 8, height = 6, dpi = 300)

# Secondary graph
gln2 <- ggplot(data = vles, aes(x = year, y = value_change / 10)) + 
  geom_line(group = 1) + 
  labs(x = 'Year', y = 'Change value (\u00B0C)') + 
  scale_x_continous(breaks = vles$value_change) +
  theme_minimal() + 
  theme(panel.grid.minor = element_blank(), 
        axis.title.x = element_text(face = 'bold'), 
        axis.title.y = element_text(face = 'bold'))

gln2



gln2 <- ggplot(data = vles, aes(x = year, y = value_change / 10)) + 
  geom_line(group = 1) + 
  labs(x = 'Year', y = 'Change value (\u00B0C)') + 
  scale_x_continous(breaks = vles$year) + 
  theme_minimal() + 
  theme(panel.grid.minor = element_blank(), 
        axis.text.x = element_text(angle = 90, hjust = 0.5),
        axis.title.x = element_text(face = 'bold'), 
        axis.title.y = element_text(face = 'bold'))



