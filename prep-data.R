library(poispkgs)
library(lwgeom)

pals <- c(rgb(227, 94, 0, maxColorValue = 255), rgb(255, 255, 0, maxColorValue = 255))
get_color <- colorRampPalette(pals)
year.color <- get_color(n = length(unique(og$YearHarv)))
color.scheme <- tibble(Year = 1901:2017, Colour = year.color)

og <- st_read('input/log17-YearHarvest-OG-UTM8.shp') %>%
  st_make_valid %>%
  st_cast("POLYGON") %>%
  rmapshaper::ms_simplify(keep = 0.01) %>%
  st_transform(4326)

og %<>% left_join(color.scheme, c('YearHarv' = 'Year'))

sg <- st_read('input/log17-YearHarvest-SG-UTM8.shp') %>%
  st_make_valid %>%
  st_cast("POLYGON") %>%
  rmapshaper::ms_simplify(keep = 0.01) %>%
  st_transform(4326)

sg %<>% left_join(color.scheme, c('YearHarv' = 'Year'))

road <- st_read('input/log17-Roads-All-UTM8.shp') %>%
  st_make_valid %>%
  st_cast("LINESTRING") %>%
  rmapshaper::ms_simplify(keep = 0.01) %>%
  st_transform(4326)

road %<>% left_join(color.scheme, c('YearHarv' = 'Year'))

st_write(og, path.expand('~/Dropbox (Personal)/code/hg-logging-js/hg-logging-js/og.geojson'))
st_write(sg, path.expand('~/Dropbox (Personal)/code/hg-logging-js/hg-logging-js/sg.geojson'))
st_write(road, path.expand('~/Dropbox (Personal)/code/hg-logging-js/hg-logging-js/road.geojson'))


# centroid <- st_centroid(logged %>% st_union %>% st_geometry) %>% as.vector()

saveRDS(logged, 'input/logged.rds')
saveRDS(centroid %>% st_transform(4326) %>% st_coordinates, 'input/centroid.rds')

colour.pal <- read_delim('input/hg_movie_colours_2017.txt', delim = ' ')
colour.pal %<>% select(-X6, -blue) %>%
  rename(Index = `#`,
         Red = value, 
         Green = red, 
         Blue = green)
colour.pal$Year <- desc(1901:2017)

year.totals <- read_csv('input/year_totals.csv')

year.totals$Colour <- get_color(nrow(year.totals))
write_csv(year.totals, 'year_totals.csv')
write(year.totals %>% toJSON, 'year_totals.json')
